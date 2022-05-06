function [s] = BN_NTT( n,R,x,G,G_inverse,N,N_inverse,R2modN,nR_inverse,type)
%%
%  ====================================================
% Function��x�����۱任;
% Input Para��n-x�������ݵ�������2����(��x=��1000����n=3)��R-���ƣ�Ԥ������Ϊ2��
% x-����,cell���ͣ�
% G-ԭ����
% G_inverse-ԭ�����棻
% N-�������������ƣ���λ��ǰ��N��0����NTT��NΪ��������N=c*2^k+1; ��֤N-1Ϊ2���ݴη�����
% N_inverse-����N����Ԫ�������ƣ���λ��ǰy��0��
% R2modN-R2modN=R^2(modN)����ҪԤ�ȼ������
%nR_inverse-2^n����Ԫ
% type ��1ʱΪNTT��-1ʱΪINTT
% Output��s��NTT�����
% Author by Wang Pengfei
% data��2022.3.20
% Revised by��
% ====================================================
for o = length(N):-1:1
    if N(o) == 1
        break;
    end
end
lenthN = 2^ nextpow2(o);%N��λ��   ����
N_1 = N;
N_1(1) = 0;%NΪ������N-1ֻ���N�ĵ�λ��0��
Len = n;
BN_num = 2^n;%x�����ݵ���Ŀ
limit = BN_num;
%��ʼ�任�������R(x)   FPGA��Ԥ���㣬R(x)�����ⲿDDR
r= zeros(1,BN_num);
r(1) = 1;
%rΪ�����任�������е�����
for i=2:BN_num
    %
    r(i) =bitor(bitshift(r(bitshift(i-1,-1)+1),-1),bitshift(bitand(i-1,1),Len-1))+1;
end
%��������λ��
for i=1:BN_num
    if i<r(i)
        tmp = x{i,1};
        x{i,1} = x{r(i),1};
        x{r(i),1} = tmp;
    end
end

mid = 1;
miBitShiftNum = 1;
while mid<limit  %�ɸ�Ϊforѭ��
    mi = N_1(miBitShiftNum+1:end);%�������ƣ�������Ϊ����   (FPGA�н��ֱ��д��ddr)
    if type==1
        wn = MontgomeryExpMod( lenthN , R, N_inverse , G , mi , N, R2modN );%(NTTʱ��FPGA�н��ֱ��д��ddr
    end
    if type==-1
        wn = MontgomeryExpMod( lenthN , R, N_inverse , G_inverse , mi , N, R2modN );%(INTTʱ��FPGA�н��ֱ��д��ddr
    end
    i = 0;
    while i< limit  %�ɸ�Ϊforѭ��
        w = [1];
        for j = 0:1:mid-1
            A1 = x{i+j+1,1};
            A2 = MontgomeryMultiplyMod( lenthN , R, N_inverse , w , x{i+j+1+mid,1} , N, R2modN );
            
            x{i+j+1,1} = BN_Rapidmod( lenthN , R ,  BN_add( lenthN , R , A1, A2 ), N);%ע��λ��
            
            x{i+j+1+mid,1} = BN_Rapidmod( lenthN , R , BN_sub( lenthN , R , BN_add( lenthN , R , A1, N ), A2 ) , N);%ע��λ��
            
            w = MontgomeryMultiplyMod( lenthN , R, N_inverse , w , wn , N, R2modN );
        end
        i = i+bitshift(mid,1);
    end
    mid = bitshift(mid,1);
    miBitShiftNum = miBitShiftNum+1;
end
%��任Ҫ����BN_num
if type==-1
    for i=1:BN_num
            x{i,1} = MontgomeryMultiplyMod( lenthN , R, N_inverse , x{i,1}  , nR_inverse, N, R2modN );
    end
end
s = x;
  
end



