function [s] = BN_quikExpMod( a , p , N )
%%
%  ====================================================
% Function��������ģ  Ԥ����������
% Input Para��a�ݵף�
% p-����  p=N-2��
%mod-ģ
% Output��a^p ��mod N����
% Author by Wang Pengfei
% data��2022.4.14
% Revised by��
% ====================================================
s =[1];
for n = length(p):-1:1
    if p(n) == 1
        break;
    end
end
p = p(1:n);

% while length(p)>=1
for i = n:-1:1
    if p(1) ==1
        s=BN_multiply(0,2,s,a);
        s = BN_Rapidmod( 0 , 2 , s , N);
    end
    a = BN_multiply(0,2,a,a);
    p = p(2:end);%��λ
    a = BN_Rapidmod( 0 , 2 , a , N);
end
end


