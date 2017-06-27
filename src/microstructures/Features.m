classdef (Sealed) Features
    
    properties ( GetAccess = public, SetAccess = private )
        
        lambda_1
        lambda_2
        vf_alpha
        vf_beta
        vf_gamma
        
    end
    
    properties( GetAccess = public, Constant )
                
        alpha = 0.0
        beta = 0.5
        gamma = 1.0
        
        double_format = '%.2f';
        
    end
    
    methods ( Access = public )
        
        function obj = Features( ...
                lambda_1, ...
                lambda_2, ...
                vf_alpha, ...
                vf_beta ...
                )
            
            obj.lambda_1 = lambda_1;
            obj.lambda_2 = lambda_2;
            obj.vf_alpha = vf_alpha;
            obj.vf_beta = vf_beta;
            obj.vf_gamma = 1 - vf_alpha - vf_beta;
            
        end
        
        function possible = is_possible( obj )
            
            possible = ( obj.vf_gamma > 0 );
            
        end
        
        function s = to_string( obj )
            
            s = [ ...
                'a' obj.fmt_vf( obj.vf_alpha ) ...
                '_b' obj.fmt_vf( obj.vf_beta ) ...
                '_1L' obj.fmt_L( obj.lambda_1 ) ...
                ];
            
            if obj.lambda_2 > 0
                
                s = [ s '_2L' obj.fmt_L( obj.lambda_1 ) ];
                
            end
            
        end
        
    end
    
    methods ( Access = private, Static )
        
        function s = fmt_vf( vf )
            
            vf = round( 100 * vf );
            s = sprintf( '%03d', vf );
            
        end
        
        function s = fmt_L( L )
            
            s = sprintf( '%03d', L );
            
        end
        
    end
    
end

