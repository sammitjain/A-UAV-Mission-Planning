# UAV_flight_mission_planning

This project involves the work I did at the *Defense Research and Development Organization (DRDO)*, New Delhi. The end product was a robust MATLAB-based tool to automatically generate UAV trajectories. The areas that my project touched: operations research, algorithms, image processing, interfacing. The tool is now being used by scientists at ISSA for less computationally expensive simulations. Software used: MATLAB and STK by AGI.
 
The problem: 
  1. Currently, in most places including DRDO, UAV trajectories are NOT mapped automatically before hand and multiple simulations are performed to find a path that avoids enemy radars (modelled as Domes). Thus, there is a need to find a more accurate and computationally inexpensive solution for the same.
  2. The second issue is that there exists no functional tool for linking MATLAB/other programming suites and the simulations software - STK. There is a plugin offered by AGI, which doesn't seem to work in our case. 

My approach (now a working solution):
  1. Use the geo-map from the simulations software STK, and set up the scenario with starting point, ending point, and dome-shaped radars.
  2. Import the image into MATLAB and use image pre-processing algorithms so that the A* algorithm for cost-optimization can be applied.
  3. Use color codes for costs and color thresholding algorithms to differentiate between regions that a UAV can and cannot go through.
  4. Find the required lat-long coordinates in MATLAB
  5. *IMPORTANT* STK has a provision to take HTML commands for initializing path points for a UAV. We make use of this exploit and generate *HTML* commands as printed text, from the MATLAB application.
  6. These commands are then fed to STK directly (simply copy-pasting) and we have thus solved the problem.

Please feel free to write to me at sammit.bitspilani@gmail.com for any queries regarding this.
Some pointers for using this repository:

(@) Currently working approach:
  1. Use STK to generate snap of the scenario to be evaluated. Use .tif for better results
  2. Remember to fill the area targets with one colour and remove everything else from the scenario.
  2. Run preprocess2.m in MATLAB and choose required colours. (Google impixel)
  3. Run ip_approach1.m and feed it the path of the processed image.
  
(@) You'll get the plot in MATLAB, use photoshop to overlay it onto original image.

(@) Currently working on conversion of waypoints according to scale and feeding them to STK

EDIT:

(@) Conversion algorithm added. This is essentially how it works:
top_left = [42.64595 36.08668]; %Got this from STK cursor
bottom_right = [19.18550 110.76360]; %Got this from STK cursor

converted_points = [bottom_right(1)+(size(rad_map2,1)-OptimalPath(:,1)).*(top_left(1)-bottom_right(1))/size(rad_map2,1) top_left(2)+(bottom_right(2)-top_left(2)).*OptimalPath(:,2)/size(rad_map2,2)];

Simple explanation: Use the top-left and bottom right lat-long coordinates to suitably scale and translate the coordinates. 
NOTE: Images have their origin on the top left and coordinates traditionally start from bottom left (hence latitude needed to be subtracted to invert it, in a sense)

(@) Algorithm added to generate STK connect commands
Generating a text file called STK_instr.txt with looped waypoint generation commands
Result from this text file is to be fed to the HTML API of STK
