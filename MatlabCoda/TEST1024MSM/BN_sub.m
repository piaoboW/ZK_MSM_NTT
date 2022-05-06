function [s] = BN_sub( n , R , x, y )
%%
%  ====================================================
% Function��������Ĳ� s=x-y;x>y
% Input Para��n-x��y�����λ������ʱ���ã�Ԥ������R-���ƣ�Ԥ������
% x-�����ƣ���λ��ǰ��x��0����y-�����ƣ���λ��ǰy��0��
% Output��s-x-y����λ��ǰ��
% Author by Wang Pengfei
% data��2022.3.6
% Revised by��
% ====================================================
% R_num = ceil(n/log2(R));%R����λ��
% R_num = n;%R����λ��
R_num = max(length(x),length(y));
x_tmp = zeros(1,R_num);     % ����
x_tmp(1:length(x)) = x;
y_tmp = zeros(1,R_num);     % ����
y_tmp(1:length(y)) = y;
s = zeros(1,R_num);     % s=x+y
carry =0;         % ����λ
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


