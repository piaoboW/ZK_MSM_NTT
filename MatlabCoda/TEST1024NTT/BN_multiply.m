function [s] = BN_multiply(n,R,x,y)
%%  ====================================================
% Function：大数乘法  
% Input Para：n-x，y的最大位数（暂时不用，预留）；R-进制（预留）；
% x-二进制，低位在前，x（0）；y-二进制，低位在前y（0）
% Output：s-x*y，低位在前。
% Author by Wang Pengfei
% data：2022.2.27
% Revised by：
% ====================================================
%% 
% C=A*B，日常做乘法所用的“竖式计算”过程：
% 
% 　　　　　　  　　　　　　　A3 A2 A1 A0
% 　　　　　　    　　　　　　　* B2 B1 B0
% ------------------------------------------
% 　　　　　 　　= A3B0 A2B0 A1B0 A0B0
% 　　　　 + A3B1 A2B1 A1B1 A0B1
%     + A3B2 A2B2 A1B2 A0B2
% ------------------------------------------
% =        C5     C4     C3    C2    C1     C0
% 可以归纳出：C[i]=Sum[j=0 to q](A[i-j]*B[j]) (注意是C[i])，其中i-j必须>=0且<=p。
% 计算A[i-j]*B[j]和Sum的时候都可能发生进位。最终可用如下算法完成乘法：
% C = Sum[i= 0 to n](C[i]*r**i) =  Sum[i= 0 to n] ( Sum[j=0 to q](A[i-j]*B[j])  *r**i).(这里的n=p+q-1，但当第n位的运算有进位时n应加1)

%%
% R_num = ceil(n/log2(R));%R进制位数
% R_num = n;%R进制位数
R_num = max(length(x),length(y));
x_tmp = zeros(1,R_num);     % 补零
x_tmp(1:length(x)) = x;
y_tmp = zeros(1,R_num);     % 补零
y_tmp(1:length(y)) = y;

REG = zeros(R_num*2,R_num);%寄存器开辟大小  保存中间结果
for i = 1:R_num
    REG(i,:) = y_tmp(i)*x_tmp;          % y的每一个元素与x相乘
end
s = zeros(1,R_num*2);           % 斜对角求和存放第一列和最后一行
c = zeros(1,R_num*2-1);         % 斜对角求和进位
reg_first = REG(1,:);
for i = 1:2*R_num-1
    reg_second = REG(i+1,:);
    if (i==1)
        tmp = reg_first(1);
    else
        tmp = reg_first(1) + c(i-1);    % 只看第一行（保存上次累加结果）和进位
    end
    c(i) = fix(tmp/R);%求进位
    s(i) = mod(tmp,R);%求余存入结果数组
    reg_first(1:R_num-1) = reg_second(1:R_num-1) + reg_first(2:R_num);%错位相加
    reg_first(R_num) = reg_second(R_num);%错位相加 直接取下一行结果（当前行无此位）
end
s(R_num*2) = c(R_num*2-1);
end

