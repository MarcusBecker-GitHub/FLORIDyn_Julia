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
sim = Sim(1000.0, 4.0, length(0:4:1000), 6, 1.225, 0.1, length(e.turb),nC,nOP));

if con.init
    initStates!(e,u,ϕ,I0,sim);
end

function FLORIDyn(e,t,op,sim,con)
    for k ∈ 1:sim.nt
        # Calculate variables based on non-correcting states (x,y,z,dw,CT,γ)
        #   Wake shape

        #   Reduction

        #   Foreign reduction

        # Correction with EnKF
        #   use current data to correct states (u, φ, i)

        # Calculate output variables
        # P / effective wind speed

        # ==================================================================== #
        #                  PREDICTION FOR THE FOLLOWING TIMESTEP               #

        # Calculate step in wake coordinates

        #   apply in world coordinates

        #   shift & init non-correcting states (x,y,z,dw,CT,γ)
        #       apply sunflower distribution
        # Shift and init corrected states (u, φ, i)

    end
end
