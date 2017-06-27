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

function unit_cell = three_L_abac( features )

t_a = width_of_alpha_phase( ...
    features.vf_alpha, ...
    features.lambda_1 ...
    );

t_b = width_of_beta_phase( ...
    features.vf_beta, ...
    features.lambda_1 ...
    );

unit_cell = generate_unit_cell( ...
    t_a, ...
    t_b, ...
    features ...
    );

end



function t_a = width_of_alpha_phase( vf_alpha, lambda )

t_a = lambda * vf_alpha;

end



function t_b = width_of_beta_phase( vf_beta, lambda )

t_b = lambda * vf_beta;

end



function unit_cell = generate_unit_cell( t_a, t_b, features )

t_a = max( 1, round( t_a ) );
t_b = max( 1, round( t_b ) );
unit_cell = create_array_by_fill( ...
    features.gamma, ...
    features.lambda_1, ...
    features.lambda_1 ...
    );
unit_cell = fill_alpha_phase( t_a, features.alpha, unit_cell );
unit_cell = fill_beta_phase( t_b, t_a, features.beta, unit_cell );

end



function unit_cell = fill_alpha_phase ( alpha_size, alpha_value, unit_cell )

unit_cell( 1:end, 1:alpha_size ) = alpha_value;

end



function unit_cell = fill_beta_phase( beta_size, alpha_size, beta_value, unit_cell)

unit_cell( 1:end, 1+alpha_size:alpha_size+beta_size )= beta_value;

end



function arr = create_array_by_fill( fill_value, x )

arr = repmat( fill_value, x );

end