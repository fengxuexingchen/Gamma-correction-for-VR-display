function displayGamma = SaveGammaTableForVRDisplay(RGB_index)
% This is used for create the LUT textures (png files) read by Unity

addpath('Saved mat files'); 


load('RGBValuesForCalibration.mat');
max_RGBValues = max(RGBValues);


if strcmp(RGB_index, 'R')
    load('PhotometerValuesForVRDisplay_R.mat');
elseif strcmp(RGB_index, 'G')
    load('PhotometerValuesForVRDisplay_G.mat');
elseif strcmp(RGB_index, 'B')
    load('PhotometerValuesForVRDisplay_B.mat');
elseif strcmp(RGB_index, 'RGB')
    load('PhotometerValuesForVRDisplay_RGB.mat');
end

%Normalize values
RGBValues = RGBValues/max_RGBValues;
PhotometerValuesForVRDisplay = PhotometerValuesForVRDisplay / max(PhotometerValuesForVRDisplay);
    
%Gamma function fitting
g = fittype('x^g');
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [2.2];  
fittedmodel = fit(RGBValues',PhotometerValuesForVRDisplay',g,opts);
displayGamma = fittedmodel.g;

% Create a gamma table with a length of 32. If the length is too large, the
% created look up table (LUT) texture cannot be read successfully by Unity. 
LUT_texture_length = linspace(0,max_RGBValues,32);
gammaTable = (((LUT_texture_length'/max_RGBValues))).^(1/fittedmodel.g); 

if strcmp(RGB_index,'R')
    save('Saved mat files/GammaTableForVRDisplay_R.mat', 'gammaTable');
elseif strcmp(RGB_index,'G')
    save('Saved mat files/GammaTableForVRDisplay_G.mat', 'gammaTable');
elseif strcmp(RGB_index,'B')
    save('Saved mat files/GammaTableForVRDisplay_B.mat', 'gammaTable');
elseif strcmp(RGB_index,'RGB')
    save('Saved mat files/GammaTableForVRDisplay_RGB.mat', 'gammaTable');
end


end

