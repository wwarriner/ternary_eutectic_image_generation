classdef Ensemble < handle
    
    properties ( Access = private )
        
        write_path
        unit_cell_generator
        image_size
        ranges
        lengths
        combination_count
        
        indices
        
    end
    
    methods ( Access = public )
        
        function obj = Ensemble( ...
                write_path, ...
                unit_cell_generator, ...
                image_size, ...
                lambda_1_range, ...
                lambda_2_range, ...
                vf_alpha_range, ...
                vf_beta_range, ...
                scaling_range, ...
                rotation_range, ...
                translation_ranges ...
                )
            
            obj.write_path = fileparts( write_path );
            obj.unit_cell_generator = unit_cell_generator;
            obj.image_size = image_size;
            obj.ranges{ 1 } = lambda_1_range;
            obj.ranges{ 2 } = lambda_2_range;
            obj.ranges{ 3 } = vf_alpha_range;
            obj.ranges{ 4 } = vf_beta_range;
            obj.ranges{ 5 } = scaling_range;
            obj.ranges{ 6 } = rotation_range;
            obj.ranges{ 7 } = translation_ranges( :, 1 );
            obj.ranges{ 8 } = translation_ranges( :, 2 );            
            obj.lengths = cellfun( ...
                @(x) length( squeeze( x ) ), ...
                obj.ranges, ...
                'uniformoutput', false ...
                );
            obj.lengths = squeeze( cell2mat( obj.lengths ) );
            obj.combination_count = prod( obj.lengths );
            
            obj.indices( 1 : 8 ) = 1;
            
        end
        
        function write_images( obj )
            
            for i = 1 : obj.combination_count
            
                [ feature, transformation ] = ...
                    obj.get_next_image_properties();
                if ~feature.is_possible()

                    continue;

                end
                im = generate_microstructure( ...
                    obj.unit_cell_generator( feature ), ...
                    obj.image_size, ...
                    transformation ...
                    );
                s = [ feature.to_string() '_' transformation.to_string() ];

                im_path = fullfile( obj.write_path, [ s '.png' ] );
                imwrite( im, im_path );

            end
            
        end
        
    end
    
    methods ( Access = private )
        
        function [ feature, transformation ] = ...
                get_next_image_properties( obj )
            
            feature_args = obj.retrieve( 1 : 4 );
            feature = Features( feature_args{ : } );
            
            transformation_args = obj.retrieve( 5 : 6 );
            transformation_args{ end + 1 } = ...
                [ obj.retrieve_one( 6 ), obj.retrieve_one( 7 ) ];
            transformation = Transformations( transformation_args{ : } );
            
            for i = 1 : length( obj.indices )
                
                obj.indices( i ) = obj.indices( i ) + 1;
                if obj.indices( i ) == obj.lengths( i ) + 1
                    
                    obj.indices( i ) = 1;
                    
                else
                    
                    break;
                    
                end
                
            end
            
        end
        
        function args = retrieve( obj, indices )
            
            args = cell( length( indices ), 1 );
            for i = 1 : length( indices )
                
                curr = indices( i );
                args{ i } = obj.ranges{ curr }( obj.indices( curr ) );
                
            end
            
        end
        
        function arg = retrieve_one( obj, index )
            
            arg = obj.ranges{ index }( obj.indices( index ) );
            
        end
        
    end
    
end

