using Plots
using GR

function LBM25Lines()
    ## Sébastien Leclaire [2014] This LBM code was inspired from Iain Haslam [http://exolete.com/lbm/]
    # Constants
    #   Area size
    NX = 32;
    NY = 32;
    OMEGA   = 1.0;
    rho0    = 1.0;      # Initial distribution
    deltaUX = 10^-6;    # basic speed in x direction

    # Directions for 2D9
    #   weights
    W   =[4/9,1/9,1/36,1/9,1/36,1/9,1/36,1/9,1/36]
    #   directions
    cx  =[0,0,1,1, 1, 0,-1,-1,-1];
    cy  =[0,1,1,0,-1,-1,-1, 0, 1];

    # Generate random environment
    SOLID = rand(NX * NY, 1) .> 0.7;

    # Allocation/ Initialization of paticle density in all 9 directions
    N = broadcast(*,W',rho0*ones(NX*NY,9))


    travelVec = collect(1:NX*NY*9);
    for i ∈ 2:9
        b = (i-1)*NX*NY+1;
        e = i*NX*NY;
        travelVec[b:e] =
            circshift(reshape(travelVec[b:e],NX,NY),[cx[i],cy[i]])[:];
    end

    for t_ = 1:4000
        # Transport
        #=
        for i=2:9
            # Extract direction
            # Let particles travel in said direction
            # Store direction again
            N[:,i]=reshape(circshift(reshape(N[:,i],NX,NY),[cx[i],cy[i]]),NX*NY,1)
        end
        =#
        N[:] = N[travelVec];

        # Store values of solids
        N_SOLID = N[vec(SOLID),vec([1 6 7 8 9 2 3 4 5])]; # Bounce Back & No Collision

        # Calculate x & y speeds
        rho = sum(N,dims=2)
        ux  = sum(N.*cx',dims=2)./rho;
        ux  = ux .+ deltaUX
        uy  = sum(N.*cy',dims=2)./rho

        workMatrix = ux * cx' .+ uy * cy';
        workMatrix = (3 .+ 4.5 .* workMatrix) .* workMatrix;
        workMatrix = workMatrix .- (1.5*(ux.^2+uy.^2));
        workMatrix = (workMatrix .+ 1) .* W' .* rho;

        N = N .+ (workMatrix .- N) .* OMEGA
        N[vec(SOLID),:] = N_SOLID;
    end
    ux[vec(SOLID)] .= 0;
    uy[vec(SOLID)] .= 0;
    ux = reshape(ux,NX,NY)';
    uy = reshape(uy,NX,NY)';

    X, Y = meshgrid(1:NX,1:NY);
    Plots.quiver(X[:],Y[:], gradient=(ux[:],uy[:]))
end

@time LBM25Lines()
#=
figure(1);
clf;
hold on;
colormap(gray[2]);
image(2-reshape(SOLID,NX,NY)')
quiver(1:NX,1:NY,ux,uy,1.5,'b');
axis([0.5 NX+0.5 0.5 NY+0.5]);
axis image()
title(["Velocity field after ',num2str(t_),' time steps"])
=#
