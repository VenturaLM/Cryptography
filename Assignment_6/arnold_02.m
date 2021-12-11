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
    
    power = -1;
    % NOTA: Aunque no sea un parámetro de salida, también debe mostrar una animación que comience
    %con la imagen original y muestre todas las imágenes transformadas que se hayan ido realizando.
    %También debe guardar la última imagen de la sucesión de imágenes modificadas.

    
    option = input('Options:\n1. Disorder until getting the original image.\n2. Apply a certain number of transformations.\n3. Exit.\n> ', 's');
    
    % Flag used for an infinite loop until a valid option is selected.
    flag = 1;

    while flag == 1
        switch option
            case '1'
                
                
                flag = 0;
                
            case '2'
                
                
                flag = 0;
                
            case '3'
                return
                
            otherwise
                warning('The option selected is not valid.');
                option = input('Options:\n1. Disorder until getting the original image.\n2. Apply a certain number of transformations.\n3. Exit.\n> ', 's');
        end
    end
end

