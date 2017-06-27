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

function unit_cell = one_L_two_R( features )

t_a = width_of_alpha_phase( ...
    features.vf_alpha, ...
    features.lambda_1 ...
    );

t_b = height_of_beta_phase( ...
    features.vf_alpha, ...
    features.vf_beta, ...
    features.lambda_2 ...
    );

unit_cell = generate_unit_cell( ...
    t_a, ...
    t_b, ...
    features ...
    );

end



function t_a = width_of_alpha_phase( vf_alpha, lambda_1 )

t_a = lambda_1 * vf_alpha;

end



function t_b = height_of_beta_phase( vf_alpha, vf_beta, lambda_2 )

t_b = lambda_2 * ( vf_beta / ( 1 - vf_alpha ) );

end



function unit_cell = generate_unit_cell( ...
    t_a, ...
    t_b, ...
    features ...
    )

t_a = max( 1, round( t_a ) );
t_b = max( 1, round( t_b ) );
unit_cell = create_array_by_fill( ...
    features.gamma, ...
    features.lambda_1, ...
    features.lambda_2 ...
    );
unit_cell = fill_alpha_phase( ...
    t_a, ...
    features.alpha, ...
    unit_cell ...
    );
unit_cell = fill_beta_phase( ...
    t_b, ...
    t_a, ...
    features.beta, ...
    unit_cell ...
    );

end



function unit_cell = fill_alpha_phase( t_a, alpha, unit_cell )

unit_cell( 1 : end, 1 : t_a ) = alpha;

end



function unit_cell = fill_beta_phase( t_b, t_a, beta, unit_cell )

unit_cell( 1 : t_b, ( t_a + 1 ) : end ) = beta;

end