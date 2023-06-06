function SaveMeasuredLuminanceForNormalDisplay(RGB_index)
% A simple prensenting script for R, G, and B channels, respectively.

% RGB_index can be 'R' for red stimulus with [R 0 0] values; 'G' for green 
% stimulus with [0 G 0] values; 'B' for blue stimulus with [0 0 B] values;
% 'RGB' for achromatic stimulus with the same RGB values.
% 
% The input RGB values for calibration and measured luminance will be saved 
% in the current folder after the running.

% ATTENTION: At this step, you should take a memo of the Arduino values!!! 

addpath('Needed function files');  

KbName('UnifyKeyNames'); 
Screen('Preference', 'SkipSyncTests', 1);

screenid = max(Screen('Screens'));
win = Screen('OpenWindow', screenid, 0);

% numMeasures is the value how many different RGB values are presented
% during the presentation
numMeasures = 9;
[RGBValues, measuredLuminance] = PresentOnNormalDisplay_RGB(numMeasures,screenid,RGB_index);

save('Saved mat files/RGBValuesForCalibration.mat', 'RGBValues');
 
if strcmp(RGB_index,'R')
    save('Saved mat files/MeasuredLuminanceForNormalDisplay_R.mat', 'measuredLuminance');
elseif strcmp(RGB_index,'G')
    save('Saved mat files/MeasuredLuminanceForNormalDisplay_G.mat', 'measuredLuminance');
elseif strcmp(RGB_index,'B')
    save('Saved mat files/MeasuredLuminanceForNormalDisplay_B.mat', 'measuredLuminance');
elseif strcmp(RGB_index,'RGB')
    save('Saved mat files/MeasuredLuminanceForNormalDisplay_RGB.mat', 'measuredLuminance');
end



end


