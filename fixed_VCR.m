clc;
clear all;
close all;
% Integral Imaging system parameters settting

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% High resolution (The number of pixels for each elemental image)
%Nx = 3072;
%Ny = 2048;
% Medium resolution (The number of pixels for each elemental image)
%Nx = 1536;      %이미지의 픽셀값
%Ny = 1024;
%Three_Characters (The number of pixels for each elemental image)
Nx = 3008;
Ny = 2000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f = 105;        % Focal length of lens
p = 2;          % pitch between elemental images
cx = 36;        % Sensor size in x direction
cy = 24;        % Sensor size in y direction
Lx = 10;        % The number of elemental images in x direction
Ly = 10;        % The number of elemental images in y direction

% Reconstruction depth 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for depth = 200:5:500 % grass_and_car는 200:5:500
for depth = 400:5:1000 % Three_Chracters는 400~1000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    depth
    % Shifting pixels for each elemental image
    shx = round(Nx*f*p/(cx*depth));
    shy = round(Ny*f*p/(cy*depth));
    % Reconstructed 3D image matrix
    recon = zeros(Ny + (Ly-1)*shy, Nx + (Lx-1)*shx, 3); %겹쳐진 이미지의 전체 없이를 계산하는 식
    % Overlapping matrix
    recon_over = zeros(Ny + (Ly-1)*shy, Nx + (Lx-1)*shx, 3);
    % Superposition of elemental images at reconstruction depth
    for k1 = 1:Ly
        for k2 = 1:Lx

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %image = imread(['/Users/zoocasso/Desktop/2022 - 1학기/3차원영상처리/image/high_EIs/high_',num2str((k1-1)*Lx+k2),'.jpg']);
            %image = imread(['/Users/zoocasso/Desktop/2022 - 1학기/3차원영상처리/image/medium_EIs/medium_',num2str((k1-1)*Lx+k2),'.jpg']);
            image = imread(['/Users/zoocasso/Desktop/2022 - 1학기/3차원영상처리/image/Three_Characters/EI_', num2str((k1-1)*Lx+k2), '.jpg']);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %image를 중첩하여 채움
            recon((k1-1)*shy + 1:(k1-1)*shy + Ny, (k2-1)*shx + 1:(k2-1)*shx + Nx, :) = recon((k1-1)*shy + 1:(k1-1)*shy + Ny, (k2-1)*shx + 1:(k2-1)*shx + Nx, :) + im2double(image);
            %같은 방식으로 1을 중첩하여 채움
            recon_over((k1-1)*shy + 1:(k1-1)*shy + Ny,(k2-1)*shx + 1:(k2-1)*shx + Nx, :) = recon_over((k1-1)*shy + 1:(k1-1)*shy + Ny, (k2-1)*shx + 1:(k2-1)*shx +Nx, :) + ones(Ny, Nx, 3);
        end
    end
    % Averaging
    recon = recon./recon_over; %요소간의 나눗셈 ./

    % Save reconstructed 3D image
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %imwrite(recon, ['/Users/zoocasso/Desktop/2022 - 1학기/3차원영상처리/image/high_results_fixed/recon_fixed_high_z_',num2str(depth),'mm.jpg']);
    %imwrite(recon, ['/Users/zoocasso/Desktop/2022 - 1학기/3차원영상처리/image/medium_results_fixed/recon_fixed_medium_z_',num2str(depth),'mm.jpg']);
    imwrite(recon, ['/Users/zoocasso/Desktop/2022 - 1학기/3차원영상처리/image/Three_Characters_fixed/recon_fixed_Three_Characters_z_', num2str(depth), 'mm.jpg']);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end