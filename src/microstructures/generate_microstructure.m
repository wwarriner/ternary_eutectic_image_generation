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

function im = generate_microstructure( ...
    unit_cell, ...
    image_size, ...
    transformation ...
    )

% scale unit cell
im = imresize( unit_cell, transformation.scaling_factor, 'nearest' );
scaled_size = size( im );

% generate scaled_microstructure
x_tilings = ceil( image_size( 1 ) / scaled_size( 1 ) );
y_tilings = ceil( image_size( 2 ) / scaled_size( 2 ) );
im = repmat( im, x_tilings, y_tilings );

% pad
im = repmat( im, 2, 2 );

% rotate
im = rotate_m( im, transformation.rotation_angle );

% translate and crop
t = round( transformation.translation_vector ) + 1;
im = im( ...
    t( 1 ) : t( 1 ) + image_size( 1 ), ...
    t( 2 ) : t( 1 ) + image_size( 2 ) ...
    );

end



%{

Rotates an input microstructure about the upper-left corner, and assuming
periodicity at the unit cell boundaries.

%}
function rotated_microstructure = rotate_m( microstructure, theta )

theta_rad = degtorad( theta );

% create microstructure diagonal vector
d = size( microstructure ).';
% compute 2D rotation matrix from input angle
R = [ cos( theta_rad ), sin( theta_rad ) ;
      sin( theta_rad ), -cos( theta_rad ) ];
% compute new microstructure diagonal vector as matrix mult with rotation
d_n = R*d;

% compute number of x tilings
t = ceil( d_n ./ d );
t = [ max(t); max(t) ];
% generate tiled microstructure from x and y tilings
tiles = 2*t;
m_t = repmat( microstructure, tiles(1), tiles(2) );

% rotate about origin by input angle
m_t_r = imrotate( m_t, theta, 'nearest', 'crop' );

% crop from origin to microstructure diagonal vector
origin = ( d .* t ) + 1;
last = origin + d;

rotated_microstructure = m_t_r( origin(1):last(1)-1, origin(2):last(2)-1 );

end