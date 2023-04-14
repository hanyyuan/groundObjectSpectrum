# groundObjectSpectrum
Processing program of ground object spectrum 


The program is used to process the ground object spectrum and consists of two parts:

Part 1: Smoothing ground object spectrum data using the SmoothFunction.m code to smooth observation noise and atmospheric water vapor noise

input file: raw reflectance data.

Output file: smoothed reflectance data.

Part 2: Calculating the mean reflectance of multiple observations and plotting it

input file: smoothed reflectance data (objects) and scene pictures (observation information file).

Output file: A standardized output folder that contains reflectance (.txt and.jpg files), as well as object and scene pictures.
