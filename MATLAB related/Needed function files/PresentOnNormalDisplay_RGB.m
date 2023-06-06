function [ RGBValues, measuredLuminance] = PresentOnNormalDisplay_RGB(numMeasures, screenid, RGB_index)

% A simple script for calibrate R, G, or B channels of the display.
%
% numMeasures (default: 9) readings are taken manually, and the readings
% are fit with a gamma function. numMeasures - 1 should be a power of 2, 
% ideally (9, 17, 33, etc.). 
%
% measuredLuminance: the measured luminance (in cd/m2)
% RGBValues: the RGB values of presented stimulus (related to numMeasures)


global vals;
global inputV;

    if (nargin < 1) || isempty(numMeasures)
        numMeasures = 9;
    end

    input(sprintf(['When black screen appears, point photometer, \n' ...
           'get reading in cd/m^2, input reading using numpad and press enter. \n' ...
           'A screen of higher luminance will be shown. Repeat %d times. ' ...
           'Press enter to start'], numMeasures));
       
    psychlasterror('reset');    
    try
        if nargin < 2 || isempty(screenid)
            % Open black window on default screen:
            screenid = max(Screen('Screens'));
        end
        
        % Open black window:
        win = Screen('OpenWindow', screenid, 0);
        maxLevel = Screen('ColorRange', win);

        % Load identity gamma table for calibration:
        LoadIdentityClut(win);

        vals = [];
        inputV = [0:(maxLevel+1)/(numMeasures - 1):(maxLevel+1)]; %#ok<NBRAK>
        inputV(end) = maxLevel;
        for i = inputV
            
% A code block to select which chromatic stimulus is to be presented. %%%%%  
            if strcmp(RGB_index,"R")
               Screen('FillRect',win,[i 0 0]);
            elseif strcmp(RGB_index,"G")
               Screen('FillRect',win,[0 i 0]);
            elseif strcmp(RGB_index,"B")
               Screen('FillRect',win,[0 0 i]); 
            elseif strcmp(RGB_index,"RGB")
               Screen('FillRect',win,[i i i]);
            end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            Screen('Flip',win);

            fprintf('Value? ');
            resp = GetNumber;
            fprintf('\n');
            vals = [vals resp]; %#ok<AGROW>
        end
        
        % Restore normal gamma table and close down:
        RestoreCluts;
        Screen('CloseAll');
    catch %#ok<*CTCH>
        RestoreCluts;
        Screen('CloseAll');
        psychrethrow(psychlasterror);
    end

    
% Output the input RGB values and the measured luminance. 
    RGBValues = inputV;
    measuredLuminance = vals;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    


end
