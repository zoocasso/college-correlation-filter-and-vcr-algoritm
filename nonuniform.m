clc;
clear all;
close all;
% Integral Imaging system parameters settting

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% High resolution (The number of pixels for each elemental image)
%Nx = 3072;
%Ny = 2048;
% Medium resolution (The number of pixels for each elemental image)
Nx = 1536;
Ny = 1024;
%Three_Characters (The number of pixels for each elemental image)
%Nx = 3008;
%Ny = 2000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f = 105;        % Focal length of lens
p = 2;          % pitch between elemental images
cx = 36;        % Sensor size in x direction
cy = 24;        % Sensor size in y direction
Lx = 10;        % The number of elemental images in x direction
Ly = 10;        % The number of elemental images in y direction

% Reconstruction depth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for depth = 205:10:500 % grass_and_car = 200:5:500
%for depth = 400:5:1000 % Three_Chracters = 400:5:1000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    depth
    % Shifting pixels for each elemental image
    shx = round(Nx*f*p/(cx*depth).*[0:Lx-1]);
    shy = round(Ny*f*p/(cy*depth).*[0:Lx-1]);
    % Reconstructed 3D image matrix
    recon = zeros(Ny + max(shy(:)), Nx + max(shx(:)),3);
    % Overlapping matrix
    recon_over = zeros(Ny + max(shy(:)), Nx + max(shx(:)), 3);
    % Superposition of elemental images at reconstruction depth
    for k1 = 1:Ly
        for k2 = 1:Lx

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %image = imread(['/Users/zoocasso/Desktop/2022 - 1학기/3차원영상처리/image/high_EIs/high_', num2str((k1-1)*Lx+k2), '.jpg']);
            image = imread(['/Users/zoocasso/Desktop/2022 - 1학기/3차원영상처리/image/medium_EIs/medium_', num2str((k1-1)*Lx+k2), '.jpg']);
            %image = imread(['/Users/zoocasso/Desktop/2022 - 1학기/3차원영상처리/image/Three_Characters/EI_', num2str((k1-1)*Lx+k2), '.jpg']);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %image를 중첩하여 채움
            recon(shy(k1) + 1:shy(k1) + Ny, shx(k2) + 1:shx(k2) + Nx, :) = recon(shy(k1) + 1:shy(k1) + Ny, shx(k2) + 1:shx(k2) + Nx, :) + im2double(image);
            %같은 방식으로 1을 중첩하여 채움
            recon_over(shy(k1) + 1:shy(k1) + Ny, shx(k2) + 1:shx(k2) + Nx, :) = recon_over(shy(k1) + 1:shy(k1) + Ny, shx(k2) + 1:shx(k2) + Nx, :) + ones(Ny, Nx,3);
        end
    end
    % Averaging
    recon = recon./recon_over; %요소간의 나눗셈 ./
    
    % Save reconstructed 3D image
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %imwrite(recon, ['/Users/zoocasso/Desktop/2022 - 1학기/3차원영상처리/image/high_results_nonuniform/recon_nonuniform_high_z_', num2str(depth), 'mm.jpg']);
    imwrite(recon, ['/Users/zoocasso/Desktop/2022 - 1학기/3차원영상처리/image/medium_results_nonuniform/recon_nonuniform_medium_z_', num2str(depth), 'mm.jpg']);
    %imwrite(recon, ['/Users/zoocasso/Desktop/2022 - 1학기/3차원영상처리/image/Three_Characters_nonuniform/recon_nonuniform_Three_Characters_z_', num2str(depth), 'mm.jpg']);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end