# groundObjectSpectrum
Processing program of ground object spectrum 


The program is used to process the ground object spectrum and consists of two parts：

1) Part 1: Smoothing Ground Object Spectrum Data. Using SmoothFunction. m code to smooth observation noise and atmospheric water vapor noise.
Input file: Raw reflectance data.
Output file: Smoothed reflectance data.

2) Part2: Calculating the mean reflectance of multiple observations and plot it.
Input file: Smoothed reflectance data/object and scene pictures/observation information file
Output file: Standardized output folder that contains reflectance (.txt files and .jpg files), as well as object and scene pictures.
