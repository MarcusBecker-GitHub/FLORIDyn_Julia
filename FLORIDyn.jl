# New FLORIDyn implementation in Julia
# Changes
#   - No separate wind field
#   - Ct and γ as turbine states
#   - OPs have wind field as states as well as the four coordinates
#   - Ensemble Kalman Filter design
#   - Better storage management

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

a1 = 3
a2 = [1,2,3]

function f1(x)
    x = x + 1
end

function f2(x)
    x[1] = x[1]+1
end

f1(a1);
f2(a2);
print(a1,a2)

function circleshift!(a::AbstractVector, shift::Integer)
    n = length(a)
    s = mod(shift, n)
    s == 0 && return a
    reverse!(a, 1, s)
    reverse!(a, s+1, n)
    reverse!(a)
end
