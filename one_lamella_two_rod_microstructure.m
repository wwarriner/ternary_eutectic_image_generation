% Copyright 2015 William Warriner and Subhojit Chakraborty
% 
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
% 
%     http://www.apache.org/licenses/LICENSE-2.0
% 
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.

function microstructure = one_lamella_two_rod_microstructure( ...
    microstructure_x_length_px, ...
    microstructure_y_length_px, ...
    alpha_spacing_px, ...
    beta_spacing_px, ...
    volume_fraction_alpha_phase, ...
    volume_fraction_beta_phase, ...
    alpha_value, ...
    beta_value, ...
    gamma_value, ...
    scaling, ...
    rotation, ...
    translation ...
    )
% ONE_LAMELLA_TWO_ROD_MICROSTRUCTURE
% DESCRIPTION
%
% Function creates a ternary-valued array representing an image of an
% idealized one-lamella, two-rod ternary eutectic microstructure.
% 
% Array is structured the same way as in 
% 
% Figure 1(c)
% Morphological characterization of the Al-Ag-Cu ternary eutectic
% A. Genau, L. Ratke
% Int. J. Mat. Res.
% 103 (2012) p. 469-475
% 
% where alpha is black, beta is gray, gamma is white. Note that Greek
% letter designations used here are not related to the actual phase diagram
% and are shorthand.
% 
% Spacings come from
% 
% [cite]
% 
% for the alpha/black and beta/gray phases.
% 
% 
% 
% OUTPUT
% 
% - microstructure
%  An array representing an image of an idealized microstructure. Output
%  will only contain three values: alpha_value, beta_value, gamma_value.
%  Output will have size() equal to [ microstructure_x_length_px,
%  microstructure_y_length_px ]
% 
% 
% 
% INPUT
% 
% - microstructure_x_length_px
%  Size along dimension x of output image, in pixels.
% 
% - microstructure_y_length_px
%  Size along dimension y of output image, in pixels.
% 
% - alpha_spacing_px
%  Center-to-center spacing of alpha phase, in pixels.
% 
% - beta_spacing_px
%  Center-to-center spacing of beta phase, in pixels.
% 
% - volume_fraction_alpha_phase
%  Volume fraction of alpha phase, with respect to a single "unit cell".
%  Note that this value may not be represented by the overall image because
%  portions of unit cells may be cut off.
% 
% - volume_fraction_beta_phase
%  Volume fraction of beta phase, with respect to a single "unit cell". See
%  note for volume_fraction_alpha_phase.
% 
% - alpha_value
%  Desired value of alpha phase in the output array.
% 
% - beta_value
%  Desired value of beta phase in the output array.
% 
% - gamma_value
%  Desired value of gamma phase in the output array.
% 
% - scaling
%  Scaling factor for "magnification" or "zoom" of the "unit cell". If
%  scaling is greater than 1, then the "unit cell" will be larger than the
%  input spacings. If scaling is less than 1, then the "unit cell" will be
%  smaller.
% 
% - rotation
%  Angle, in degrees, by which to rotate the microstructure. Rotation
%  occurs about the upper-left corner of the image (e.g. array index [ 1, 1
%  ]), and proceeds counter-clockwise with positive values.
% 
% - translation
%  Must be a two-element row or column vector, specifying the number of
%  pixels to translate along x and y for the first and second element,
%  respectively. Translation along x shifts the microstructure left and the
%  view right for positive values. Translation along y shifts the
%  microstructure up and the view down for positive values.

a = width_of_alpha_phase( ...
    volume_fraction_alpha_phase, ...
    alpha_spacing_px ...
    );

b = height_of_beta_phase( ...
    volume_fraction_beta_phase, ...
    alpha_spacing_px, ...
    beta_spacing_px, ...
    a ...
    );

unit_cell = generate_unit_cell( ...
    a, ...
    b, ...
    alpha_spacing_px, ...
    beta_spacing_px, ...
    alpha_value, ...
    beta_value, ...
    gamma_value ...
    );

microstructure = generate_microstructure( ...
    unit_cell, ...
    microstructure_x_length_px, ...
    microstructure_y_length_px, ...
    scaling, ...
    rotation, ...
    translation ...
    );

end



% The number of tilings determines the width. Consider that the volume
% fraction is the product of the width of alpha phase times height of alpha
% phase, divided by total microstructure area. The height of the alpha
% phase is the same as that of the microstructure. The total alpha width 
% across all tilings is the floor of the ratio of microstructure width to
% unit cell width, times the width of alpha in one unit cell, plus the
% minimum of either the width of alpha in one unit cell if it is not cut
% off, or the unit cell width times the fractional remaining tiling. Here
% we solve for the unit cell width so the microstructure has the closest
% possible value to the input.
%
% The width is the solution to a pair of linear equations, only one of
% which is valid. Essentially, either the phase is completely represented
% an integral number of times in the tiling, or is cut off early. Each
% option is represented by one linear equation. Whichever linear equation
% returns the volume fraction closest to the input desired volume fraction
% is used.
function a = width_of_alpha_phase( ...
    volume_fraction_alpha_phase, ...
    alpha_spacing_px ...
    )

a = alpha_spacing_px * volume_fraction_alpha_phase;

end



function b = height_of_beta_phase( ...
    volume_fraction_beta_phase, ...
    alpha_spacing_px, ...
    beta_spacing_px, ...
    alpha_width ...
    )

b = ( ( alpha_spacing_px * beta_spacing_px ) / ( alpha_spacing_px - alpha_width ) ) * volume_fraction_beta_phase;

end



function unit_cell = generate_unit_cell( ...
    a, ...
    b, ...
    alpha_spacing_px, ...
    beta_spacing_px, ...
    alpha_value, ...
    beta_value, ...
    gamma_value ...
    )

a = max( 1, round( a ) );
b = max( 1, round( b ) );
unit_cell = create_array_by_fill( gamma_value, beta_spacing_px, alpha_spacing_px );
unit_cell = fill_alpha_phase( a, alpha_value, unit_cell );
unit_cell = fill_beta_phase( b, a, beta_value, unit_cell );

end



function unit_cell = fill_alpha_phase( alpha_size, alpha_value, unit_cell )

unit_cell( 1:end, 1:alpha_size ) = alpha_value;

end



function unit_cell = fill_beta_phase( beta_size, alpha_size, beta_value, unit_cell )

unit_cell( 1:beta_size, alpha_size+1:end ) = beta_value;

end