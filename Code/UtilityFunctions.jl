# Utility functions
module FLORIDyn_UtilityFunctions
export circleshift!


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
