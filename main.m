function main()
%set the vlfeat path
addpath('./vlfeat-0.9.21/toolbox');
vl_setup();
img = imread('1.jpg');

%normalize image 
img = im2single(img);
rows = size(img, 1);
cols = size(img, 2);
img_size = rows * cols;

%set the parameter for superpixel function and utilize the vl_slic function
region_size = 30;
regularizer = 0.0;
seg_img = vl_slic(img, region_size, regularizer);
% get the total mark for all pixel
marks = unique(seg_img);

% draw segmentation result
seg_result = zeros(size(img), 'like', img);
%get each RGB value for each pixel
for i = 1 : length(marks)
    red = find(seg_img == marks(i));
    green = red + img_size;
    blue = green + img_size;
    %set each RGB value within each superpixel to be equal
    seg_result(red) = mean(img(red)); 
    seg_result(green) = mean(img(green)); 
    seg_result(blue) = mean(img(blue)); 
end
figure; 
imshow(seg_result);

%set a hashmap to save the superpixel value and its corresponding data
for i=1:length(marks)
    l = marks(i);
    r_idx = find(seg_img == l);
    g_idx = r_idx+img_size;
    b_idx = g_idx+img_size;
    superpixels{i}(:,1) = fix((r_idx-1)/rows)+1;   % x
    superpixels{i}(:,2) = rem(r_idx-1,rows)+1; % y
    superpixels{i}(:,3) = img(r_idx); % r
    superpixels{i}(:,4) = img(g_idx); % g
    superpixels{i}(:,5) = img(b_idx); % b
end

%initialize md,cd,ms,cs metrix
md = ones(rows, cols);
ms = rand(rows, cols)*0.1;
cd = double(img);
cs = rand(3, 1)*0.1;

% Utilizing Gauss-Seidel iterations to caculate the result
[md,ms,cd,cs] = GS_iter(superpixels,md,ms,cd,cs,3);
% A = abs(255*(seg_result) - (Cd*255));
figure(2)
imshow(uint8(md*255));
figure(3)
imshow(uint8(ms*255));
figure(4)
imshow(uint8(cd*255));
for i = 1:3
    cd(:, :, i) = cd(:, :, i) .* md;
end
figure(5)
imshow(uint8(cd*255));
end
