
TestImg = imread('assets/snap4_2.tif');  %Path of the image file

%TestImg = imadjust(TestImg,[0 1],[1 0]);
TestImg_R = TestImg(:,:,1);
TestImg_G = TestImg(:,:,2);
TestImg_B = TestImg(:,:,3);

chosen_points = impixel(TestImg); 
MAXC = max(chosen_points);
MINC = min(chosen_points);
r_max = MAXC(1) + 1; %256
r_min = MINC(1) - 1; %254
g_max = MAXC(2) + 1; %1
g_min = MINC(2) - 1; %0
b_max = MAXC(3) + 1; %1
b_min = MINC(3) - 1; %0

%Add case where max or min becomes 255 or 0 respectively

OutImg = TestImg_R<r_max & TestImg_R>r_min & TestImg_G<g_max & TestImg_G>g_min & TestImg_B<b_max & TestImg_B>b_min;
%OutImg2 = imfill(OutImg,'holes');
% subplot(1,2,1);
% imshow(TestImg);
% subplot(1,2,2);
%imshow(OutImg);
imshow(OutImg);
OutImg = OutImg~=1;
imwrite(OutImg,'assets/processed.jpg')
% uicontrol('Style', 'text',...
%        'String', 'Using High Contrast Images',... %replace something with the text you want
%        'Units','normalized',...
%        'Position', [0.5 0.5 0.1 0.1]); 
% 
% PercentMaterial = sum(OutImg(:))*100/(size(TestImg,1)*size(TestImg,2));
% fprintf('\nPixel Measure of region: %d units',sum(OutImg(:)));
% fprintf('\nPercentage color is : %0.4f%%\n',PercentMaterial);
