# Utility functions
module FLORIDyn_UtilityFunctions
export circleshift!

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
