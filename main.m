% parameters
bitlength = 13; % fino a 13 funge
gamma = 1; 
[p, q] = GeneratePrimes(bitlength);
%p = 65537
%q = 65537
N = p * q;

A = eye(2);
B = eye(2);
L = eye(2);
LC = eye(2);

ximax = ((p-1) / 2) * gamma;

EncA = EncryptMatrix(A, gamma, ximax, p, q);
EncB = EncryptMatrix(B, gamma, ximax, p, q);
EncL = EncryptMatrix(L, gamma, ximax, p, q);
EncminusLC = EncryptMatrix(-LC, gamma, ximax, p, q);

% encrypted state estimation
%hatxk = [1.2; 0];
%uk = [1; 0];
%yk = [1; 0];
yk=out.yk.Data;
hatxk=out.hatxk.Data;
uk=out.uk.data;

Enchatxk = EncryptMatrix(hatxk, gamma, ximax, p, q);
Encuk = EncryptMatrix(uk, gamma, ximax, p, q);
Encyk = EncryptMatrix(yk, gamma, ximax, p, q);

Enchatxkp1 = HSum(HSum(HSum(HMul(EncA, Enchatxk, N), ...
                        HMul(EncB, Encuk, N), N), ...
                        HMul(EncL, Encyk, N), N), ...
                        HMul(EncminusLC, Enchatxk, N), ...
                        N);

hatxk = DecryptMatrix(Enchatxkp1, gamma, ximax, p, N, q);

% encrypted control evaluation
Kp = eye(2);
vk = [1; 1];
EncKp = EncryptMatrix(Kp, gamma, ximax, p, q);
Encvk = EncryptMatrix(vk, gamma, ximax, p, q);
Encminusxkhat = EncryptMatrix(-hatxk, gamma, ximax, p, q);

Encuk = HMul(EncKp, HSum(Encvk, Encminusxkhat, N), N);

uk = DecryptMatrix(Encuk, gamma, ximax, p, N, q);