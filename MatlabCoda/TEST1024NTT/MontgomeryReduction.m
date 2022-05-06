function [ Mon ] = MontgomeryReduction( n , R, N_inverse , T , N )
%%
%  ====================================================
% Function���ɸ�����Լ��
% Input Para��n-����N�����λ����
% R-���ƣ�Ԥ����R=2��
% N-�������������ƣ���λ��ǰ��N��0����
% N_inverse-����N����Ԫ�������ƣ���λ��ǰy��0��
% T-��ҪԼ����� T<2^n
% Output��Mon = T*R_inverse (modN)��
% Author by Wang Pengfei
% data��2022.3.12
% Revised by��
% ====================================================
% �ɸ�����Լ�� R��ʾ����
%   �ο���[2]�ɸ������㷨�ɸ�����Լ��ģ�ˡ�ģ��
% k = log2(R);
% R_num = ceil(n/k);
R_num = n;%   ֱ��ȡ���Ƶ�λ��   
Nc = N_inverse;%Nc = N_inverse mod R^n��NC��ʾN��������RR ��?NN ��=1��
if length(T)< R_num
    m_tmp1 = T;
else
    m_tmp1 = T(1:R_num);                        % m_tmp1 = mod(T,R^n), ģR�൱����λ
end
m_tmp2 = BN_multiply(n,R,m_tmp1,Nc); %m_tmp2 = m_tmp1*N_inverse
m = m_tmp2(1:R_num); % t = mod(m_tmp2,R^n);    ��������ϵ��

t_tmp1 = BN_multiply(n,R,m,N);  %t_tmp1 = m*N
t_tmp2 = BN_add(2*n,R,t_tmp1,T);
% Mon = t_tmp2(R_num+1:2*R_num+1); % Mon = (T + m*N)/R, Montgomeryģ��Լ�����ʽ
Mon = t_tmp2(R_num+1:end); % Mon = (T + m*N)/R, Montgomeryģ��Լ�����ʽ

if (BN_compare( Mon, N ))
    [Mon] = BN_sub( n , R , Mon, N );  % if Mon>=N,then Mon=Mon-N
end
Mon = Mon(1:R_num);
end



