# UAV_flight_mission_planning

Some pointers for using this:

(@) Currently working approach:
  1. Use STK to generate snap of the scenario to be evaluated. Use .tif for better results
  2. Remember to fill the area targets with one colour and remove everything else from the scenario.
  2. Run preprocess2.m in MATLAB and choose required colours. (Google impixel)
  3. Run ip_approach1.m and feed it the path of the processed image.
  
(@) You'll get the plot in MATLAB, use photoshop to overlay it onto original image.

(@) Currently working on conversion of waypoints according to scale and feeding them to STK
