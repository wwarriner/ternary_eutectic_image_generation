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

function ball_array = draw_ball( diameter )

integer_size = round( diameter );

grid = ( 1:integer_size ) - 0.5;
[ size_x, size_y ] = meshgrid( grid, grid );

integer_diameter = integer_size - 0.5;
ball_array = ...
    ( size_y - integer_size / 2 ).^ 2 ...
    + ( size_x - integer_size / 2 ) .^ 2 ...
    <= ( integer_diameter / 2 ) .^ 2;

end