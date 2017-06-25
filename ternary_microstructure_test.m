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

function [ Va, Vb ] = ternary_microstructure_test( microstructure, alpha_value, beta_value )

total_count = numel( microstructure );

alpha_count = count_value( microstructure, alpha_value );
Va = compute_volume_fraction( alpha_count, total_count );

beta_count = count_value( microstructure, beta_value );
Vb = compute_volume_fraction( beta_count, total_count );

end



function value_count = count_value( arr, value ) 

binary_count_array = ( arr == value );
value_count = sum( binary_count_array(:) );

end



function volume_fraction = compute_volume_fraction( value_count, total_count )

volume_fraction = value_count / total_count;

end