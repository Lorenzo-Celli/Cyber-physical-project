% parameters
bitlength = 18; % 2^bitlength prime sizes
gamma = 10000; % precision = (log_10 gamma) decimal places
[p, q] = GeneratePrimes(bitlength);
N = p * q;

A = sys.A;
B = sys.B;
L = Ld;
LC = L*sys.C;

% this works
ximax = ((p-1) / 2) / gamma;
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
m2 = -0.1232; % non funge 
m3 = -1; % non funge
m4 = 2; % funge
c = EncryptValue(Gamma(m2, gamma, ximax), p, q);
decrypted_m = InverseGamma(DecryptValue(c, p), gamma, ximax)

%IMPORTANT: when multiplying cyphertext, do InverseGamma with gamma^2
% this is because gamma multiplies with itself during homomorphic
% multiplication

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