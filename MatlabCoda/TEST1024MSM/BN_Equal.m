function [ s ] = BN_Equal(a,b )
%  ====================================================
% Function�����������Ƿ���� 
% Input Para��a-�����ƣ���λ��ǰ��a��0����b-�����ƣ���λ��ǰb��0��
% Output��s-��a=b,s=1,����s = 0��
% Author by Wang Pengfei
% data��2022.3.13
% Revised by��
% ====================================================
%%x>=y����1�����򷵻�0   FPGA���Ż�
R_num = max(length(a),length(b));
x_tmp = zeros(1,R_num);     % ����
x_tmp(1:length(a)) = a;
y_tmp = zeros(1,R_num);     % ����
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

