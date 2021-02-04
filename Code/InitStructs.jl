# Stored Data
module FLORIDyn_InitStructs
include("./FLORIDynStructs.jl")
using Main.FLORIDyn_Structs

export allocTurbineStruct, allocOPStruct, allocEnsembleStruct
export allocChainStruct

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
DTU10MW = [119.0, 178.4, 1.08, 1.5]
InnWind = [119.0, 178.3, 1.08, 1.5]

function InitEnsemble(layout,nC,nOP)
    # Load layout
    if layout == "1T_FarmConners"
        lyt     = lyt_FC_1T;
        t_id    = ones(Int8,1);
        turb    = InnWind;
    elseif layout == "3T_FarmConners"
        lyt     = lyt_FC_3T;
        t_id    = ones(Int8,3);
        turb    = InnWind;
    elseif layout == "9T_FarmConners"
        lyt     = lyt_FC_9T;
        t_id    = ones(Int8,9);
        turb    = InnWind;
    elseif layout == "1T_DTU10MW"
        lyt     = lyt_1T;
        t_id    = ones(Int8,3);
        turb    = DTU10MW;
    elseif layout == "2T_DTU10MW"
        lyt     = lyt_2T;
        t_id    = ones(Int8,2);
        turb    = DTU10MW;
    elseif layout == "3T_DTU10MW"
        lyt     = lyt_3T;
        t_id    = ones(Int8,3);
        turb    = DTU10MW;
    elseif layout == "9T_DTU10MW"
        lyt     = lyt_9T;
        t_id    = ones(Int8,9);
        turb    = DTU10MW;
    else
        error("Unknown layout, please choose a known name.")
    end

    #   determine nT
    nT = length(lyt)
    #   Create turbine array
    turbines = [];
    for iT = 1:nT
        push!(turbines,
            Turbine(
                lyt[iT],    # x
                lyt[iT+1],  # y
                turb[1],    # z
                t_id[iT],   # ttype
                zeros(nOP), # Ct
                zeros(nOP), # γ
                zeros(1),   # Cp
                zeros(nOP,nC) # op_x
                zeros(nOP,nC) # op_y
                zeros(nOP,nC) # op_z
                zeros(nOP,nC) # op_x1
                zeros(nOP,nC) # op_y1
                zeros(nOP,nC) # op_u
                zeros(nOP,nC) # op_φ
                zeros(nOP,nC) # op_I0
            );
    end

    cConst = generateChainConstants(nC);
    cnst = Constants(
            turb[2:4:end],  # t_D
            turb[3:4:end],  # t_η
            turb[4:4:end],  # t_p_p
            cConst[:,1],    # c_w
            cConst[:,2],    # c_νy
            cConst[:,3]);   # c_νz
    # Init E
    e = Ensemble(turbines);
    return e;
end

function generateChainConstants(nC)
    body
end

end  # module FLORIDyn_InitStructs
