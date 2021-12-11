function power = arnold_02(photo, A)
    %ARNOLD_02(PHOTO, A) Function that messes up the pixels of the photo 
    %image according to the matrix A of successively.
    %   POWER = ARNOLD_02(PHOTO, A) returns the number of transformations
    %   made.
    %   - photo: required image to apply Arnold's transformation.
    %       - Constraints: The matrix associated to the image has to be
    %       squared.
    %   - A: transformation matrix.
    %       - Constraints: A has to be squared.
    %   Notes:
    %   - case 1: disorder a photo until reach the original one.
    %   - case 2: disorder a photo n times. n is selected by the user.
    
    option = input('Options:\n1. Disorder until getting the original image.\n2. Apply a certain number of transformations.\n3. Exit.\n> ', 's');
    
    % Flag used for an infinite loop until a valid option is selected.
    flag = 1;
    
    module = imfinfo(photo).Width;
    assert(module > 0, 'The work module is not valid. Check if <photo> is a valid input.');
    
    while flag == 1
        switch option
            case '1'
                % Disorder until reach the original image.
                power = power2(A, module);
                
                flag = 0;
                
            case '2'
                % Disorder n times.
                power = str2num(input('How many transformations do you want to apply?\n> ', 's'));
                
                flag = 0;
                
            case '3'
                return
                
            otherwise
                warning('The option selected is not valid.');
                option = input('Options:\n1. Disorder until getting the original image.\n2. Apply a certain number of transformations.\n3. Exit.\n> ', 's');
        end
    end
    
    % Apply transformation.
    A_power = A;
    
    for i = 1:power
        A_power = mod(A * A_power, module);
    end
    
    pixel_disorder(photo, A_power);
    imshow(getappdata(gcf, 'matrix'));
    
    % TODO: Aunque no sea un parámetro de salida, también debe mostrar una animación que comience
    %con la imagen original y muestre todas las imágenes transformadas que se hayan ido realizando.
    %También debe guardar la última imagen de la sucesión de imágenes modificadas.
    
end

