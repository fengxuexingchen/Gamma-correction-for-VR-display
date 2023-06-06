function lut = rgb2lut( rgb )
% RGB2LUT  Create a Unity LUT texture from a vector of target RGB values

% count elements and reshape
n = numel( rgb );
x = reshape( rgb, [ 1 n ] );

% make n x n x n matrices with rgb channel responses
r = repmat( x, [ n 1 n ] );
g = repmat( flipud(x'), [ 1 n n ] );
b = repmat( reshape(x,[ 1 1 n ]), [ n n 1 ] );

% reshape matrices into a texture image
rt = reshape( r, [ n n*n ] );
gt = reshape( g, [ n n*n ] );
bt = reshape( b, [ n n*n ] );
lut = cat( 3, rt, gt, bt ) / 255;

%flip your LUT texture vertically, otherwise something goes wrong in Unity
lut = flipud(lut);   

end
