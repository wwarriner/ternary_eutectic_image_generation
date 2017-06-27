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

function unit_cell = one_M_two_R( features )

r_a = radius_of_alpha_phase( ...
    features.vf_alpha, ...
    features.lambda_1 ...
    );

r_b = radius_of_beta_phase( ...
    features.vf_beta, ...
    features.lambda_1 ...
    );

unit_cell = generate_unit_cell( ...
    r_a, ...
    r_b, ...
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



function r_b = radius_of_beta_phase( vf_beta, rod_spacing )

v_total = compute_total_unit_cell_volume( rod_spacing );
r_b = sqrt( ...
    ( vf_beta * v_total ) ...
    / ( 4 * pi ) ...
    );

end



function unit_cell = generate_unit_cell( ...
    r_a, ...
    r_b, ...
    features ...
    )

r_a = max( 1, round( r_a ) );
r_b = max( 1, round( r_b ) );
rod_spacing = features.lambda_1;
height = round( 2 * compute_row_spacing( rod_spacing ) );
width = 3 * rod_spacing;
unit_cell = create_array_by_fill( features.gamma, height, width );
unit_cell = fill_beta_phase( ...
    r_b, ...
    features.lambda_1, ...
    features.beta, ...
    unit_cell ...
    );
unit_cell = fill_alpha_phase( ...
    r_a, ...
    features.lambda_1, ...
    features.alpha, ...
    unit_cell ...
    );

end



function unit_cell = fill_alpha_phase( ...
    r_a, ...
    rod_spacing, ...
    alpha, ...
    unit_cell ...
    )

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
rod = circshift( rod, round( ( 3 / 2 ) * rod_spacing ), 2 );
rod = circshift( rod, round( row_spacing ), 1 );
unit_cell( rod == 1 ) = alpha;

end



function unit_cell = fill_beta_phase( ...
    rb, ...
    rod_spacing, ...
    beta, ...
    unit_cell ...
    )

row_spacing = round( compute_row_spacing( rod_spacing ) );
d_b = 2 * rb;
ball = draw_ball( d_b );

% start at the UL corner
rod_base = zeros( size( unit_cell ) );
rod_base( 1 : d_b, 1 : d_b ) = ball;
rod_base = circshift( rod_base, -rb, 1 );
rod_base = circshift( rod_base, -rb, 2 );

% these flank the corner alpha rod
rod = rod_base;
rod = circshift( rod, round( rod_spacing ), 2 );
unit_cell( rod == 1 ) = beta;

rod = rod_base;
rod = circshift( rod, round( 2 * rod_spacing ), 2 );
unit_cell( rod == 1 ) = beta;

% these flank the center alpha rod
rod = rod_base;
rod = circshift( rod, round( ( 1 / 2 ) * rod_spacing ), 2 );
rod = circshift( rod, round( row_spacing ), 1 );
unit_cell( rod == 1 ) = beta;

rod = rod_base;
rod = circshift( rod, round( ( 5 / 2 ) * rod_spacing ), 2 );
rod = circshift( rod, round( row_spacing ), 1 );
unit_cell( rod == 1 ) = beta;

end



function v_total = compute_total_unit_cell_volume( rod_spacing )

v_total = 6 * rod_spacing * compute_row_spacing( rod_spacing );

end



function row_spacing = compute_row_spacing( rod_spacing )

row_spacing = ( sqrt( 3 ) / 2 ) * rod_spacing;

end