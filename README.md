# UAV Flight Mission Planning

This project involves the work I did for [removed name for confidentiality, calling it ORG from now]. The end product was a robust MATLAB-based tool to automatically generate UAV trajectories. The areas that the project touched upon: operations research, algorithms, image processing, interfacing. The tool is now being used by scientists at [ORG] for less computationally expensive simulations. Software used: MATLAB, Python and STK by AGI.
 
## The problem of UAV trajectories
* Currently, in most places including [ORG], UAV trajectories are NOT mapped automatically before hand and multiple simulations are performed to find a path that conforms with existing Radar systems (modelled in our project as "domes"). Thus, there is a need to find a more accurate and computationally inexpensive solution for the same.
* The second issue we faced was that we couldn't find a functional tool for linking MATLAB/other programming suites and the simulations software - STK. There is a plugin offered by AGI, which doesn't seem to work in our case. 

## Proposed Solution
  1. Use the geo-map from the simulations software STK, and set up the scenario with starting point, ending point, and dome-shaped radars.
  2. Import the image into MATLAB and use image pre-processing algorithms so that the A* algorithm for cost-optimization can be applied.
  3. Use color codes for costs and color thresholding algorithms to differentiate between regions that a UAV can and cannot go through.
  4. Find the required lat-long coordinates in MATLAB
  5. *IMPORTANT* STK has a provision to take HTML commands for initializing path points for a UAV. We make use of this exploit and generate *HTML* commands as printed text, from the MATLAB application.
  6. These commands are then fed to STK directly (simply copy-pasting) and we have thus solved the problem.

Please feel free to write to me at sammit.bitspilani@gmail.com for any queries regarding this.
Some pointers for using this repository:

## Currently working approach
  1. Use STK to generate snap of the scenario to be evaluated. Use .tif for better results
  2. Remember to fill the area targets with one colour and remove everything else from the scenario.
  2. Run preprocess2.m in MATLAB and choose required colours. (Google impixel)
  3. Run ip_approach1.m and feed it the path of the processed image.

## Additional notes
* After creating the plot in MATLAB, use any photo editing software(e.g. Photoshop) to overlay it onto original image.
* Currently working on conversion of waypoints according to scale and feeding them to STK
* Coordinate Conversion algorithm added. Use the top-left and bottom right lat-long coordinates to suitably scale and translate the coordinates. (NOTE: Images have their origin on the top left and coordinates traditionally start from bottom left. Therefore, latitude needed to be subtracted to invert it, in a sense)
* Algorithm added to generate STK connect commands
* Generating a text file called STK_instr.txt with looped waypoint generation commands
* Result from this text file is to be fed to the HTML API of STK
