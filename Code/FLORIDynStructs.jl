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
end

struct C
    c_w     # Weights of the chain / relative area
    c_νy    # Relative y position in wake coordinates
    c_νz    # Relative z position in wake coordinates

    # Pointer to the chain start in the OP arrays
    #   E1:
    #       t1:
    #           c1->OP1
    #           c2->OP1
    #           c2->OP1
    #       t2:
    #           c1->OP1
    #           c2->OP1
    #           c2->OP1
    #   E2:
    #       t1:
    #           c1->OP1
    #           c2->OP1
    #           c2->OP1
    #       t2:
    #           c1->OP1
    #           c2->OP1
    #           c2->OP1
    pntr_c2op 
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

    # Pointer to chain
    #   E1:
    #       t1->c1
    #       t2->c1
    #       t3->c1
    #   E2:
    #       t1->c1
    #       t2->c1
    #       t3->c1
    pntr_t2c
end

struct E
     # Pointer from the ensembles to the first turbine of the ensemble
     # E1 -> T1,C1
     # E2 -> T1,C1
    pntr_e2c
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
