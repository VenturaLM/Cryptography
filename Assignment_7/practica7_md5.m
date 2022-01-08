% PRACTICA 7: Completa el siguiente codigo para implementar un programa
% que proporcione el MD5 de cualquier mensaje.
%
% Por si os ayuda os dejo un esqueleto del codigo junto con alguna 
% indicacion. Hay pasos que se pueden implementar de una forma
% alternativa, podeis variarlo siempre y cuando el programa funcione
% correctametne
%
%  Salida: resumen MD5 del mensaje, que debera ser pedido al usuario,
%  como una cadena hexadecimal.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PASO 1.- INTRODUCIMOS VARIABLES Y CONSTANTES NECESARIAS
clc
%PASO 1.1.- SOLICITAMOS EL MENSAJE

message = input('Introduce a message:\n> ');

% PASO 1.2.- VAMOS A TRABAJAR MODULO M=2^32
m= 2^32;

% PASO 1.3.-  CREAMOS UNA MATRIZ S PARA HACER LA ROTACION DE BITS,
% LOS NUMEROS SON NEGATIVOS POR SER UNA ROTACION A IZQUIERDA
s = [-7, -12, -17, -22;-5,  -9, -14, -20;-4, -11, -16, -23;-6, -10, -15, -21];

% PASO 1.4.- t ES EL VECTOR QUE USAREMOS MAS ADELANTE, para construir la funcion
% Hash  del mensaje
t = zeros(1, 64);

for i = 1:64
   t(i) = floor(abs(sin(i) * m));
end

% PASO 1.5.- INICIALIZAMOS LA HASH
% MD5 utiliza las cuatro palabras siguientes:
% A=01 23 45 67 pero en Little endian:67 45 23 01
% B=89 ab cd ef --> ef cd ab 89 
% C=fe dc ba 98 --> 98 ba dc fe
% D=76 54 32 10 --> 10 32 54 76

A = hex2dec('67452301');
B = hex2dec('efcdab89');
C = hex2dec('98badcfe');
D = hex2dec('10325476');

% fhash = double([0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476]); can
% also be used.
fhash = [A, B, C, D];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PASO 2.- PREPARAMOS EL MENSAJE PARA APLICARLE LA HASH

message = abs(message)
bytelen = numel(message) %numero de elementos del vector 

% PASO 2.1.- COMPLETAMOS EL MENSAJE CON UN 1 Y  LOS CEROS NECESARIOS PARA QUE EL 
% NUMERO DE BITS SEA CONGRUENTE CON 448 MODULO 512. COMO TENEMOS BYTES, COMPLETAMOS 
% CON 128 (10000000) Y LOS CEROS NECESARIOS PARA QUE EL NUMERO DE BYTES SEA 
% CONGRUENTE CON 56 MODULO 64

message(numel(message) + 1) = 128;
message_length_mod_64 = mod(numel(message), 64);

for i = message_length_mod_64:55
    message(numel(message) + 1) = 0;
end

% PASO 2.2.- COMO CADA PALABRA VIENE FORMADA POR 4 BYTES, HACEMOS UNA MATRIZ DE 
% 4 FILAS CON LOS BYTES DEL MENSAJE, ASI CADA COLUMNA SERA UNA PALABRA 

message = transpose(reshape(message, 4, []));

% PASO 2.3.- CONVERTIMOS CADA COLUMNA A ENTEROS DE 32 BITS, little endian.

message_size = length(message);
aux_message = zeros(1, message_size);

for i = 1:message_size
    aux_message(i) = message(i, 1) + message(i, 2) * 2^8 + message(i, 3) * 2^16 + message(i, 4) * 2^24;
end

message = aux_message;

% PASO 2.4.- COMPLETAMOS CON LA LONGITUD DEL MENSAJE ORIGINAL COMO UN ENTERO 
% DE 64 BITS __>8 bytes__>dos palabras : little endian (por palabras).

bitlen = bytelen * 8;
message(numel(message) + 1) = floor(bitlen);
message(numel(message) + 1) = 0;
fprintf('\nmessage = \n')
fprintf('%16.f', message)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PASO 3.- REALIZAMOS LA FUNCION HASH
% TRABAJAMOS CON CADA BLOQUE DE  512 bits
% TENEMOS ENTEROS DE 32 BITS (UNA PALABRA). CADA BLOQUE TIENE 16 ELEMENTOS
% (PALABRAS)

for k = 1:16:numel(message)
    a = fhash(1); b = fhash(2); c = fhash(3); d = fhash(4);
    for i =1:64
        % Convertimos b, c y d a vectores fila de bits.
        bv = dec2bin(b, 32) - '0';
        cv = dec2bin(c, 32) - '0';
        dv = dec2bin(d, 32) - '0';
        % obtenemos  f  = mix de b, c, d.
        %      ki = indice  0:15, del mensaje (k + ki).
        %      sr = filas 1:4, de  s(sr, :).
        if i <= 16          % ronda 1
            f = (bv & cv) | (~bv & dv);
            ki = i - 1;
            sr = 1;
        elseif i <= 32      % ronda 2
            f = (bv & dv) | (cv & ~dv);
            ki = mod(5 * i - 4, 16);    %de 5 en 5 empezando en 1
            sr = 2;
        elseif i <= 48      % ronda 3
            f = xor(bv, xor(cv, dv));
            ki = mod(3 * i + 2, 16);    %de 3 en 3 empezando en 5
            sr = 3;
        else                % ronda 4
            f = xor(cv, bv | ~dv);
            ki = mod(7 * i - 7, 16);    %de 7 en 7 empezando en 0
            sr = 4;
        end
        % Convertimos f, DE VECTOR FILA DE BITS A ENTEROS DE 32-bit .
       
        f = bin2dec(num2str(f));
       
        % HACEMOS LAS OPERACIONES
        sc = mod(i - 1, 4) + 1;
        sum = mod(a + f + message(k + ki) + t(i), m);
        sum = dec2bin(sum, 32);
        sum = circshift(sum, [0, s(sr, sc)]);
        sum = bin2dec(sum);

        % ACTUALIZAMOS  a, b, c, d, ROTANDOLOS CORRECTAMENTE
 
        a = mod(b + sum, m);
        
        [a, d] = rotate_values(a, d);
        [b, d] = rotate_values(b, d);
        [c, d] = rotate_values(c, d);
    end
    
    % MODIFICAMOS EL HASH.
    
    fhash = mod(fhash + [a b c d], m);
    
end

% CONVERTIMOS HASH DE ENTEROS DE 32 BITS, LITTLE ENDIAN, A BYTES .

md5 = [];
aux = 0;

for i = 1:4
    md5(aux + 1) = mod(fhash(i), 2^8);
    md5(aux + 2) = mod(floor(fhash(i) / (2^8)), 2^8);
    md5(aux + 3) = mod(floor(fhash(i) / (2^16)), 2^8);
    md5(aux + 4) = mod(floor(fhash(i) / (2^24)), 2^8);
    
    aux = aux + 4;
end


% CONVERTIMOS HASH A HEXADECIMAL.

md5 = dec2hex(md5);
md5 = lower(num2str(reshape(md5', 1, [])));

md5


