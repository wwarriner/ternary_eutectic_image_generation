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

function unit_cell = two_L_one_R( features )

r_a = radius_of_alpha_phase( ...
    features.vf_alpha, ...
    features.lambda_1 ...
    );

t_b = width_of_beta_phase( ...
    r_a, ...
    features.vf_beta, ...
    features.lambda_1 ...
    );

unit_cell = generate_unit_cell( ...
    r_a, ...
    t_b, ...
    features ...
    );

end



function r_a = radius_of_alpha_phase( vf_alpha, rod_spacing )

v_total = compute_total_unit_cell_volume( rod_spacing );
r_a = sqrt( ...
    ( vf_alpha * v_total ) ...
    / ( 2 * pi ) ...
    );

end



function t_b = width_of_beta_phase( r_a, vf_beta, rod_spacing )

v_total = compute_total_unit_cell_volume( rod_spacing );
row_spacing = compute_row_spacing( rod_spacing );
t_b = ( ...
    ( ( vf_beta * v_total ) + ( pi * ( r_a ^ 2 ) ) ) ...
    / ( 2 * row_spacing ) ...
    );

end



function unit_cell = generate_unit_cell( ...
    r_a, ...
    t_b, ...
    features ...
    )

r_a = max( 1, round( r_a ) );
t_b = max( 1, round( t_b ) );
rod_spacing = features.lambda_1;
height = round( 2 * compute_row_spacing( rod_spacing ) );
width = rod_spacing;
unit_cell = create_array_by_fill( ...
    features.gamma, ...
    height, ...
    width ...
    );
unit_cell = fill_beta_phase( t_b, features.beta, unit_cell );
unit_cell = fill_alpha_phase( ...
    r_a, ...
    t_b, ...
    rod_spacing, ...
    features.alpha, ...
    unit_cell ...
    );

end



function unit_cell = fill_beta_phase( t_b, beta, unit_cell )

unit_cell( :, 1 : t_b ) = beta;

end



function unit_cell = fill_alpha_phase( ...
    r_a, ...
    t_b, ...
    rod_spacing, ...
    alpha, ...
    unit_cell ...
    )

unit_cell = circshift( unit_cell, r_a, 2 );
row_spacing = round( compute_row_spacing( rod_spacing ) );
d_a = 2 * r_a;
ball = draw_ball( d_a );

rod = zeros( size( unit_cell ) );
rod( 1 : d_a, 1 : d_a ) = ball;

% corner rod
rod = circshift( rod, -r_a, 1 );
rod = circshift( rod, -r_a, 2 );
unit_cell( rod == 1 ) = alpha;

% center rod
rod = circshift( rod, t_b, 2 );
rod = circshift( rod, round( row_spacing ), 1 );
unit_cell( rod == 1 ) = alpha;

end



function v_total = compute_total_unit_cell_volume( rod_spacing )

v_total = 2 * rod_spacing * compute_row_spacing( rod_spacing );

end



function row_spacing = compute_row_spacing( rod_spacing )

row_spacing = ( sqrt( 3 ) / 2 ) * rod_spacing;

end