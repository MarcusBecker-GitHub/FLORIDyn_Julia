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
# Number of turbines / ensemble
nT  = 3; # TODO Load layout and extract number of turbines
# Number of chains / turbine
nC  = 50;
# Number of OPs/ chain
nOP = 100;

t   = allocTurbineStruct("3T_FarmConners",nE,nC,nOP);
op  = allocOPStruct(nE,nT,nC,nOP);
e   = allocEnsembleStruct(nE);
sim = allocSimStruct();
con = allocControl();

# Init layout

# Init state arrays
#   Turbine

#   OPs

# Init Control strategy

# Assembly of lists and states
timesteps = 1000;

function FLORIDyn(x_u, x_ϕ, x_i, timesteps)
    for k ∈ 1:timesteps
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
