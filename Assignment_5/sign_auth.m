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

ciphered_signature_a = prepare_num_cipher(6, a_tmp_blocks);


% A ciphers its ciphered signature with B's public key.
ciphered_signature_a = rsa_num_cipher(nb, eb, ciphered_signature_a)

