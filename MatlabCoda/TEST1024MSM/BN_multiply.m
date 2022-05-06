function [s] = BN_multiply(n,R,x,y)
%%  ====================================================
% Function�������˷�  
% Input Para��n-x��y�����λ������ʱ���ã�Ԥ������R-���ƣ�Ԥ������
% x-�����ƣ���λ��ǰ��x��0����y-�����ƣ���λ��ǰy��0��
% Output��s-x*y����λ��ǰ��
% Author by Wang Pengfei
% data��2022.2.27
% Revised by��
% ====================================================
%% 
% C=A*B���ճ����˷����õġ���ʽ���㡱���̣�
% 
% ������������  ��������������A3 A2 A1 A0
% ������������    ��������������* B2 B1 B0
% ------------------------------------------
% ���������� ����= A3B0 A2B0 A1B0 A0B0
% �������� + A3B1 A2B1 A1B1 A0B1
%     + A3B2 A2B2 A1B2 A0B2
% ------------------------------------------
% =        C5     C4     C3    C2    C1     C0
% ���Թ��ɳ���C[i]=Sum[j=0 to q](A[i-j]*B[j]) (ע����C[i])������i-j����>=0��<=p��
% ����A[i-j]*B[j]��Sum��ʱ�򶼿��ܷ�����λ�����տ��������㷨��ɳ˷���
% C = Sum[i= 0 to n](C[i]*r**i) =  Sum[i= 0 to n] ( Sum[j=0 to q](A[i-j]*B[j])  *r**i).(�����n=p+q-1��������nλ�������н�λʱnӦ��1)

%%
% R_num = ceil(n/log2(R));%R����λ��
% R_num = n;%R����λ��
L = 32;%32λ����
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
%     x_tmp = zeros(1,L);     % ����
%     x_tmp(1:length(x)) = x;
% else
%      x_tmp = x;
% end
% if Ly<L
%     y_tmp = zeros(1,L);     % ����
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
% x_tmp = zeros(1,R_num);     % ����
% x_tmp(1:length(x)) = x;
% y_tmp = zeros(1,R_num);     % ����
% y_tmp(1:length(y)) = y;

% REG = zeros(R_num*2,R_num);%�Ĵ������ٴ�С  �����м���
% for i = 1:R_num
%     REG(i,:) = y_tmp(i)*x_tmp;          % y��ÿһ��Ԫ����x���
% end
% s = zeros(1,R_num*2);           % б�Խ���ʹ�ŵ�һ�к����һ��
% c = zeros(1,R_num*2-1);         % б�Խ���ͽ�λ
% reg_first = REG(1,:);
% for i = 1:2*R_num-1
%     reg_second = REG(i+1,:);
%     if (i==1)
%         tmp = reg_first(1);
%     else
%         tmp = reg_first(1) + c(i-1);    % ֻ����һ�У������ϴ��ۼӽ�����ͽ�λ
%     end
%     c(i) = fix(tmp/R);%���λ
%     s(i) = mod(tmp,R);%�������������
%     reg_first(1:R_num-1) = reg_second(1:R_num-1) + reg_first(2:R_num);%��λ���
%     reg_first(R_num) = reg_second(R_num);%��λ��� ֱ��ȡ��һ�н������ǰ���޴�λ��
% end
% s(R_num*2) = c(R_num*2-1);
end



% function [s] = BN_KaratsubaMultiply(x,y,Lx,Ly)
% %�����Ӻ���
% %���룺x��y��������,Lx,Ly������λ��
% REG = zeros(Ly+Lx,Lx);%�Ĵ������ٴ�С  �����м���
% for i = 1:Ly
%     if y(i) ==0
%         REG(i,:) = zeros(1,Lx);
%     else
%         REG(i,:) = x;
%     end
% end
% s = zeros(1,Ly+Lx);           % б�Խ���ʹ�ŵ�һ�к����һ��
% c = zeros(1,Ly+Lx-1);         % б�Խ���ͽ�λ
% reg_first = REG(1,:);
% for i = 1:Ly+Lx -1
%     reg_second = REG(i+1,:);
%     if (i==1)
%         tmp = reg_first(1);
%     else
%         tmp = reg_first(1) + c(i-1);    % ֻ����һ�У������ϴ��ۼӽ�����ͽ�λ
%     end
%     c(i) = fix(tmp/2);%���λ
%     s(i) = mod(tmp,2);%�������������
%     reg_first(1:Lx-1) = reg_second(1:Lx-1) + reg_first(2:Lx);%��λ���
%     reg_first(Lx) = reg_second(Lx);%��λ��� ֱ��ȡ��һ�н������ǰ���޴�λ��
% end
% s(Ly+Lx) = c(Ly+Lx-1);
% end

