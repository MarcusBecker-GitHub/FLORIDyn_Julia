# Stored Data
module FLORIDyn_InitStructs
include("./FLORIDynStructs.jl")
using Main.FLORIDyn_Structs

export allocTurbineStruct, allocOPStruct, allocEnsembleStruct
export allocSimStruct, allocControl

#= Module to store turbine related data such as layouts, size and efficency.  =#
# Layouts (x1, y1, x2, y2, ...)
lyt_FC_1T = [954.5,954.5];
lyt_FC_3T = [954.5,954.5,1584.9,1584.9,2152.3,2278.4];
lyt_FC_9T = [2143.3,378.2,3025.9,1260.8,3908.4,2143.3,
            1260.8, 1260.8,2143.3,2143.3,3025.9,3025.9,
            278.2,2143.3,1260.8,3025.9,2143.3,3908.4];
lyt_1T    = [500.0,500.0];
lyt_2T    = [400.0,500.0,1300.0,500.0];
lyt_3T    = [608.0,1500.0,1500.0,1500.0,2392.0,1500.0];
lyt_9T    = [600.0,600.0,1500.0,600.0,2400.0,
            600.0,1500.0,1500.0,1500.0,2400.0,1500.0,
            600.0,2400.0,1500.0,2400.0,2400.0,2400.0];
# Turbine data (z,D,η,p_p)
DTU10MW = [119.0, 178.3, 1.08, 1.5]


function allocTurbineStruct(layout::String,nE::Integer,nC::Integer,nOP::Integer)
    if isequal(layout,"1T_FarmConners")
        nT = 1;
        t = T(
            lyt_FC_1T[1],       # x
            lyt_FC_1T[2],       # y
            DTU10MW[1],         # z/HubHeight
            DTU10MW[2],         # D
            DTU10MW[3],         # η
            DTU10MW[4],         # p_p
            zeros(nOP*nT),      # Ct
            zeros(nOP*nT),      # γ
            zeros(nT),          # Cp
            zeros(nT));         # Pointer to first chain of each turbine
        return t
    elseif isequal(layout,"3T_FarmConners")
        nT = 3;
        t = T(
            lyt_FC_3T[1:2:end],     # x
            lyt_FC_3T[2:2:end],     # y
            ones(nT).*DTU10MW[1],   # z/HubHeight
            ones(nT).*DTU10MW[2],   # D
            ones(nT).*DTU10MW[3],   # η
            ones(nT).*DTU10MW[4],   # p_p
            zeros(nOP*nT),          # Ct
            zeros(nOP*nT),          # γ
            zeros(nT),              # Cp
            zeros(nT));             # Pointer to first chain of each turbine
        return t
    elseif isequal(layout,"9T_FarmConner")
        nT = 9;
        t = T(
            lyt_FC_9T[1:2:end],     # x
            lyt_FC_9T[2:2:end],     # y
            ones(nT).*DTU10MW[1],   # z/HubHeight
            ones(nT).*DTU10MW[2],   # D
            ones(nT).*DTU10MW[3],   # η
            ones(nT).*DTU10MW[4],   # p_p
            zeros(nOP*nT),          # Ct
            zeros(nOP*nT),          # γ
            zeros(nT),              # Cp
            zeros(nT));             # Pointer to first chain of each turbine
        return t
    elseif isequal(layout,"1T_DTU10MW")
        nT = 2;
        t = T(
            lyt_2T[1:2:end],        # x
            lyt_2T[2:2:end],        # y
            ones(nT).*DTU10MW[1],   # z/HubHeight
            ones(nT).*DTU10MW[2],   # D
            ones(nT).*DTU10MW[3],   # η
            ones(nT).*DTU10MW[4],   # p_p
            zeros(nOP*nT),          # Ct
            zeros(nOP*nT),          # γ
            zeros(nT),              # Cp
            zeros(nT));             # Pointer to first chain of each turbine
        return t
    elseif isequal(layout,"2T_DTU10MW")
        nT = 2;
        t = T(
            lyt_2T[1:2:end],        # x
            lyt_2T[2:2:end],        # y
            ones(nT).*DTU10MW[1],   # z/HubHeight
            ones(nT).*DTU10MW[2],   # D
            ones(nT).*DTU10MW[3],   # η
            ones(nT).*DTU10MW[4],   # p_p
            zeros(nOP*nT),          # Ct
            zeros(nOP*nT),          # γ
            zeros(nT),              # Cp
            zeros(nT));             # Pointer to first chain of each turbine
        return t
    elseif isequal(layout,"3T_DTU10MW")
        nT = 3;
        t = T(
            lyt_3T[1:2:end],        # x
            lyt_3T[2:2:end],        # y
            ones(nT).*DTU10MW[1],   # z/HubHeight
            ones(nT).*DTU10MW[2],   # D
            ones(nT).*DTU10MW[3],   # η
            ones(nT).*DTU10MW[4],   # p_p
            zeros(nOP*nT),          # Ct
            zeros(nOP*nT),          # γ
            zeros(nT),              # Cp
            zeros(nT));             # Pointer to first chain of each turbine
        return t
    elseif isequal(layout,"9T_DTU10MW")
        nT = 9;
        t = T(
            lyt_9T[1:2:end],        # x
            lyt_9T[2:2:end],        # y
            ones(nT).*DTU10MW[1],   # z/HubHeight
            ones(nT).*DTU10MW[2],   # D
            ones(nT).*DTU10MW[3],   # η
            ones(nT).*DTU10MW[4],   # p_p
            zeros(nOP*nT),          # Ct
            zeros(nOP*nT),          # γ
            zeros(nT),              # Cp
            zeros(nT));             # Pointer to first chain of each turbine
        return t
    end
    return -1;
end

function allocOPStruct(nE,nT,nC,nOP)
    op = OP(
        zeros(nE*nT*nC*nOP),    # x
        zeros(nE*nT*nC*nOP),    # y
        zeros(nE*nT*nC*nOP),    # z
        zeros(nE*nT*nC*nOP),    # x1
        zeros(nE*nT*nC*nOP),    # y1
        zeros(nE*nT*nC*nOP),    # u
        zeros(nE*nT*nC*nOP),    # φ
        zeros(nE*nT*nC*nOP),    # i0
        zeros(nE*nT*nC),        # pntr_c2op
        zeros(nC),              # c_w
        zeros(nC),              # c_νy
        zeros(nC));             # c_νz
    return op
end

function allocEnsembleStruct(nE)
    e = E(zeros(nE));
    return e
end

function allocSimStruct()
    sim = Sim(
        0.0,    # t_end
        0.0,    # Δt
        0,      # nt
        0.0,    # w
        0.0,    # ρ
        0.0);   # α_s
    return sim
end

function allocControl()
    control = Control("",false);
    return control
end
# Ct(λ,β) & Cp(λ,β) look up tables


# Ct(u) & Cp(u) look up tables

end  # module FLORIDyn_InitStructs
