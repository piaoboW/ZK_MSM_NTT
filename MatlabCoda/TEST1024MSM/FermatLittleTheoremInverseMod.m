function [ inverseValue ] = FermatLittleTheoremInverseMod( n , R, N_inverse , A ,  N, R2modN )
%%
%  ====================================================
% Function������С����/ŷ����������Ԫ����pλ����a^(p-1)=1(mod p);��a^(p-2)Ϊa����Ԫ��
% Input Para��n-����N�����λ����
% R-���ƣ�Ԥ����R=2��
% N-�������������ƣ���λ��ǰ��N��0����
% N_inverse-����N����Ԫ�������ƣ���λ��ǰy��0��
% A-Ҫ����Ԫ��Ԫ��
% R2modN-R2modN=R^2(modN)����ҪԤ�ȼ������
% Output��inverseValue = A^��p-2��(modN)=A_inverse��
% Author by Wang Pengfei
% data��2022.3.13
% Revised by��
% ====================================================
% p�����λ������0
for o = length(N):-1:1
    if N(o) == 1
        break;
    end
end
N = N(1:o);

for k = length(A):-1:1
    if A(k) == 1
        break;
    end
end
A = A(1:k);

B = BN_sub(n , R , N, [0 1]);
inverseValue = MontgomeryExpMod( n , R, N_inverse , A , B , N, R2modN );
end
