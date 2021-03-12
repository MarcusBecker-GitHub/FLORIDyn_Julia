# Utility functions
module FLORIDyn_UtilityFunctions
export circleshift!

function getRelevantTurbines(t,ϕ)
    # Sets all relevant turbines to TRUE
    relevant = falses(length(t),length(t));

    return relevant
end
# TODO Should be replaced by a version which only shifts down and does not
# Schange the first entry
function circleshift!(a::AbstractVector, shift::Integer)
    # True inplace version of circshift!()
    n = length(a)
    s = mod(shift, n)
    s == 0 && return a
    reverse!(a, 1, s)
    reverse!(a, s+1, n)
    reverse!(a)
end

end  # module FLORIDyn_UtilityFunctions
