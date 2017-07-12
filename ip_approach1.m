%GET THE INPUT DATA FROM PREPROCESS2 REMEMBER. IMPORTANT
clear

rad_map = imread('C:\Users\Sammit\Downloads\DRDO_Confidential\processed.jpg');
rad_map = rad_map(:,:,1);
rad_map2 = int8(rad_map<127);
%%% Generating a MAP
%1 represents an object that the path cannot penetrate, zero is a free path

MAP = rad_map2;

%Start Positions
StartX=476;
StartY=106;

%Generating goal nodes, which is represented by a matrix. Several goals can be speciefied, in which case the pathfinder will find the closest goal. 
%a cell with the value 1 represent a goal cell
GoalRegister=int8(zeros(size(rad_map2)));
GoalRegister(298,552)=1;

%Number of Neighboors one wants to investigate from each cell. A larger
%number of nodes means that the path can be alligned in more directions. 
%Connecting_Distance=1-> Path can  be alligned along 8 different direction.
%Connecting_Distance=2-> Path can be alligned along 16 different direction.
%Connecting_Distance=3-> Path can be alligned along 32 different direction.
%Connecting_Distance=4-> Path can be alligned along 56 different direction.
%ETC......

Connecting_Distance=8; %Avoid to high values Connecting_Distances for reasonable runtimes. 

% Running PathFinder
OptimalPath=ASTARPATH(StartX,StartY,MAP,GoalRegister,Connecting_Distance)
% End. 

if size(OptimalPath,2)>1
figure(10)
imagesc((MAP))
    colormap(flipud(gray));

hold on
plot(OptimalPath(1,2),OptimalPath(1,1),'o','color','k')
plot(OptimalPath(end,2),OptimalPath(end,1),'o','color','b')
plot(OptimalPath(:,2),OptimalPath(:,1),'r','LineWidth',2)
legend('Goal','Start','Path')

else 
     pause(1);
 h=msgbox('Sorry, No path exists to the Target!','warn');
 uiwait(h,5);
 end




showNeighboors=0; %Set to 1 if you want to visualize how the possible directions of path. The code
%below are purley for illustrating purposes. 
if showNeighboors==1
%



%2
NeigboorCheck=[0 1 0 1 0;1 1 1 1 1;0 1 0 1 0;1 1 1 1 1;0 1 0 1 0]; %Heading has 16 possible allignments
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(2+1);
figure(2)

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
 
grid on
title('Connecting distance=2')
end

%3
NeigboorCheck=[0 1 1 0 1 1 0;1 0 1 0 1 0 1;1 1 1 1 1 1 1;0 0 1 0 1 0 0;1 1 1 1 1 1 1;1 0 1 0 1 0 1;0 1 1 0 1 1 0]; %Heading has 32 possible allignments
figure(3)
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(3+1);

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
 grid on
title('Connecting distance=3')

end
 
%4
NeigboorCheck=[0 1 1 1 0 1 1 1 0;1 0 1 1 0 1 1 0 1;1 1 0 1 0 1 0 1 1;1 1 1 1 1 1 1 1 1;0 0 0 1 0 1 0 0 0;1 1 1 1 1 1 1 1 1;1 1 0 1 0 1 0 1 1 ;1 0 1 1 0 1 1 0 1 ;0 1 1 1 0 1 1 1 0];  %Heading has 56 possible allignments
figure(4)
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(4+1);

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
grid on
title('Connecting distance=4')

end
%1
NeigboorCheck=[1 1 1;1 0 1;1 1 1];
figure(1)
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(1+1);

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
grid on
title('Connecting distance=1')

end
end

%% Conversion algorithm
top_left = [42.64595 36.08668]; %Got this from STK cursor
bottom_right = [19.18550 110.76360]; %Got this from STK cursor

converted_points = [bottom_right(1)+(size(rad_map2,1)-OptimalPath(:,1)).*(top_left(1)-bottom_right(1))/size(rad_map2,1) top_left(2)+(bottom_right(2)-top_left(2)).*OptimalPath(:,2)/size(rad_map2,2)];
%%
STK_instr = fopen('STK_instr.txt','a');

formatSpec = 'AddWaypoint */Aircraft/MyAircraft_Con DetTimeAccFromVel %4.4f %4.4f 11000 257.22222\n';
for i = 1:size(converted_points,1)
    fprintf(STK_instr,formatSpec,converted_points(i,1),converted_points(i,2));
end
fclose(STK_instr);
