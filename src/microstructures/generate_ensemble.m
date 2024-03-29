function ensemble = generate_ensemble( type, image_size, root_path )

    steps = 26;
    root_path = [ fullfile( root_path, type ) filesep ];
    if ~isdir( root_path )
        
        mkdir( root_path );
        
    end
    if strcmpi( type, '1L2R' )
        
        ensemble = Ensemble( ...
            root_path, ...
            @one_L_two_R, ...
            image_size, ...
            [ 8 16 32 64 128 256 512 ], ...
            [ 8 16 32 64 128 256 512 ], ...
            linspace( 0.1, 0.8, steps ), ...
            linspace( 0.1, 0.8, steps ), ...
            1, ...
            0, ...
            [ 0 0 ] ...
            );
        
    end

    if strcmpi( type, '1M2R' )
        
        ensemble = Ensemble( ...
            root_path, ...
            @one_M_two_R, ...
            image_size, ...
            [ 8 16 32 64 128 256 512 ], ...
            0, ...
            linspace( 1/4, 1/2, steps ), ...
            linspace( 1/4, 1/2, steps ), ...
            1, ...
            0, ...
            [ 0 0 ] ...
            );
        
    end

    if strcmpi( type, '3LABAC' )
        
        ensemble = Ensemble( ...
            root_path, ...
            @three_L_abac, ...
            image_size, ...
            [ 8 16 32 64 128 256 512 ], ...
            0, ...
            linspace( 0.1, 0.8, steps ), ...
            linspace( 0.1, 0.8, steps ), ...
            1, ...
            0, ...
            [ 0 0 ] ...
            );
        
    end

    if strcmpi( type, '3LABC' )
        
        ensemble = Ensemble( ...
            root_path, ...
            @three_L_abc, ...
            image_size, ...
            [ 8 16 32 64 128 256 512 ], ...
            0, ...
            linspace( 0.1, 0.8, steps ), ...
            linspace( 0.1, 0.8, steps ), ...
            1, ...
            0, ...
            [ 0 0 ] ...
            );
        
    end

    if strcmpi( type, '2L1R' )
        
        ensemble = Ensemble( ...
            root_path, ...
            @two_L_one_R, ...
            image_size, ...
            [ 8 16 32 64 128 256 512 ], ...
            0, ...
            linspace( 1/6, 2/3, steps ), ...
            linspace( 1/6, 2/3, steps ), ...
            1, ...
            0, ...
            [ 0 0 ] ...
            );
        
    end

end

