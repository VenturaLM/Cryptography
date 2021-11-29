%SIGN_AUTH Program that includes all the necessary steps to encrypt
%and decrypt a message using RSA method with signature authentication.

% USE KEY GENERATION SCRIPT HERE!

% Calculate the public key of A.
na = 151535011;
ea = 19;

% Calculate the private key of A.
da = 47845387;

% Calculate the public key of B.
nb = 1389977;
eb = 179;

% Calculate the private key of B.
db = 1271339;


%text_a = input('Introduce the text you want to send to B:\n> ');
%signature_a = input('Introduce your signature:\n> ');
text_a = 'buenos dias, andrea';
signature_a = 'andrea';

% A ciphers the text with B's public key.
ciphered_text_a = rsa_cipher(nb, eb, text_a);

% A ciphers its signature with its private key.
ciphered_signature_a = rsa_cipher(na, da, signature_a);

% Prepare A blocks.
a_block_size = length(num2str(na));
a_tmp_blocks = '';

for i = 1:length(ciphered_signature_a)
    tmp = num2str(ciphered_signature_a(i));
    zeros_to_add = a_block_size - length(tmp);
    tmp = strcat(repmat('0', 1, zeros_to_add), tmp);
    a_tmp_blocks = strcat(a_tmp_blocks, tmp);
end

% Divide the a_tmp_blocks in digits(nb) - 1.
ciphered_signature_a = prepare_num_cipher(length(num2str(nb)) - 1, a_tmp_blocks);

% A ciphers its ciphered signature with B's public key.
ciphered_signature_a = rsa_num_cipher(nb, eb, ciphered_signature_a);

fprintf('The two cryptograms that A sends to B are:');
ciphered_text_a
ciphered_signature_a

fprintf('AGENT B\nB starts deciphering the codes.\n');
fprintf('The text he has received jointly with the signature is:\n');

% B deciphers 'ciphered_text_a' with its private key.
text = rsa_decipher(nb, db, ciphered_text_a)

% When B tries to deciphers 'ciphered_signature_a' with its private key, it
% will obtain something that may not understand.
signature = rsa_num_decipher(nb, db, ciphered_signature_a);

% In order to decipher the signature, we have to adapt following A's keys.
char_signature = '';
for i = 1:length(signature)
    char_signature = strcat(char_signature, num2str(signature(i)));
end

% Prepare decipher blocks.
while rem(length(char_signature), a_block_size) ~= 0
    char_signature = strcat('0', char_signature);
end

% Convert the character signature into char array and then into a numerical
% array.
char_signature = cell2mat(cellstr(reshape(char_signature, a_block_size, [])'));
signature = str2num(char_signature);

% Decipher with A's public keys.
signature = rsa_decipher(na, ea, signature)
