function [ s ] = BN_Equal(a,b )
%  ====================================================
% Function：两个大数是否相等 
% Input Para：a-二进制，低位在前，a（0）；b-二进制，低位在前b（0）
% Output：s-若a=b,s=1,否则s = 0。
% Author by Wang Pengfei
% data：2022.3.13
% Revised by：
% ====================================================
%%x>=y返回1，否则返回0   FPGA待优化
R_num = max(length(a),length(b));
x_tmp = zeros(1,R_num);     % 补零
x_tmp(1:length(a)) = a;
y_tmp = zeros(1,R_num);     % 补零
y_tmp(1:length(b)) = b;

s = 1;
for i = R_num : -1 : 1
    if (x_tmp(i) ==y_tmp(i))
        continue;
    else
        s =0;
        break;
    end
end
end

