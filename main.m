% parameters
bitlength = 18; % 2^bitlength prime sizes
gamma = 10000; % precision = (log_10 gamma) decimal places
[p, q] = GeneratePrimes(bitlength);

A = sys.A;
B = sys.B;
L = Ld;
LC = L*sys.C;

% |M| = p = 2*N + 1
ximax = (p-1)/2;

% NOTE: xi MUST be within [-ximax; +ximax]

%EncA = EncryptMatrix(A, gamma, ximax, p, q);
%EncB = EncryptMatrix(B, gamma, ximax, p, q);
%EncL = EncryptMatrix(L, gamma, ximax, p, q);
%EncminusLC = EncryptMatrix(-LC, gamma, ximax, p, q);

% encrypted state estimation
yk=transpose(out.yk.Data(2,:));
hatxk=transpose(out.hatxk.Data(2,:));
uk=transpose(out.uk.data(2,:));

%Enchatxk = EncryptMatrix(hatxk, gamma, ximax, p, q);
%Encuk = EncryptMatrix(uk, gamma, ximax, p, q);
%Encyk = EncryptMatrix(yk, gamma, ximax, p, q);

m1 = 0.2454; % funge 
m2 = -0.1232; % funge 
m3 = -1; % funge
m4 = 2; % funge
% solo c1 * c2 non va, c1 + c2 va sempre con qualsiasi numero di cifra
% decimale (poi è finito)
c1 = EncryptValue(Gamma(m4, gamma, ximax), p, q);
c2 = EncryptValue(Gamma(m4, gamma, ximax), p, q);
decrypted_m = InverseGamma(DecryptValue(c1 + c2, p), gamma, ximax)

%IMPORTANT: when multiplying cyphertexts, do InverseGamma with gamma^2
% this is because gamma multiplies with itself during homomorphic
% multiplication

% after the above works, do this:
%Enchatxkp1 = HSum(HSum(HSum(HMul(EncA, Enchatxk, p), ...
%                        HMul(EncB, Encuk, p), p), ...
%                        HMul(EncL, Encyk, p), p), ...
%                        HMul(EncminusLC, Enchatxk, p), ...
%                        p);

%hatxkp1 = DecryptMatrix(Enchatxkp1, gamma^2, ximax, p, N, q);

% encrypted control evaluation
Kp = eye(6);
vk = ones(6,1);
EncKp = EncryptMatrix(Kp, gamma, ximax, p, q);
Encvk = EncryptMatrix(vk, gamma, ximax, p, q);
Encminusxkhat = EncryptMatrix(-hatxk, gamma, ximax, p, q);

Encuk = HMul(EncKp, HSum(Encvk, Encminusxkhat, N), N);

%uk = DecryptMatrix(Encuk, gamma^2, ximax, p);