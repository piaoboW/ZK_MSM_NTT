function [ inverseValue ] = FermatLittleTheoremInverseMod( n , R, N_inverse , A ,  N, R2modN )
%%
%  ====================================================
% Function：费马小定理/欧拉定理求逆元：若p位素数a^(p-1)=1(mod p);则a^(p-2)为a的逆元。
% Input Para：n-素数N的最大位数；
% R-进制（预留）R=2；
% N-大素数，二进制，低位在前，N（0）；
% N_inverse-素数N的逆元，二进制，低位在前y（0）
% A-要求逆元的元素
% R2modN-R2modN=R^2(modN)，需要预先计算的数
% Output：inverseValue = A^（p-2）(modN)=A_inverse。
% Author by Wang Pengfei
% data：2022.3.13
% Revised by：
% ====================================================
% p的最高位不能有0
for o = length(N):-1:1
    if N(o) == 1
        break;
    end
end
N = N(1:o);

for k = length(A):-1:1
    if A(k) == 1
        break;
    end
end
A = A(1:k);

B = BN_sub(n , R , N, [0 1]);
inverseValue = MontgomeryExpMod( n , R, N_inverse , A , B , N, R2modN );
end
