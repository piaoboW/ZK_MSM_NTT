function [s] = BN_and( n , R , x, y )
%%
%  ====================================================
% Function����λ��  
% Input Para��n-x��y�����λ������ʱ���ã�Ԥ������R-���ƣ�Ԥ������
% x-�����ƣ���λ��ǰ��x��0����y-�����ƣ���λ��ǰy��0��
% Output��s-x&y����λ��ǰ��
% Author by Wang Pengfei
% data��2022.2.25
% Revised by��
% ====================================================
% R_num = ceil(n/log2(R));%R����λ��
R_num = n;%R����λ��
s = zeros(1,R_num);   % s=x&&y
for i = 1:R_num
    s(i)=x(i)&y(i);
end
end

