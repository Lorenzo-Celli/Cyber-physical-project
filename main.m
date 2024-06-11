% parameters
bitlength = 8; % fino a 13 funge
gamma = 10000; 
[p, q] = GeneratePrimes(bitlength);
%p = 65537
%q = 65537
N = p * q;

A = sys.A;
B = sys.B;
L = Ld;
LC = L*sys.C;

ximax = ((p-1) / 2) * gamma;

EncA = EncryptMatrix(A, gamma, ximax, p, q);
EncB = EncryptMatrix(B, gamma, ximax, p, q);
EncL = EncryptMatrix(L, gamma, ximax, p, q);
EncminusLC = EncryptMatrix(-LC, gamma, ximax, p, q);

% encrypted state estimation
%hatxk = [1.2; 0];
%uk = [1; 0];
%yk = [1; 0];
test=0.0453;
%testa=Gamma(test,gamma,ximax);
testa=EncryptValue(Gamma(test,gamma,ximax),p,q);
pluto=InverseGamma(DecryptValue(testa,p),gamma,ximax)

yk=transpose(out.yk.Data(2,:));
hatxk=transpose(out.hatxk.Data(2,:));
uk=transpose(out.uk.data(2,:));

Enchatxk = EncryptMatrix(hatxk, gamma, ximax, p, q);
Encuk = EncryptMatrix(uk, gamma, ximax, p, q);
Encyk = EncryptMatrix(yk, gamma, ximax, p, q);


HMul(EncA, Enchatxk, N);
HMul(EncB, Encuk, N);
HMul(EncL, Encyk, N);
HMul(EncminusLC, Enchatxk, N);

Enchatxkp1 = HSum(HSum(HSum(HMul(EncA, Enchatxk, N), ...
                        HMul(EncB, Encuk, N), N), ...
                        HMul(EncL, Encyk, N), N), ...
                        HMul(EncminusLC, Enchatxk, N), ...
                        N);



hatxkp1 = DecryptMatrix(Enchatxkp1, gamma, ximax, p, N, q);

% encrypted control evaluation
Kp = eye(6);
vk = ones(6,1);
EncKp = EncryptMatrix(Kp, gamma, ximax, p, q);
Encvk = EncryptMatrix(vk, gamma, ximax, p, q);
Encminusxkhat = EncryptMatrix(-hatxk, gamma, ximax, p, q);

Encuk = HMul(EncKp, HSum(Encvk, Encminusxkhat, N), N);

uk = DecryptMatrix(Encuk, gamma, ximax, p, N, q);