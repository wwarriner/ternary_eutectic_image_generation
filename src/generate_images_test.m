file_path = 'D:\dev\repos\ternary_eutectic_image_generation\test_output\';
types = { ...
    '1L2R', ...
    '1M2R', ...
    '3LABAC', ...
    '3LABC', ...
    '2L1R' ...
    };

for i = 1 : numel( types )
    
    ensemble = generate_ensemble( ...
        types{ i }, ...
        [ 1000 1000 ], ...
        file_path ...
        );
    ensemble.write_images();
    
end


    