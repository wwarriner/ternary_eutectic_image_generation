classdef (Sealed) Transformations
    
    properties ( GetAccess = public, SetAccess = private )
        
        scaling_factor
        rotation_angle
        translation_vector
        
    end
    
    methods ( Access = public )
        
        function obj = Transformations( ...
            scaling_factor, ...
            rotation_angle, ...
            translation_vector ...
            )
        
            obj.scaling_factor = scaling_factor;
            obj.rotation_angle = rotation_angle;
            obj.translation_vector = translation_vector;
        
        end
        
        function s = to_string( obj )
            
            s = [ ...
                obj.fmt_sf( obj.scaling_factor ) ...
                obj.fmt_ra( obj.rotation_angle ) ...
                obj.fmt_tr( obj.translation_vector ) ...
                ];
            if ~isempty( s )
                
                s = s( 1 : end - 1 );
                
            end
            
        end
        
    end
    
    methods ( Access = private, Static )
        
        function s = fmt_sf( sf )
            
            if sf > 0
                sf = round( 100 * sf );
                s = [ 's' sprintf( '%03d', sf ) '_' ];
            else
                s = '';
            end
            
        end
        
        function s = fmt_ra( ra, s )
            
            if ra > 0
                s = [ 'r' sprintf( '%03d', ra ) '_' ];
            else
                s = '';
            end
            
        end
        
        function s = fmt_tr( tr )
            
            if ~all( tr == 0 )
                s = [ ...
                    't' ...
                    'x' sprintf( '%03d', tr( 1 ) ) ...
                    'y' sprintf( '%03d', tr( 2 ) ) ...
                    '_' ...
                    ];
            else
                s = '';
            end
            
        end
        
    end
    
end

