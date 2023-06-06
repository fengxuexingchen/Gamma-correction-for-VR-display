function SaveArduinoValuesForNormalDisplay(RGB_index)
% Save the Arduino values as mat file 
% This function should be run after CalibrateNormalDisplay.m


load('Saved mat files/RGBValuesForCalibration.mat');

for i = 1 : length(RGBValues) 
    ArduinoValues(i) = input(strcat ('RGB values :  ', num2str(RGBValues(i)), '\nArduino values?  '));
end


if strcmp(RGB_index,"R")
    save('Saved mat files/ArduinoValuesForNormalDsiplay_R.mat', 'ArduinoValues');
elseif strcmp(RGB_index,"G")
    save('Saved mat files/ArduinoValuesForNormalDsiplay_G.mat', 'ArduinoValues');
elseif strcmp(RGB_index,"B")
    save('Saved mat files/ArduinoValuesForNormalDsiplay_B.mat', 'ArduinoValues');
elseif strcmp(RGB_index,"RGB")
    save('Saved mat files/ArduinoValuesForNormalDsiplay_RGB.mat', 'ArduinoValues');
end


end