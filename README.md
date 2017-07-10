# UAV_flight_mission_planning

Some pointers for using this:

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