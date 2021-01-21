# FLORIDyn_Julia
 FLORIDyn implementation in the Julia language

# UNDER DEVELOPMENT!
The FLORIDyn code is currently being migrated from MATLAB and rewritten in Julia.
Along with the language also the internal structure and details are changed:
### Wind field
- The wind field is no stand-alone part anymore but integrated in the OPs
- The values for the wind speed and the ambient turbulence intensity are measured and the states are corrected
- Multiple FLORIDyn versions run as ensembles in parallel in an Ensemble Kalman Filter

### States
- Ct and yaw are handled as states of the turbines and are not anymore tied to the OPs which saves memory and is more intuitive
- The OPs store their crosswind (y) position in the wake coordinate system. The value can be calculated but is needed at the start and at the end of each time step, so nothing is gained by calculating it again. Further is the z coordinate the same as in the world coordinates and thus already stored.

### Structure
The implementation is much more focussed on performance and efficient computational design instead of testing. This means some choices won't be part of this code.
- OPs only travelling at free speed
- 3D Wake
- Always reduced interaction
- r only calculated for OPs if needed
- Matured pointer structure
 - Ensembles point to turbines
 - Turbines point to chains
 - Chains point to OPs
- Decrease of redundant information
- Design has parallelization in mind from the start

## Contact
For questions, suggestions and feedback please contact Marcus Becker, marcusbecker (at) tudelft (dot) nl
