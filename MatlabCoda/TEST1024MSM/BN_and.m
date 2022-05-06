function [s] = BN_and( n , R , x, y )
%%
%  ====================================================
% Function：按位与  
% Input Para：n-x，y的最大位数（暂时不用，预留）；R-进制（预留）；
% x-二进制，低位在前，x（0）；y-二进制，低位在前y（0）
% Output：s-x&y，低位在前。
% Author by Wang Pengfei
% data：2022.2.25
% Revised by：
% ====================================================
% R_num = ceil(n/log2(R));%R进制位数
R_num = n;%R进制位数
s = zeros(1,R_num);   % s=x&&y
for i = 1:R_num
    s(i)=x(i)&y(i);
end
end

