function [s] = BN_add( n , R , x, y )
%UNTITLED2 此处显示有关此函数的摘要
%  ====================================================
% Function：求大数的和  
% Input Para：n-x，y的最大位数（暂时不用，预留）；R-进制（预留）；
% x-二进制，低位在前，x（0）；y-二进制，低位在前y（0）
% Output：s-x+y，低位在前。
% Author by Wang Pengfei
% data：2022.2.25
% Revised by：
% ====================================================
% BN_add(2*n,R,tmp2,S)
%32位加法:
% C=A+B，显然C[i]不总是等于A[i]+B[i]，因为A[i]+B[i]可能>0xffffffff，而C[i]必须<=0xffffffff，这时就需要进位，
% 当然在计算C[i-1]时也可能产生了进位，所以计算C[i]时还要加上上次的进位值。
% 如果用一个64位变量result来记录和（64位是为乘法准备的，实际加减法只要33位即可）
% 另一个32位变量carry来记录进位(为什么要32位？为乘法准备的，实际加减法进位只有1)，则有：
% carry=0;
% for(i=0;i<=p;i++) ｛      //i从0到p 因为A>B
% 　　result=A[i]+B[i]+carry;
% 　　C[i]=result%0x100000000 ;   //从这里看result应该大于64位，至少65位
% 　　carry=result/0x100000000;
% ｝
% if(carry=0) n=p;
% else n=p+1;
%%
% R_num = ceil(n/log2(R));%R进制位数
% R_num = n;%R进制位数
R_num = max(length(x),length(y));
x_tmp = zeros(1,R_num);     % 补零
x_tmp(1:length(x)) = x;
y_tmp = zeros(1,R_num);     % 补零
y_tmp(1:length(y)) = y;
s = zeros(1,R_num+1);     % s=x+y
c = zeros(1,R_num+1);         % 求和进位
for i = 1:R_num
    result=x_tmp(i)+y_tmp(i)+c(i);
    s(i)=mod(result,R);
    c(i+1)=fix(result/R);
end
s(R_num+1) = c(R_num+1);
end

