function [ MonExpMod ] = MontgomeryExpMod( n , R, N_inverse , A , B , N, R2modN )
%%
%  ====================================================
% Function���ɸ���������ģ����
% Input Para��n-����N�����λ����
% R-���ƣ�Ԥ����R=2��
% N-�������������ƣ���λ��ǰ��N��0����
% N_inverse-����N����Ԫ�������ƣ���λ��ǰy��0��
% A-�ݵף�B-ָ��
% R2modN-R2modN=R^2(modN)����ҪԤ�ȼ������
% Output��MonExpMod = A^B(modN)�������
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

for m = length(B):-1:1
    if B(m) == 1
        break;
    end
end
B = B(1:m);

for k = length(A):-1:1
    if A(k) == 1
        break;
    end
end
A = A(1:k);

rs=zeros();
rs(1)=1;
for i=length(B):-1:1
    rs = MontgomeryMultiplyMod( n , R, N_inverse , rs , rs, N, R2modN );
    if B(i)==1
        rs = MontgomeryMultiplyMod( n , R, N_inverse , rs , A, N, R2modN );
    end
end
MonExpMod = rs;
end



