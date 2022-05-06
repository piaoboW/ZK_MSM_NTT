function [s] = BN_KaratsubaMultiply(x,y,Lx,Ly)
%�����Ӻ���
%���룺x��y��������,Lx,Ly������λ��
REG = zeros(Ly+Lx,Lx);%�Ĵ������ٴ�С  �����м���
for i = 1:Ly
    if y(i) ==0
        REG(i,:) = zeros(1,Lx);
    else
        REG(i,:) = x;
    end
end
s = zeros(1,Ly+Lx);           % б�Խ���ʹ�ŵ�һ�к����һ��
c = zeros(1,Ly+Lx-1);         % б�Խ���ͽ�λ
reg_first = REG(1,:);
for i = 1:Ly+Lx -1
    reg_second = REG(i+1,:);
    if (i==1)
        tmp = reg_first(1);
    else
        tmp = reg_first(1) + c(i-1);    % ֻ����һ�У������ϴ��ۼӽ�����ͽ�λ
    end
    c(i) = fix(tmp/2);%���λ
    s(i) = mod(tmp,2);%�������������
    reg_first(1:Lx-1) = reg_second(1:Lx-1) + reg_first(2:Lx);%��λ���
    reg_first(Lx) = reg_second(Lx);%��λ��� ֱ��ȡ��һ�н������ǰ���޴�λ��
end
s(Ly+Lx) = c(Ly+Lx-1);
end