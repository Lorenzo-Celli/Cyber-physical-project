% parameters
bitlength = 35;     % 2^bitlength prime sizes
gamma = vpa(10000); % precision = (log_10 gamma) decimal places
[p, q] = GeneratePrimes(bitlength); 
p = vpa(p);
N = p*q;

% get parameters and outputs from quad-tank system
A = vpa(sys.A);
B = vpa(sys.B);
L = vpa(Ld);
LC = vpa(L*sys.C);
yk = vpa(transpose(out.yk.Data(10,:)));
hatxk = vpa(transpose(out.hatxk.Data(10,:)));
uk = vpa(transpose(out.uk.data(10,:)));

% |M| = p = 2*ximax + 1
ximax = (p-1)/2;

% NOTE: xi MUST be within [-ximax/gamma; +ximax/gamma]

% encrypt every matrix
EncA = EncryptMatrix(A, gamma, ximax, p, q);
EncB = EncryptMatrix(B, gamma, ximax, p, q);
EncL = EncryptMatrix(L, gamma, ximax, p, q);
EncminusLC = EncryptMatrix(-LC, gamma, ximax, p, q);
Enchatxk = EncryptMatrix(hatxk, gamma, ximax, p, q);
Encuk = EncryptMatrix(uk, gamma, ximax, p, q);
Encyk = EncryptMatrix(yk, gamma, ximax, p, q);

%IMPORTANT: when multiplying cyphertexts, do InverseGamma with gamma^2
% this is because gamma multiplies with itself during homomorphic
% multiplication

% encrypted state estimation
Enchatxkp1 = HSum(HSum(HSum(HMul(EncA, Enchatxk, N), ...
                      HMul(EncB, Encuk, N), N), ...
                      HMul(EncL, Encyk, N), N), ...
                      HMul(EncminusLC, Enchatxk, N), N);

% these two should be the same, except that hatkxp1 is approximated to 4th
% decimal place
hatxkp1 = DecryptMatrix(Enchatxkp1, gamma^2, ximax, p)
realhatxkp1 = A*hatxk + B*uk + L*yk - LC*hatxk

% encrypted control evaluation
Kp = vpa(eye(2, 6));
vk = vpa(zeros(6,1));
EncKp = EncryptMatrix(Kp, gamma, ximax, p, q);
Encvk = EncryptMatrix(vk, gamma, ximax, p, q);
Encminusxkhatp1 = EncryptMatrix(-hatxkp1, gamma, ximax, p, q);

Encukp1 = HMul(EncKp, HSum(Encvk, Encminusxkhatp1, N), N);

ukp1 = DecryptMatrix(Encuk, gamma^2, ximax, p);