# Structs for FLORIDyn
module FLORIDyn_Structs
export Ensemble, Turbine, Constants, Control, Sim, FLORISConst

# Ensembles contain simulation variables

struct Ensemble
    turb        # Turbines
    constants   # turbine and chain constants
end

struct Constants
    # Turbine constants
    t_D
    t_η
    t_p_p
    # Chain constants
    c_w
    c_νy
    c_νz

    # Floris
    FLORIS
end

struct Turbine
    # TURBINE
    # Constants
    x   # World coordinate x
    y   # World coordinate y
    z   # Hub height

    ttype # Turbine type

    # States
    Ct  # Thrust coefficient
    γ   # yaw angle
    Cp  # Power coefficient
    I   # (effective) Ambient turbulence

    # OBSERVATION POINTS
    # World coordinates
    op_x    # [nOP x nC]
    op_y    # [nOP x nC]
    op_z    # [nOP x nC]
    # Wake coordinates
    op_x1   # [nOP x nC]
    op_y1   # [nOP x nC]
    # Wind field states coordinates
    op_u    # [nOP x nC]
    op_ϕ    # [nOP x nC]
    op_I0   # [nOP x nC]
end

struct Control
    type :: String  # Name of control strategy
    init :: Bool    # Initialize values or not
end

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

    # Settings Ensemble
    nT
    nC
    nOP
end

struct FLORISConst
    α   :: Float64     # Potential core
    β   :: Float64     # Potential core
    k_a :: Float64     # Wake width / Expansion
    k_b :: Float64     # Wake width / Expansion
    # Added turbulence
    k_ia :: Float64    # Overall weight
    k_ib :: Float64    # Axial induction weight
    k_ic :: Float64    # Ambient turbulence level weight
    k_id :: Float64   # Distance to turbine weight
end  # module FLORIDyn_Structs
