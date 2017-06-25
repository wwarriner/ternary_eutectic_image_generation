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

micro_x_px = 800;
micro_y_px = 600;

lamella_spacing_px = 100;

alpha_volume_fraction = 1/2;
beta_volume_fraction = 1/4;

alpha_value = 0.0;
beta_value = 0.5;
gamma_value = 1.0;

scaling = 1;
rotation = 0;
translation = [ 0, 0 ];

microstructure = one_matrix_two_rod_microstructure( ...
    micro_x_px, ...
    micro_y_px, ...
    lamella_spacing_px, ...
    alpha_volume_fraction, ...
    beta_volume_fraction, ...
    alpha_value, ...
    beta_value, ...
    gamma_value, ...
    scaling, ...
    rotation, ...
    translation ...
);

[test_va, test_vb] = ternary_microstructure_test( ...
    microstructure, ...
    alpha_value, ...
    beta_value ...
    );

imtool( microstructure );
