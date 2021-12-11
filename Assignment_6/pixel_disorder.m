function pixel_disorder(photo, A)
    %PIXEL_DISORDER function that disorder the pixels of the matrices
    %associated to an image. The matrix is saved in getappdata(gcf, 'matrix', ...).
    %   - photo: image required to disorder.
    %       - Constraints: The matrix associated to the image has to be
    %       squared.
    %   - A: transformation matrix.
    %       - Constraints: A has to be squared.
    %   Note: if 'photo' is already a disordered image, inverse(A) will
    %   give you the original image. You will need the original 'A' matrix
    %   to use the appropiate inverse of 'A'.
    
    % --------------------------------
    % DATA TO TEST
    % photo = 'imagenes/disorder.bmp';
    % Original A:
    % A = [1 3;1 1];
    % A inverse:
    % A = [200 202;201 200];
    % --------------------------------
    
    % Check if the transformation matrix constraints are satisfied.
    [rows, cols] = size(A);
    assert(rows == cols, 'A is not squared.');
    
    % Read image and check constraints.
    assert(isa(photo, 'char'), 'Argument <photo> is not a valid file input.');
    X = imread(photo);
    [rows, cols, p] = size(X);
    assert(rows == cols, 'The matrix associated to the image is not squared.');
    
    disordered_image = zeros(cols, rows, p, 'uint8');
    
    % Apply transformation.
    for i = 1:rows
        for j = 1:cols
            coordinates = mod(A * [i;j], rows);
            
            % Check if the coordinate is 0. If it is, then the coordinate
            % is the maximum value.
            if coordinates(1) == 0
                coordinates(1) = rows;
            end
            
            if coordinates(2) == 0
                coordinates(2) = rows;
            end
            
            disordered_image(coordinates(1), coordinates(2), :) = X(i, j, :);
        end
    end
    
    % Save the new matrix (disordered_image).
    setappdata(gcf, 'matrix', disordered_image);
end

