function [s] = BN_KaratsubaMultiply(x,y,Lx,Ly)
%分治子函数
%输入：x，y：乘数。,Lx,Ly乘数的位数
REG = zeros(Ly+Lx,Lx);%寄存器开辟大小  保存中间结果
for i = 1:Ly
    if y(i) ==0
        REG(i,:) = zeros(1,Lx);
    else
        REG(i,:) = x;
    end
end
s = zeros(1,Ly+Lx);           % 斜对角求和存放第一列和最后一行
c = zeros(1,Ly+Lx-1);         % 斜对角求和进位
reg_first = REG(1,:);
for i = 1:Ly+Lx -1
    reg_second = REG(i+1,:);
    if (i==1)
        tmp = reg_first(1);
    else
        tmp = reg_first(1) + c(i-1);    % 只看第一行（保存上次累加结果）和进位
    end
    c(i) = fix(tmp/2);%求进位
    s(i) = mod(tmp,2);%求余存入结果数组
    reg_first(1:Lx-1) = reg_second(1:Lx-1) + reg_first(2:Lx);%错位相加
    reg_first(Lx) = reg_second(Lx);%错位相加 直接取下一行结果（当前行无此位）
end
s(Ly+Lx) = c(Ly+Lx-1);
end