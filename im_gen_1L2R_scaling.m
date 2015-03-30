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

function im_gen_1L2R_scaling( output_root_path )

% Define common and constant values
M_X = 1000;
M_Y = 1000;
V_BLACK = 0.3;
V_GRAY = 0.5;
BLACK = 0;
GRAY = 127;
WHITE = 255;
SCALING = 1;
ROTATION = 0;
TRANSLATION = [ 0, 0 ];

IMAGE_FILE_TYPE = '.bmp';

% Changing spacings (also takes care of scaling when lambda_1 = lambda_2)

% append rotation folder to root_path
output_path = [ output_root_path, filesep, 'scaling' ];
if ~exist( output_path, 'dir' )
    mkdir( output_path );
end
    
for lambda = 20:20:200
    
    microstructure = one_lamella_two_rod_microstructure( ...
        M_X, ...
        M_Y, ...
        lambda, ...
        lambda, ...
        V_BLACK, ...
        V_GRAY, ...
        BLACK, ...
        GRAY, ...
        WHITE, ...
        SCALING, ...
        ROTATION, ...
        TRANSLATION ...    
    );
    
    % generate file name
    file_name = [ '1L2R_scaling_only_', num2str( lambda ) ];
    
    % append file name to root_path
    output_file = [ output_path, filesep, file_name, IMAGE_FILE_TYPE ];
    
    % write image to disk at appended_root_path
    imwrite( uint8( microstructure ), output_file );
    
end

end