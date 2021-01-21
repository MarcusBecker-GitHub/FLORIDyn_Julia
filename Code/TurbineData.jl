# Stored Data
module TurbineData
include("./FLORIDynStructs.jl")
using Main.FLORIDyn_Structs

#= Module to store turbine related data such as layouts, size and efficency.  =#
# Layouts (x1, y1, x2, y2, ...)
lyt_FC_1T = [954.5,954.5];
lyt_FC_3T = [954.5,954.5,1584.9,1584.9,2152.3,2278.4];
lyt_FC_9T = [954.5,954.5,1584.9,1584.9,2152.3,2278.4];
lyt_1T    = [0.0,0.0];

# Turbine data
DTU10MW = [119.0, 178.3, 1.0]


function getTurbineStruct(layout::String)
    if isequal(layout,"1FarmConners")

    elseif isequal(layout,"3FarmConners")

    elseif isequal(layout,"9FarmConner")

    elseif isequal(layout,"1DTU10MW")

    elseif isequal(layout,"2DTU10MW")

    elseif isequal(layout,"3DTU10MW")

    elseif isequal(layout,"9DTU10MW")

    end
    return -1;
end
# Ct(λ,β) & Cp(λ,β) look up tables


# Ct(u) & Cp(u) look up tables

end  # module TurbineData
