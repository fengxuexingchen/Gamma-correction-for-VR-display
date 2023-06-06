function PhotometerValuesForVRDisplay = GetPhotometerFromArduinoForVRDisplay(RGB_index)
% A simple script to estimate the luminance (in cd/m2) fo VR display based 
% on the measured Arduino values

% Arduino_values_For_Normal_Dsiplay: an array for the measured Arduino values
% You should check the memo when running CalibrateNormalDisplay.m. Note that
% R, G, B, or achromatic (RGB) has different Arduino values.  

% Arduino_values_For_VR_Display: an array for the measured Arduino values.
% You should check the memo when running Unity. Note that R, G, B, or 
% achromatic (RGB) has different Arduino values.  

% RGB_index: can be 'R' for red stimulus, 'G' for green stimulus, 'B' for
% blue stimulus, or 'RGB' for achromatic stimulus

addpath('Saved mat files');
addpath('Needed function files');

if strcmp(RGB_index,'R')
    load('MeasuredLuminanceForNormalDisplay_R.mat');
    load('ArduinoValuesForNormalDsiplay_R.mat');

    [fitresult, gof] = CreateFitBetweenPhotometerAndArduino(measuredLuminance, ArduinoValues);

    load('ArduinoValuesForVRDsiplay_R.mat');
    ArduinoValuesForVRDisplay = ArduinoValues;

    x = linspace(0,200,2001);   % set the range of luminance into as 0-200 cd/m2.
    y = (fitresult.a)*x.^(fitresult.b)+(fitresult.c);
elseif strcmp(RGB_index,'G')
    load('MeasuredLuminanceForNormalDisplay_G.mat');
    load('ArduinoValuesForNormalDsiplay_G.mat');

    [fitresult, gof] = CreateFitBetweenPhotometerAndArduino(measuredLuminance, ArduinoValues);

    load('ArduinoValuesForVRDsiplay_G.mat');
    ArduinoValuesForVRDisplay = ArduinoValues;

    x = linspace(0,200,2001);   % set the range of luminance into as 0-200 cd/m2.
    y = (fitresult.a)*x.^(fitresult.b)+(fitresult.c);
elseif strcmp(RGB_index,'B')
    load('MeasuredLuminanceForNormalDisplay_B.mat');
    load('ArduinoValuesForNormalDsiplay_B.mat');

    [fitresult, gof] = CreateFitBetweenPhotometerAndArduino(measuredLuminance, ArduinoValues);

    load('ArduinoValuesForVRDsiplay_B.mat');
    ArduinoValuesForVRDisplay = ArduinoValues;

    x = linspace(0,200,2001);   % set the range of luminance into as 0-200 cd/m2.
    y = (fitresult.a)*x.^(fitresult.b)+(fitresult.c);
elseif strcmp(RGB_index,'RGB')
    load('MeasuredLuminanceForNormalDisplay_RGB.mat');
    load('ArduinoValuesForNormalDsiplay_RGB.mat');

    [fitresult, gof] = CreateFitBetweenPhotometerAndArduino(measuredLuminance, ArduinoValues);

    load('ArduinoValuesForVRDsiplay_RGB.mat');
    ArduinoValuesForVRDisplay = ArduinoValues;

    x = linspace(0,200,2001);   % set the range of luminance into as 0-200 cd/m2.
    y = (fitresult.a)*x.^(fitresult.b)+(fitresult.c);
end


PhotometerValuesForVRDisplay = zeros(1,length(ArduinoValuesForVRDisplay));
for i = 2:length(ArduinoValuesForVRDisplay)
   z=ArduinoValuesForVRDisplay(i)*ones(1,2001);
   P = InterX([x;y],[x;z]);
   PhotometerValuesForVRDisplay(i) = P(1);
end
PhotometerValuesForVRDisplay(1) = 0; % We assume the luminance is 0 cd/m2 
                                        % when RGB values equal 0

end