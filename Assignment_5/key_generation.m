function [n, e, d] = key_generation()    
    %KEY_GENERATION Function that generates both private and public keys
    %needed in RSA cipher.
    %   - p and q values are required by user.

    % Choose 2 prime numbers.
    p = input('Introduce the prime number p:\n> ');
    assert(~isprime(p) == 0, '%d is not a primer number.\n', p);

    q = input('Introduce the prime number q:\n> ');
    assert(~isprime(q) == 0, '%d is not a primer number.\n', q);

    % Calculate n = p · q.
    n = p * q;
    fprintf('\nThe value n is n = p · q = %d\n\n', n);

    % Choose e < phi(n).
    %   Notes: 
    %   - phi(n) = (p - 1) · (q - 1).
    %   - gcd(e, phi(n)) = 1
    phi_of_n = (p - 1) * (q - 1);
    e = 65537; % e = Fermat_4 = 1 + 2^(2^4).

    assert(e < phi_of_n, 'Constraint [e < phi(n)] not satisfied.');
    assert(gcd(e, phi_of_n) == 1, 'Constraint gcd(e, phi_of_n) ~= 1');

    fprintf('The value e, of the public key, should satisfy gcd(e, phi(n)) = gcd(e, (p - 1)·(q - 1)) = gcd(e, %d) = 1.\n', phi_of_n);
    fprintf('It is selected e = %d.\n\n', e);

    % Find d such 1 < d < phi(n), such d = inv(e) mod phi(n).
    [~, U, ~] = gcd(e, phi_of_n);
    d = mod(U, phi_of_n);

    assert(d > 1, 'd is lower than 1.');
    assert(d < phi_of_n, 'd is greater that phi(n).');

    fprintf('d is the inverse of e module phi(n): d = %d.\n\n', d);

    fprintf('PRIVATE KEY: (n, d) = (%d, %d).\n', n, d);
    fprintf('PUBLIC KEY: (n, e) = (%d, %d).\n', n, e);
