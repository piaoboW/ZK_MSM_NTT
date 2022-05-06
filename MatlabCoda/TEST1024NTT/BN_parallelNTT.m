function [s] = BN_parallelNTT( n1,n2,R,x,row,col,G,G_inverse,N,N_inverse,R2modN,nR_inverse1,nR_inverse2,type)
%%
%  ====================================================
% Function��x�����۱任���д���;
% Input Para��
% n1-x�������ݵ�������2�ݴ� ��n1 = log2(row)��
% n2-x�������ݵ�������2�ݴΣ�n2 = log2(col)��
% R-���ƣ�Ԥ������Ϊ2��
% x-����,cell���ͣ�
% row - x�ֽ������
% col  - x�ֽ������
% G-ԭ����
% G_inverse-ԭ�����棻
% N-�������������ƣ���λ��ǰ��N��0����NTT��NΪ��������N=c*2^k+1; ��֤N-1Ϊ2���ݴη�����
% N_inverse-����N����Ԫ�������ƣ���λ��ǰy��0��
% R2modN:R2modN1=R^2(modN)����ҪԤ�ȼ������2^(N��λ��)^2modN
%nR_inverse1:2^row����Ԫ
%nR_inverse2:2^col����Ԫ
% type ��1ʱΪNTT��-1ʱΪINTT
% Output��s��NTT�����
% Author by Wang Pengfei
% data��2022.3.29
% Revised by��
% ====================================================
for o = length(N):-1:1
    if N(o) == 1
        break;
    end
end
% lenthN = o;%N��λ��
lenthN = 2^ nextpow2(o);%N��λ��   ����
BN_num = row*col;
Len = log2(BN_num);
if row*col~=size(x)
    disp('�����xԪ������������ֵ����')
end
x2=cell(row,col);%ԭʼ���ݷ���
for i = 1:row
    for j = 1:col
           x2{i,j} = x{(i-1)*col+j};        
    end
end
%% ��һ������NTT
s1 = cell(row,col);%�����е�NTT���
% n1 = log2(row);
for i = 1:col
    x_tmp = x2(:,i);
    s1(:,i) = BN_NTT( n1,R,x_tmp,G,G_inverse,N,N_inverse,R2modN,nR_inverse1,type);
end
% %λ�����,��������λ��   ��ʼ�任�������R(x)   FPGA��Ԥ���㣬R(x)�����ⲿDDR
% Len_row = log2(row);
% r_row= zeros(1,row);
% r_row(1) = 1;
% %rΪ�����任�������е�����
% for i=2:row
%     %
%     r_row(i) =bitor(bitshift(r_row(bitshift(i-1,-1)+1),-1),bitshift(bitand(i-1,1),Len_row-1))+1;
% end
% %��������λ��
% for i=1:row
%     if i<r_row(i)
%         s1_tmp = s1(i,:);
%         s1(i,:) = s1(r_row(i),:);
%         s1(r_row(i),:) = s1_tmp;
%     end
% end
%% �ڶ�������ת���� 
N_1 = N;
N_1(1) = 0;%NΪ������N-1ֻ���N�ĵ�λ��0��
mi = N_1(Len+1:end);%�������ƣ�������Ϊ����   (FPGA�н��ֱ��д��ddr)
%��λԭ��wn
if type==1
    wn = MontgomeryExpMod( lenthN , R, N_inverse , G , mi , N, R2modN );%(NTTʱ��FPGA�н��ֱ��д��ddr
end
if type==-1
    wn_inverse = MontgomeryExpMod( lenthN , R, N_inverse , G_inverse , mi , N, R2modN );%(INTTʱ��FPGA�н��ֱ��д��ddr
end
for i = 1:col
    for j = 1: row
        mi2_tem= fliplr(dec2bin((i-1)*(j-1)));
        mi2 = zeros();
        for k=1:size(mi2_tem,2)
            mi2(k) = str2num(mi2_tem(k));
        end
        if type==1
            wij = MontgomeryExpMod( lenthN , R, N_inverse , wn , mi2 , N, R2modN);%(NTTʱ��FPGA�н��ֱ��д��ddr
        end
        if type==-1
            wij = MontgomeryExpMod( lenthN , R, N_inverse , wn_inverse , mi2 , N, R2modN );%(INTTʱ��FPGA�н��ֱ��д��ddr
        end
        s1{i,j} = MontgomeryMultiplyMod( lenthN , R, N_inverse , wij , s1{i,j} , N, R2modN );
    end
end
%% ����������NTT
s2 = cell(row,col);%�����е�NTT���
for i = 1:row
    s_tmp = s1(i,:)';
    s2_tmp = BN_NTT( n2,R,s_tmp,G,G_inverse,N,N_inverse,R2modN,nR_inverse2,type);
    s2(i,:) = s2_tmp';
end
%% ���Ĳ� ������������ ��������õ����ս��
s3 = cell(row*col,1);
outIndex = 1;
for i = 1:col
    for j = 1:row
           s3{outIndex} = s2{j,i} ;    
           outIndex = outIndex+1;
    end
end
% %λ�����   ����Ҫλ�����
% %��ʼ�任�������R(x)   FPGA��Ԥ���㣬R(x)�����ⲿDDR
% r= zeros(1,BN_num);
% r(1) = 1;
% %rΪ�����任�������е�����
% for i=2:BN_num
%     %
%     r(i) =bitor(bitshift(r(bitshift(i-1,-1)+1),-1),bitshift(bitand(i-1,1),Len-1))+1;
% end
% %��������λ��
% for i=1:BN_num
%     if i<r(i)
%         tmp = s3{i,1};
%         s3{i,1} = s3{r(i),1};
%         s3{r(i),1} = tmp;
%     end
% end
s = s3;
end



