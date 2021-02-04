# Structs for FLORIDyn
module FLORIDyn_Structs
export Ensemble, Turbine

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

end  # module FLORIDyn_Structs
