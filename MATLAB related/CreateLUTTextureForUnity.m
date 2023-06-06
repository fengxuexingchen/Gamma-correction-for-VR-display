function CreateLUTTextureForUnity(Separate_index)

addpath('Saved mat files'); 

%The number of samples requested in the LUT texture.
Num_Samp = 32;

if Separate_index == 1
    load('GammaTableForVRDisplay_R.mat');
    lut_R=rgb2lut((gammaTable*255)');

    load('GammaTableForVRDisplay_G.mat');
    lut_G=rgb2lut((gammaTable*255)');

    load('GammaTableForVRDisplay_B.mat');
    lut_B=rgb2lut((gammaTable*255)');   

    RGB_separately_corrected_lut = zeros(Num_Samp,1024,3);

    RGB_separately_corrected_lut(:,:,1) = lut_R(:,:,1);
    RGB_separately_corrected_lut(:,:,2) = lut_G(:,:,2);
    RGB_separately_corrected_lut(:,:,3) = lut_B(:,:,3);

    imwrite(RGB_separately_corrected_lut, 'Saved texture files/RGB_separately_corrected_lut_texture.png' );
elseif Separate_index == 0
    load('GammaTableForVRDisplay_RGB.mat');
    lut_RGB=rgb2lut((gammaTable*255)');   

    RGB_identically_corrected_lut = zeros(Num_Samp,1024,3);

    RGB_identically_corrected_lut = lut_RGB;

    imwrite(RGB_identically_corrected_lut, 'Saved texture files/RGB_identically_corrected_lut_texture.png' );
end

end