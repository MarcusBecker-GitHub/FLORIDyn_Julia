# Stored Data
module TurbineData
include("./FLORIDynStructs.jl")
using Main.FLORIDyn_Structs

#= Module to store turbine related data such as layouts, size and efficency.  =#
# Layouts (x1, y1, x2, y2, ...)
lyt_FC_1T = [954.5,954.5];
lyt_FC_3T = [954.5,954.5,1584.9,1584.9,2152.3,2278.4];
lyt_FC_9T = [2143.3,378.2,3025.9,1260.8,3908.4,2143.3,
            1260.8, 1260.8,2143.3,2143.3,3025.9,3025.9,
            278.2,2143.3,1260.8,3025.9,2143.3,3908.4];
lyt_1T    = [0.0,0.0];

# Turbine data (z,D,η,p_p)
DTU10MW = [119.0, 178.3, 1.08, 1.5]


function getTurbineStruct(layout::String,nE::Integer,nC::Integer,nOP::Integer)
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

    elseif isequal(layout,"2T_DTU10MW")

    elseif isequal(layout,"3T_DTU10MW")

    elseif isequal(layout,"9T_DTU10MW")

    end
    return -1;
end
# Ct(λ,β) & Cp(λ,β) look up tables


# Ct(u) & Cp(u) look up tables

end  # module TurbineData
