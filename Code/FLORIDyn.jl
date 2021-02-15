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

function FLORIDyn(e,t,op,sim,con)
    for k ∈ 1:sim.nt
        # Calculate variables based on non-correcting states (x,y,z,dw,CT,γ)
        #   Wake shape
        # TODO
        #   Reduction
        # TODO
        #   Foreign reduction
        #       Idea: use first chain (center) to get rough index where to look
        #       look for closest OPs
        #   LAST THING TO IMPLEMENT
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
            # Go through all OPs backwards and overwrite the following entry
            for i_c ∈ 1:size(t.op_x,2), i_op ∈ size(t.op_x,1)-1:-1:1
                # Update of the wake coordinates
                Δx1 = sim.Δt*t.op_u[i_op,i_c];
                Δy1 = crosswindstep!(Δx1,x1,y1,z,Ct,γ,ν_y,ν_z,D,w);

                # Update of the world coordinates
                t.op_x[i_op + 1,i_c] = t.op_x[i_op,i_c] +
                                        cos(t.op_ϕ)*Δx1 + sin(t.op_ϕ)*Δy1;
                t.op_y[i_op + 1,i_c] = t.op_y[i_op,i_c] +
                                        -sin(t.op_ϕ)*Δx1 + cos(t.op_ϕ)*Δy1;

                # Shitft the states
                t.op_ϕ[i_op + 1,i_c]  = t.op_ϕ[i_op,i_c];
                t.op_I0[i_op + 1,i_c] = t.op_I0[i_op,i_c];
            end

            # Shift turbine states
        end
        #   shift & init non-correcting states (x,y,z,dw,CT,γ)
        #       apply sunflower distribution
        # Shift and init corrected states (u, φ, i)
        # TODO
    end
end
