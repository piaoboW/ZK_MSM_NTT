function [s] = BN_compare( x, y )
%  ====================================================
% Function�����������Ƚ� 
% Input Para��x-�����ƣ���λ��ǰ��x��0����y-�����ƣ���λ��ǰy��0��
% Output��s-��x>=y,s=1,����s = 0��
% Author by Wang Pengfei
% data��2022.3.11
% Revised by��
% ====================================================
%%x>=y����1�����򷵻�0   FPGA���Ż�
R_num = max(length(x),length(y));
x_tmp = zeros(1,R_num);     % ����
x_tmp(1:length(x)) = x;
y_tmp = zeros(1,R_num);     % ����
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

