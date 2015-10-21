%% Object tracking algorithm
debug_flag = 1;
debug_frames = 10;
% organize code (NEW function to compute sift
% test
% implement main

% Load images
img_path = strcat(pwd,'/../test_images/set1/');
img_type = '*.png';
files = dir(strcat(img_path, img_type));
no_of_frames = length(files);
image_size = size(imread(strcat(img_path,files(1).name)));
frames = single(zeros(image_size(1),image_size(2),no_of_frames));
for i = 1 : no_of_frames
    image = imread(strcat(img_path,files(i).name));
    image = preprocess_image(image);
    frames(:,:,i) = image;
    if debug_flag
        if i>debug_frames
            break
        end
    end
end

disp('> images loaded')

% initialize objects

object = struct('x','y','w','h');
object.x = 0; object.y = 0; object.w = 100; object.h = 100;
objects = [object];

%stores all objects
results = zeros(0,50,no_of_frames)
% for all frames:
%   for all objects:
%       find_keypoints
%       align_keypoints
%   draw

disp('> objects initialized')

I_o = frames(:,:,1);
for frame_i = 2 : no_of_frames
    fprintf('> processing frame %d \n',frame_i)
    I_n = frames(:,:,i);
    for object_i = 1 : length(objects)
        % for readability save variables tmp
        x = objects(object_i).x;
        y = objects(object_i).y;
        w = objects(object_i).w;
        h = objects(object_i).h;
        [X_o,Y_o,descriptors] = find_keypoints(I_o,x,y,w,h);
        
        [X_n,Y_n] = align_keypoints(I_o,I_n,X_o,Y_o,descriptors);
    end
    if debug_flag
        if frame_i > debug_frames
            break
        end
    end
    
    % draw...
end
