function [ MonMod ] = MontgomeryMultiplyMod( n , R, N_inverse , A , B , N, R2modN )
%%
%  ====================================================
% Function：蒙哥马利作模乘运算
% Input Para：n-素数N的最大位数；
% R-进制（预留）R=2；
% N-大素数，二进制，低位在前，N（0）；
% N_inverse-素数N的逆元，二进制，低位在前y（0）
% A-模乘的数；B-模乘的数
% R2modN-R2modN=R^2(modN)，需要预先计算的数
% Output：MonMod = A*B(modN)，模乘结果。
% Author by Wang Pengfei
% data：2022.3.12
% Revised by：
% ====================================================
A2_tmp =BN_multiply(n,R,A,R2modN);
A2 = MontgomeryReduction( n , R, N_inverse , A2_tmp , N );
B2_tmp =BN_multiply(n,R,B,R2modN);
B2 = MontgomeryReduction( n , R, N_inverse , B2_tmp , N );
A2B2 = BN_multiply(n,R,A2,B2);
ABR=MontgomeryReduction( n , R, N_inverse , A2B2 , N );
MonMod = MontgomeryReduction( n , R, N_inverse , ABR , N );
end


