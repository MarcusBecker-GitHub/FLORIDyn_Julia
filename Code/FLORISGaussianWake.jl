# Gaussian Wake Model Equations
module GaussianWake

export crosswindstep, speedAtLocation, ambientTurbulenceAtLocation

# Potential Core length
function xc(D::Float64,γ::Float64,Ct::Float64,I::Float64,α::Float64,β::Float64)
    return (cos(γ)*(1+sqrt(1-Ct))/(sqrt(2)*(α*I+β*(1-sqrt(1-Ct)))))*D;
end

# Potential core radius (z1 and y1 direction)
function r_pc_z(D::Float64,γ::Float64,Ct::Float64,xc::Float64,x1::Float64)
    return D*sqrt((Ct*cos(γ))/(2*(1-sqrt(1-Ct*cos(γ)))*sqrt(1-Ct)))*(1-x1/xc);
end
function r_pc_y(D::Float64,γ::Float64,Ct::Float64,xc::Float64,x1::Float64)
    return r_pc_z*cos(γ);
end

# Wake width (z1 and y1 direction)
function σ(D::Float64,γ::Float64,x1::Float64,xc::Float64,k_z::Float64)
    σ_z = max(x1-xc,0.0)*k_y + min(x1/xc,1.0)*D/sqrt(8);
    σ_y = σ_z*cos(γ);
    return σ_y, σ_z
end
function (x1::Float64,xc::Float64,D::Float64,γ::Float64,k_y::Float64)
    return
end

# Expansion factor for the wake width
function k_exp(k_a::Float64,k_b::Float64,I::Float64)
    k_y = k_a*I + k_b;
    return k_y, k_y
end

# Deflection angle
function Θ(Ct::Float64,γ::Float64)
    return 0.3*γ/cos(γ)*(1-sqrt(1-Ct*cos(γ)));
end

# Deflection
function δ(Ct::Float64,D::Float64,γ::Float64,x1::Float64,xc::Float64,
            σ_y::Float64,σ_z::Float64,k_y::Float64,k_z::Float64)
    Θ = Θ(Ct,γ);
    # Near field
    δ_nfw  = Θ*min(x1,xc);
    # Far field
    δ_ff_1 = Θ/14.7*sqrt(cos(γ)/(k_y*k_z*Ct))*(2.9+1.3*sqrt(1-Ct)-Ct);
    δ_ff_2 = log((1.6+sqrt(Ct))*(1.6*sqrt((8*σ_y*σ_z)/(D^2*cos(γ)))-sqrt(Ct))/
                ((1.6-sqrt(Ct))*(1.6*sqrt((8*σ_y*σ_z)/(D^2*cos(γ)))+sqrt(Ct))));
    return δ_nfw + (sign(x1-xc)/2.0+0.5)*δ_ff_1*δ_ff_2*D;
end

# Effective turbulence intensity
function I_f(Ct::Float64,I0::Float64,x1::Float64,D::Float64,k_ia::Float64,
                k_ib::Float64,k_ic::Float64,k_id::Float64)
    # Convert Ct to a
    a = 0.5*(1-sqrt(1-Ct));
    if a<0.0 or a>.5 # Upper bound is an educated guess
        error("Foreign Turbulence Intensity calcualtion: Ct coefficient out of
        range for conversion to axial induction factor: a = $a");
    end
    return k_ia*a^k_ib*I0^k_ic*(x1/D)^k_id;
end
# Effective turbulence intensity
function eff_I(I0::Float64,I_f::Float64)
    return sqrt(I_f^2 + I_0^2);
end

# Calculate crosswind step
function crosswindstep(Δx1,x1,y1,z,Ct,γ,I,ν_y,ν_z,D,w,FConst)
    #   change x1,y1,z and return Δy1 which will be applied to the real world
    #   coordinates

    # Potential core length
    xc      = xc(D,γ,Ct,I,FConst.α,FConst.β);

    # Expansion factors
    k_y,k_z = k_exp(FConst.k_a,FConst.k_b,I);

    # σ_y, σ_z of the new down wind position
    σ_y, σ_z = σ(x1+Δx1,xc,D,γ,k_y,k_z);

    # Deflection
    δ = δ(Ct,D,γ,x1+Δx1,xc,σ_y,σ_z,k_y,k_z);

    # Differences in crosswind position old vs new
    Δy1 = σ_y*w*ν_y + δ - y1;
    Δz  = σ_z*w*ν_z - z;
    return Δy1, Δz
end

function speedAtLocation(args)
    # Return the speed at a location, meant for rotor plane and plotting
    body
end

function ambientTurbulenceAtLocation(args)
    # Return turbulence level at a given location, meant for rotor plane
    I_f = I_f(Ct,I0,x1,D,
                FConst.k_ia,
                FConst.k_ib,
                FConst.k_ic,
                FConst.k_id);
    I   = eff_I(I0,I_f);

    body
end
end  # module GaussianWake
