function arnold(photo, A)
    %ARNOLD function that order or disorder a photo.
    %   - photo: required image to apply Arnold's transformation.
    %       - Constraints: The matrix associated to the image has to be
    %       squared.
    %   - A: transformation matrix.
    %       - Constraints: A has to be squared.
    %   Notes:
    %   - case 1: disorder a photo.
    %       - photo = original image.
    %       - A = transformation matrix.
    %   - case 2: order a photo.
    %       - photo = transformation matrix.
    %       - A = original image.
    
    option = input('Option:\n1. Disorder an image.\n2. Order an image.\n3. Exit.\n> ', 's');
    
    % Flag used for an infinite loop until a valid option is selected.
    flag = 1;

    while flag == 1
        switch option
            case '1'
                % Disorder an image.
                pixel_disorder(photo, A);
                
                subplot(1, 2, 1);
                imshow(photo);
                subplot(1, 2, 2);
                imshow(getappdata(gcf, 'matrix'));
                
                flag = 0;
                
            case '2'
                % Order an image.
                module = imfinfo(photo).Width;
                A_inverse = inv_module(A, module);
                
                pixel_disorder(photo, A_inverse);
                
                subplot(1, 2, 1);
                imshow(photo);
                subplot(1, 2, 2);
                imshow(getappdata(gcf, 'matrix'));
                
                flag = 0;
                
            case '3'
                return
                
            otherwise
                warning('The option selected is not valid.');
                option = input('Option:\n1. Disorder an image.\n2. Order an image.\n3. Exit.\n> ', 's');
        end
    end
end

