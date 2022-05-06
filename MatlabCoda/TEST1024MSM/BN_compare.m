function [s] = BN_compare( x, y )
%  ====================================================
% Function：两个大数比较 
% Input Para：x-二进制，低位在前，x（0）；y-二进制，低位在前y（0）
% Output：s-若x>=y,s=1,否则s = 0。
% Author by Wang Pengfei
% data：2022.3.11
% Revised by：
% ====================================================
%%x>=y返回1，否则返回0   FPGA待优化
R_num = max(length(x),length(y));
x_tmp = zeros(1,R_num);     % 补零
x_tmp(1:length(x)) = x;
y_tmp = zeros(1,R_num);     % 补零
y_tmp(1:length(y)) = y;

 s = 1;
 for i = R_num : -1 : 1
     if (x_tmp(i)>y_tmp(i))
         break;
     end
     if (x_tmp(i)<y_tmp(i))
         s = 0;
         break;
     end
 end
end

