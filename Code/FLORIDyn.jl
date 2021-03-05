# New FLORIDyn implementation in Julia
# Changes
#   - No separate wind field
#   - Ct and γ as turbine states
#   - OPs have wind field as states as well as the four coordinates
#   - Ensemble Kalman Filter design
#   - Better storage management
include("./FLORIDynStructs.jl")
include("./UtilityFunctions.jl")
include("./InitStructs.jl")


using Main.FLORIDyn_Structs
using Main.FLORIDyn_UtilityFunctions
using Main.FLORIDyn_InitStructs
# Number of ensembles
nE  = 1;
# Number of chains / turbine
nC  = 50;
# Number of OPs/ chain
nOP = 100;

# Init Ensembles, Control settings and simulation settings
e   = InitEnsemble("3T_DTU10MW",nC,nOP);
con = Control("Axial induction",true);
sim = Sim(1000.0, 4.0, length(0:4:1000), 6, 1.225, 0.1, length(e.turb),nC,nOP);

if con.init
    u  = 8;
    ϕ  = 10/180*π;
    I0 = 0.05;
    Ct = 4*0.33*(1-0.33);
    Cp = 4*0.33*(1-0.33)^2;
    γ  = 10/180*π;
    initStates!(e,sim,u,ϕ,I0,Ct,γ,Cp);
end

function FLORIDyn(e,sim,con)
    for k ∈ 1:sim.nt
        # Calculate variables based on non-correcting states (x,y,z,dw,CT,γ)
        #   Wake shape
        # TODO
        #   Reduction
        # TODO
        #   Foreign reduction
        #  OPs at the rotorplane have to find their closest neighbours in
        #  foreign wakes tyo calculate the interaction
        #       Idea: use first chain (center) to get rough index where to look
        #       look for closest OPs
        # Step 1: Determine relevant turbines

        # Step 2: Determine clostest OP

        # Step 3: Calculate influence in foreign wake coordinates
        #   Speed reduction

        #   Added turbulence
        I_f = I_f(Ct,I0,x1,D,
                    FConst.k_ia,
                    FConst.k_ib,
                    FConst.k_ic,
                    FConst.k_id);
        # TODO
        # Correction with EnKF
        #   use current data to correct states (u, φ, i)
        # TODO
        # Calculate output variables
        # P / effective wind speed
        # TODO

        # ==================================================================== #
        #                  PREDICTION FOR THE FOLLOWING TIMESTEP               #
        for t ∈ e.turb
            # Update and overwrite
            # Go through all OPs backwards and overwrite the following entry
            for i_c ∈ 1:size(t.op_x,2), i_op ∈ size(t.op_x,1)-1:-1:1
                # Update of the wake coordinates
                Δx1 = sim.Δt*t.op_u[i_op,i_c];
                Δy1, Δz = crosswindstep(Δx1,
                                        t.op_x1[i_op,i_c],
                                        t.op_y1[i_op,i_c],
                                        t.op_z[i_op,i_c],
                                        t.Ct[i_op],
                                        t.γ[i_op],
                                        t.I[i_op],
                                        e.constants.c_νy[i_c],
                                        e.constants.c_νz[i_c],
                                        e.constants.t_D[t.ttype],
                                        e.constants.c_w[i_c],
                                        e.constants.FLORIS);

                # Update and shift of the world coordinates
                t.op_x[i_op + 1,i_c] = t.op_x[i_op,i_c] +
                                        cos(t.op_ϕ)*Δx1 + sin(t.op_ϕ)*Δy1;
                t.op_y[i_op + 1,i_c] = t.op_y[i_op,i_c] +
                                        -sin(t.op_ϕ)*Δx1 + cos(t.op_ϕ)*Δy1;
                t.op_z[i_op + 1,i_c] = t.op_z[i_op,i_c] + Δz;

                # Update and shift of the wake coordinates
                t.op_x1[i_op + 1,i_c] = t.op_x1[i_op,i_c] + Δx1;
                t.op_y1[i_op + 1,i_c] = t.op_y1[i_op,i_c] + Δy1;

                # Shitft the states
                t.op_u[i_op + 1,i_c]  = t.op_u[i_op,i_c];
                t.op_ϕ[i_op + 1,i_c]  = t.op_ϕ[i_op,i_c];
                t.op_I0[i_op + 1,i_c] = t.op_I0[i_op,i_c];
            end

            # Shift turbine states
            t.Ct[2:end] = t.Ct[1:end-1];
            t.γ[2:end]  = t.γ[1:end-1];
            t.I[2:end]  = t.I[1:end-1];

            # Init non-correcting states (Ct,γ,Cp)
            a = 1/3;
            γ = 0;
            t.Ct[1] = 4*a*(1-a);
            t.γ[1]  = 0;
            t.Cp[1] = 4*a*(1-a)^2;
            #t.I[1]  = t.I[1:end-1];
        end
        #   shift & init non-correcting states (x,y,z,dw,CT,γ)
        #       apply sunflower distribution
        # Shift and init corrected states (u, φ, i)
        # TODO
    end
    print("Simulation done.")
end


# TODO Check out color package
# https://github.com/JuliaGraphics/ColorSchemes.jl
