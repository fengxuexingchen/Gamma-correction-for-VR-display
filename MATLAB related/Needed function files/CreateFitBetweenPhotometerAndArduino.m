function [fitresult, gof] = CreateFitBetweenPhotometerAndArduino(X_input, Y_input)

% Create a fit （y = a*x^b+c） between the values of photometer and that of Arduino Uno.

% X_input: the measured photometer values (in cd/m2)
% Y_input: the measured Arduino values (in arbitary unit)
% 
% fitresult : a fit object representing the fit.
% gof : structure with goodness-of fit info.
%


[xData, yData] = prepareCurveData(X_input, Y_input);

% Set up fittype and options.
ft = fittype( 'power2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
% the start point is appropriate for most photoresistors 
opts.StartPoint = [-50 0.3 1000];  

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

end




