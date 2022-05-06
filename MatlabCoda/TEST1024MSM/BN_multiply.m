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
L = 32;%32位分治
Lx = length(x);
Ly = length(y);
if Lx<Ly
    tmp = x;
    x=y;
    y=tmp;
    Lx = length(x);
    Ly = length(y);
end

cx = ceil(length(x)/L);
x_tmp = zeros(1,L*cx);
x_tmp(1:length(x)) = x;

cy = ceil(length(y)/L);
y_tmp = zeros(1,L*cy);
y_tmp(1:length(y)) = y;

% if Lx<L
%     x_tmp = zeros(1,L);     % 补零
%     x_tmp(1:length(x)) = x;
% else
%      x_tmp = x;
% end
% if Ly<L
%     y_tmp = zeros(1,L);     % 补零
%     y_tmp(1:length(y)) = y;
% else
%      y_tmp = y;
% end

factor = zeros(1,L);
s=[0];
for i = 1:length(y_tmp)/L
    temp = BN_KaratsubaMultiply(x_tmp,y_tmp((i-1)*L+1:i*L),length(x_tmp),L);
    if i ==1
        s = temp;
    else
        factor = zeros(1,L*(i-1));
        s = BN_add( Lx+Ly , R , s, [factor temp] );
    end
end
if length(s)>Lx+Ly
    s = s(1:Lx+Ly);
end


% R_num = max(length(x),length(y));
% x_tmp = zeros(1,R_num);     % 补零
% x_tmp(1:length(x)) = x;
% y_tmp = zeros(1,R_num);     % 补零
% y_tmp(1:length(y)) = y;

% REG = zeros(R_num*2,R_num);%寄存器开辟大小  保存中间结果
% for i = 1:R_num
%     REG(i,:) = y_tmp(i)*x_tmp;          % y的每一个元素与x相乘
% end
% s = zeros(1,R_num*2);           % 斜对角求和存放第一列和最后一行
% c = zeros(1,R_num*2-1);         % 斜对角求和进位
% reg_first = REG(1,:);
% for i = 1:2*R_num-1
%     reg_second = REG(i+1,:);
%     if (i==1)
%         tmp = reg_first(1);
%     else
%         tmp = reg_first(1) + c(i-1);    % 只看第一行（保存上次累加结果）和进位
%     end
%     c(i) = fix(tmp/R);%求进位
%     s(i) = mod(tmp,R);%求余存入结果数组
%     reg_first(1:R_num-1) = reg_second(1:R_num-1) + reg_first(2:R_num);%错位相加
%     reg_first(R_num) = reg_second(R_num);%错位相加 直接取下一行结果（当前行无此位）
% end
% s(R_num*2) = c(R_num*2-1);
end



% function [s] = BN_KaratsubaMultiply(x,y,Lx,Ly)
% %分治子函数
% %输入：x，y：乘数。,Lx,Ly乘数的位数
% REG = zeros(Ly+Lx,Lx);%寄存器开辟大小  保存中间结果
% for i = 1:Ly
%     if y(i) ==0
%         REG(i,:) = zeros(1,Lx);
%     else
%         REG(i,:) = x;
%     end
% end
% s = zeros(1,Ly+Lx);           % 斜对角求和存放第一列和最后一行
% c = zeros(1,Ly+Lx-1);         % 斜对角求和进位
% reg_first = REG(1,:);
% for i = 1:Ly+Lx -1
%     reg_second = REG(i+1,:);
%     if (i==1)
%         tmp = reg_first(1);
%     else
%         tmp = reg_first(1) + c(i-1);    % 只看第一行（保存上次累加结果）和进位
%     end
%     c(i) = fix(tmp/2);%求进位
%     s(i) = mod(tmp,2);%求余存入结果数组
%     reg_first(1:Lx-1) = reg_second(1:Lx-1) + reg_first(2:Lx);%错位相加
%     reg_first(Lx) = reg_second(Lx);%错位相加 直接取下一行结果（当前行无此位）
% end
% s(Ly+Lx) = c(Ly+Lx-1);
% end

