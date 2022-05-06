function [s] = BN_sub( n , R , x, y )
%%
%  ====================================================
% Function：求大数的差 s=x-y;x>y
% Input Para：n-x，y的最大位数（暂时不用，预留）；R-进制（预留）；
% x-二进制，低位在前，x（0）；y-二进制，低位在前y（0）
% Output：s-x-y，低位在前。
% Author by Wang Pengfei
% data：2022.3.6
% Revised by：
% ====================================================
% R_num = ceil(n/log2(R));%R进制位数
% R_num = n;%R进制位数
R_num = max(length(x),length(y));
x_tmp = zeros(1,R_num);     % 补零
x_tmp(1:length(x)) = x;
y_tmp = zeros(1,R_num);     % 补零
y_tmp(1:length(y)) = y;
s = zeros(1,R_num);     % s=x+y
carry =0;         % 求差借位
for i = 1:R_num
    if x_tmp(i)-y_tmp(i)-carry>=0
        s(i)=x_tmp(i)-y_tmp(i)-carry;
        carry = 0;
    else
         s(i)=2^(R-1)+x_tmp(i)-y_tmp(i)-carry;
         carry=1;
    end
end
end


