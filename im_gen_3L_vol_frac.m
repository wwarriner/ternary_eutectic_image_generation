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

function im_gen_3L_vol_frac( output_root_path )

% Define common and constant values
M_X = 1000;
M_Y = 1000;
LAMBDA_1 = 100;
BLACK = 0;
GRAY = 127;
WHITE = 255;
SCALING = 1;
ROTATION = 0;
TRANSLATION = [ 0, 0 ];

IMAGE_FILE_TYPE = '.bmp';

% Changing vol fracs

% append rotation folder to root_path
output_path = [ output_root_path, filesep, 'volume_fraction' ];
if ~exist( output_path, 'dir' )
    mkdir( output_path );
end

v_black_max = 0.8;
for v_black = 0.1:0.05:v_black_max
    
    v_gray_max = 0.9 - v_black;
    for v_gray = 0.1:0.05:v_gray_max
    
    microstructure = three_lamella_microstructure( ...
        M_X, ...
        M_Y, ...
        LAMBDA_1, ...
        v_black, ...
        v_gray, ...
        BLACK, ...
        GRAY, ...
        WHITE, ...
        SCALING, ...
        ROTATION, ...
        TRANSLATION ...    
    );
    
    % generate file name
    file_name = [ '3L_vol_frac_only_', num2str( v_black ), '_', num2str( v_gray ) ];
    
    % append file name to root_path
    output_file = [ output_path, filesep, file_name, IMAGE_FILE_TYPE ];
    
    % write image to disk at appended_root_path
    imwrite( uint8( microstructure ), output_file );
        
    end
    
end

end