function SavePhotometerValuesForVRDisplay(RGB_index)
% Save the Photometer values as mat file 
% This function should be run after XXXX

addpath('Needed function files');  

PhotometerValuesForVRDisplay = GetPhotometerFromArduinoForVRDisplay(RGB_index);

if strcmp(RGB_index,'R')
    save('Saved mat files/PhotometerValuesForVRDisplay_R.mat', 'PhotometerValuesForVRDisplay');
elseif strcmp(RGB_index,'G')
    save('Saved mat files/PhotometerValuesForVRDisplay_G.mat', 'PhotometerValuesForVRDisplay');
elseif strcmp(RGB_index,'B')
    save('Saved mat files/PhotometerValuesForVRDisplay_B.mat', 'PhotometerValuesForVRDisplay');
elseif strcmp(RGB_index,'RGB')
    save('Saved mat files/PhotometerValuesForVRDisplay_RGB.mat', 'PhotometerValuesForVRDisplay');
end



end