function [ MonExpMod ] = MontgomeryExpMod( n , R, N_inverse , A , B , N, R2modN )
%%
%  ====================================================
% Function：蒙哥马利作幂模运算
% Input Para：n-素数N的最大位数；
% R-进制（预留）R=2；
% N-大素数，二进制，低位在前，N（0）；
% N_inverse-素数N的逆元，二进制，低位在前y（0）
% A-幂底；B-指数
% R2modN-R2modN=R^2(modN)，需要预先计算的数
% Output：MonExpMod = A^B(modN)，结果。
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

for m = length(B):-1:1
    if B(m) == 1
        break;
    end
end
B = B(1:m);

for k = length(A):-1:1
    if A(k) == 1
        break;
    end
end
A = A(1:k);

rs=zeros();
rs(1)=1;
for i=length(B):-1:1
    rs = MontgomeryMultiplyMod( n , R, N_inverse , rs , rs, N, R2modN );
    if B(i)==1
        rs = MontgomeryMultiplyMod( n , R, N_inverse , rs , A, N, R2modN );
    end
end
MonExpMod = rs;
end



