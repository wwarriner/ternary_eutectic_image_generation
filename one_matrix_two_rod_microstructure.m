% Copyright 2017 William Warriner
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

function microstructure = one_matrix_two_rod_microstructure( ...
    microstructure_x_length_px, ...
    microstructure_y_length_px, ...
    rod_spacing, ...
    volume_fraction_alpha_phase, ...
    volume_fraction_beta_phase, ...
    alpha_value, ...
    beta_value, ...
    gamma_value, ...
    scaling, ...
    rotation, ...
    translation ...
    )

ra = radius_of_alpha_phase( ...
    volume_fraction_alpha_phase, ...
    rod_spacing ...
    );

rb = radius_of_beta_phase( ...
    volume_fraction_beta_phase, ...
    rod_spacing ...
    );

unit_cell = generate_unit_cell( ...
    ra, ...
    rb, ...
    rod_spacing, ...
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



function ra = radius_of_alpha_phase( va, rod_spacing )

vt = compute_total_unit_cell_volume( rod_spacing );
ra = sqrt( ...
    ( va * vt ) ...
    / ( 2 * pi ) ...
    );

end



function rb = radius_of_beta_phase( vb, rod_spacing )

vt = compute_total_unit_cell_volume( rod_spacing );
rb = sqrt( ...
    ( vb * vt ) ...
    / ( 4 * pi ) ...
    );

end



function unit_cell = generate_unit_cell( ...
    ra, ...
    rb, ...
    rod_spacing, ...
    alpha_value, ...
    beta_value, ...
    gamma_value ...
    )

ra = max( 1, round( ra ) );
rb = max( 1, round( rb ) );

height = round( 2 * compute_row_spacing( rod_spacing ) );
width = 3 * rod_spacing;
unit_cell = create_array_by_fill( gamma_value, height, width );

unit_cell = fill_beta_phase( rb, rod_spacing, global_shift, beta_value, unit_cell );
unit_cell = fill_alpha_phase( ra, rod_spacing, global_shift, alpha_value, unit_cell );

% create by fill
% draw alpha phase circles with radius offset to S and to E
%  one at top-center
%  one at 1/6 to the right, and 1/2 down
% draw beta phase circle with radius offset to S and to E
%  one at top-left
% circshift by radius offset to N
% circshift by radius offset to W

% take care with rounding to integer values
% take care with odd/even shifting

end



function unit_cell = fill_alpha_phase( ...
    ra, ...
    rod_spacing, ...
    alpha_value, ...
    unit_cell ...
    )

row_spacing = round( compute_row_spacing( rod_spacing ) );
da = 2 * ra;
ball = draw_ball( da );
rod = zeros( size( unit_cell ) );
rod( 1 : da, 1 : da ) = ball;
rod = circshift( rod, -ra, 1 );
rod = circshift( rod, -ra, 2 );
unit_cell( rod == 1 ) = alpha_value;
rod = circshift( rod, round( ( 3 / 2 ) * rod_spacing ), 2 );
rod = circshift( rod, round( row_spacing ), 1 );
unit_cell( rod == 1 ) = alpha_value;

end



function unit_cell = fill_beta_phase( ...
    rb, ...
    rod_spacing, ...
    beta_value, ...
    unit_cell ...
    )

row_spacing = round( compute_row_spacing( rod_spacing ) );
db = 2 * rb;
ball = draw_ball( db );
rod_base = zeros( size( unit_cell ) );
rod_base( 1 : db, 1 : db ) = ball;
rod_base = circshift( rod_base, -rb, 1 );
rod_base = circshift( rod_base, -rb, 2 );

rod = rod_base;
rod = circshift( rod, round( ( 1 / 2 ) * rod_spacing ), 2 );
rod = circshift( rod, round( row_spacing ), 1 );
unit_cell( rod == 1 ) = beta_value;

rod = rod_base;
rod = circshift( rod, round( ( 5 / 2 ) * rod_spacing ), 2 );
rod = circshift( rod, round( row_spacing ), 1 );
unit_cell( rod == 1 ) = beta_value;

rod = rod_base;
rod = circshift( rod, round( rod_spacing ), 2 );
unit_cell( rod == 1 ) = beta_value;

rod = rod_base;
rod = circshift( rod, round( 2 * rod_spacing ), 2 );
unit_cell( rod == 1 ) = beta_value;

end



function vt = compute_total_unit_cell_volume( rod_spacing )

vt = 6 * rod_spacing * compute_row_spacing( rod_spacing );

end



function row_spacing = compute_row_spacing( rod_spacing )

row_spacing = ( sqrt( 3 ) / 2 ) * rod_spacing;

end