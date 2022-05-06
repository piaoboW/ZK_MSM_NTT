function [x y] = BN_PMULT( n,R,x1,y1,k,N,a,b,N_inverse,R2modN)
%%
%  ====================================================
% Function����Բ����y^2=x^3+ax+b�ϱ�����;
% Input Para��n-x1��y1�����λ������ʱ���ã�Ԥ������R-���ƣ�Ԥ������
%EC��P (x1,y1)-�����ƣ���λ��ǰ��
% N-�������������ƣ���λ��ǰ��N��0����
% k-�����˷����ӣ���λ��ǰ��k��0����
% a,b-��Բ���߲���
% N_inverse-����N����Ԫ�������ƣ���λ��ǰy��0��
% R2modN-R2modN=R^2(modN)����ҪԤ�ȼ������
% Output��kP����λ��ǰ��
% Author by Wang Pengfei
% data��2022.3.15
% Revised by��
% ====================================================
%ȷ��k��λΪ1
for i=length(k):-1:1
    if k(i)==1
        break;
    end
end
k_tmp = k(1:i);
x = [0];
y = [0];
x_tmp = x1;
y_tmp = y1;
for i = 1:length(k_tmp)
    if k_tmp(i)==1
        [x,y] = BN_PADD( n,R,x,y,x_tmp,y_tmp,N,a,b,N_inverse,R2modN);
    end
    [x_tmp,y_tmp] = BN_PADD( n,R,x_tmp,y_tmp,x_tmp,y_tmp,N,a,b,N_inverse,R2modN);
end
end



