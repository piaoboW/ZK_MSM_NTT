function [ MonMod ] = MontgomeryMultiplyMod( n , R, N_inverse , A , B , N, R2modN )
%%
%  ====================================================
% Function���ɸ�������ģ������
% Input Para��n-����N�����λ����
% R-���ƣ�Ԥ����R=2��
% N-�������������ƣ���λ��ǰ��N��0����
% N_inverse-����N����Ԫ�������ƣ���λ��ǰy��0��
% A-ģ�˵�����B-ģ�˵���
% R2modN-R2modN=R^2(modN)����ҪԤ�ȼ������
% Output��MonMod = A*B(modN)��ģ�˽����
% Author by Wang Pengfei
% data��2022.3.12
% Revised by��
% ====================================================
A2_tmp =BN_multiply(n,R,A,R2modN);
A2 = MontgomeryReduction( n , R, N_inverse , A2_tmp , N );
B2_tmp =BN_multiply(n,R,B,R2modN);
B2 = MontgomeryReduction( n , R, N_inverse , B2_tmp , N );
A2B2 = BN_multiply(n,R,A2,B2);
ABR=MontgomeryReduction( n , R, N_inverse , A2B2 , N );
MonMod = MontgomeryReduction( n , R, N_inverse , ABR , N );
end


