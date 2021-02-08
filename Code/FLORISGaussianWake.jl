# Gaussian Wake Model Equations
module GaussianWake

# Potential Core length
function xc(D,γ,Ct,I,α,β)
    return (cos(γ)*(1+sqrt(1-Ct))/(sqrt(2)*(α*I+β*(1-sqrt(1-Ct)))))*D;
end

# Potential core radius (z1 and y1 direction)
function r_pc_z(D,γ,Ct,xc,x1)
    return D*sqrt((Ct*cos(γ))/(2*(1-sqrt(1-Ct*cos(γ)))*sqrt(1-Ct)))*(1-x1/xc);
end
function r_pc_y(D,γ,Ct,xc,x1)
    return r_pc_z*cos(γ);
end

# Wake width (z1 and y1 direction)
function σ_z(D,γ,x1,xc,k_z)
    return max(x1-xc,0.0)*k_y + min(x1/xc,1.0)*D/sqrt(8)
end
function σ_y(x1::Float64,xc::Float64,D::Float64,γ::Float64,k_y::Float64)
    return σ_z(x1,xc,D,γ,k_y)*cos(γ);
end
# Expansion factor for the wake width
function k_y(k_a::Float64,k_b::Float64,I::Float64)
    return k_a*I + k_b;
end

# Deflection angle
function Θ(Ct,γ)
    return 0.3*γ/cos(γ)*(1-sqrt(1-Ct*cos(γ)));
end
# Deflection
function δ(Θ)
    # Near field
    δ_nfw  = Θ*min(x1,xc);
    # Far field
    δ_ff_1 = Θ/14.7*sqrt(cos(γ)/(k_y*k_z*Ct))*(2.9+1.3*sqrt(1-Ct)-Ct);
    δ_ff_2 = log((1.6+sqrt(Ct))*(1.6*sqrt((8*σ_y*σ_z)/(D^2*cos(γ)))-sqrt(Ct))/
                ((1.6-sqrt(Ct))*(1.6*sqrt((8*σ_y*σ_z)/(D^2*cos(γ)))+sqrt(Ct))));
    return δ_nfw + (sign(x1-xc)/2.0+0.5)*δ_ff_1*δ_ff_2*D;
end
end  # module GaussianWake
