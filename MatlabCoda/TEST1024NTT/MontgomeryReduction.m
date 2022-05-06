function [ Mon ] = MontgomeryReduction( n , R, N_inverse , T , N )
%%
%  ====================================================
% Function：蒙哥马利约简
% Input Para：n-素数N的最大位数；
% R-进制（预留）R=2；
% N-大素数，二进制，低位在前，N（0）；
% N_inverse-素数N的逆元，二进制，低位在前y（0）
% T-需要约简的数 T<2^n
% Output：Mon = T*R_inverse (modN)。
% Author by Wang Pengfei
% data：2022.3.12
% Revised by：
% ====================================================
% 蒙哥马利约简 R表示进制
%   参考：[2]蒙哥马利算法蒙哥马利约简、模乘、模幂
% k = log2(R);
% R_num = ceil(n/k);
R_num = n;%   直接取进制的位数   
Nc = N_inverse;%Nc = N_inverse mod R^n。NC表示N’；其中RR ′?NN ′=1。
if length(T)< R_num
    m_tmp1 = T;
else
    m_tmp1 = T(1:R_num);                        % m_tmp1 = mod(T,R^n), 模R相当于移位
end
m_tmp2 = BN_multiply(n,R,m_tmp1,Nc); %m_tmp2 = m_tmp1*N_inverse
m = m_tmp2(1:R_num); % t = mod(m_tmp2,R^n);    精度修正系数

t_tmp1 = BN_multiply(n,R,m,N);  %t_tmp1 = m*N
t_tmp2 = BN_add(2*n,R,t_tmp1,T);
% Mon = t_tmp2(R_num+1:2*R_num+1); % Mon = (T + m*N)/R, Montgomery模乘约减表达式
Mon = t_tmp2(R_num+1:end); % Mon = (T + m*N)/R, Montgomery模乘约减表达式

if (BN_compare( Mon, N ))
    [Mon] = BN_sub( n , R , Mon, N );  % if Mon>=N,then Mon=Mon-N
end
Mon = Mon(1:R_num);
end



