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
function δ(Θ,Ct,D,γ,x1,xc,σ_y,σ_z,k_y,k_z)
    # Near field
    δ_nfw  = Θ*min(x1,xc);
    # Far field
    δ_ff_1 = Θ/14.7*sqrt(cos(γ)/(k_y*k_z*Ct))*(2.9+1.3*sqrt(1-Ct)-Ct);
    δ_ff_2 = log((1.6+sqrt(Ct))*(1.6*sqrt((8*σ_y*σ_z)/(D^2*cos(γ)))-sqrt(Ct))/
                ((1.6-sqrt(Ct))*(1.6*sqrt((8*σ_y*σ_z)/(D^2*cos(γ)))+sqrt(Ct))));
    return δ_nfw + (sign(x1-xc)/2.0+0.5)*δ_ff_1*δ_ff_2*D;
end

# Effective turbulence intensity
function I_f(Ct,I0,x1,D,k_ia,k_ib,k_ic,k_id)
    # Convert Ct to a
    a = 0.5*(1-sqrt(1-Ct));
    if a<0.0 or a>.5 # Upper bound is an educated guess
        error("Foreign Turbulence Intensity calcualtion: Ct coefficient out of range for conversion to axial induction factor: a = $a")
    end
    return k_ia*a^k_ib*I0^k_ic*(x1/D)^k_id;
end
# Effective turbulence intensity
function eff_I(I0::Float64,I_f::Float64)
    return sqrt(I_f^2 + I_0^2);
end

# Calculate crosswind step
function crosswindstep!(Δx1,x1,y1,z,Ct,γ,ν_y,ν_z,D,w)
    #   change x1,y1,z and return Δy1 which will be applied to the real world
    #   coordinates
    # Calculate the new σ_y, σ_z of the new down wind position

    # Calculate crosswind position and change y1, z & Δy1

    return Δy1
end

function speedAtLocation(args)
    # Return the speed at a location
    body
end
end  # module GaussianWake
