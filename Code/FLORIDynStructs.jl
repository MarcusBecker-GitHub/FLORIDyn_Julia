# Structs for FLORIDyn
module FLORIDyn_Structs
export OP, T, E, Sim, Control
# OPs
struct OP
    # World coordinates
    x
    y
    z

    # Wake coordinates
    x1  # Down wind
    y1  # Cross wind
    # z1 == z  # height

    # Wind Field states
    u   # Wind speed
    ϕ   # Wind direction
    i0  # Ambient turbulence intensity

    # Chains
    pntr_c2op  # Pointer to the chain start in the OP arrays
    c_w     # Weights of the chain / relative area
    c_νy    # Relative y position in wake coordinates
    c_νz    # Relative z position in wake coordinates
end

# Turbines
struct T
    # Constants
    x   # World coordinate x
    y   # World coordinate y
    z   # Hub height
    D   # Diameter
    η   # Efficiency
    p_p # Power exponent

    # States
    Ct  # Thrust coefficient
    γ   # yaw angle
    Cp  # Power coefficient

    # Pointer
    pntr_t2c  # Pointer to first chain of each turbine
end

struct E
    pntr_e2t    # Pointer from the ensembles to the turbines
end
# Simulation data
struct Sim
    # Time
    t_end   # Duration
    Δt      # Timestep duration
    nt      # Number of timesteps

    # Gaussian Wake Model
    w       # WidthFactor

    # Environment
    ρ       # Air density
    α_s     # Shear coefficient (Atmospheric stability, Power law)
end

struct Control
    type :: String  # Name of control strategy
    init :: Bool    # Initialize values or not
end

end  # module FLORIDyn_Structs
