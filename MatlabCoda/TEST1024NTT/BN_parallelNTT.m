function [s] = BN_parallelNTT( n1,n2,R,x,row,col,G,G_inverse,N,N_inverse,R2modN,nR_inverse1,nR_inverse2,type)
%%
%  ====================================================
% Function：x的数论变换并行处理;
% Input Para：
% n1-x含有数据的行数的2幂次 ，n1 = log2(row)；
% n2-x含有数据的列数的2幂次；n2 = log2(col)；
% R-进制（预留）设为2；
% x-输入,cell类型；
% row - x分解的行数
% col  - x分解的列数
% G-原根；
% G_inverse-原根的逆；
% N-大素数，二进制，低位在前，N（0）；NTT中N为费马素数N=c*2^k+1; 保证N-1为2的幂次方整除
% N_inverse-素数N的逆元，二进制，低位在前y（0）
% R2modN:R2modN1=R^2(modN)，需要预先计算的数2^(N的位数)^2modN
%nR_inverse1:2^row的逆元
%nR_inverse2:2^col的逆元
% type ：1时为NTT，-1时为INTT
% Output：s，NTT结果。
% Author by Wang Pengfei
% data：2022.3.29
% Revised by：
% ====================================================
for o = length(N):-1:1
    if N(o) == 1
        break;
    end
end
% lenthN = o;%N的位数
lenthN = 2^ nextpow2(o);%N的位数   待定
BN_num = row*col;
Len = log2(BN_num);
if row*col~=size(x)
    disp('输入的x元素数量与行列值有误！')
end
x2=cell(row,col);%原始数据分组
for i = 1:row
    for j = 1:col
           x2{i,j} = x{(i-1)*col+j};        
    end
end
%% 第一步按列NTT
s1 = cell(row,col);%保存列的NTT结果
% n1 = log2(row);
for i = 1:col
    x_tmp = x2(:,i);
    s1(:,i) = BN_NTT( n1,R,x_tmp,G,G_inverse,N,N_inverse,R2modN,nR_inverse1,type);
end
% %位逆操作,交换数据位置   初始变换后的序列R(x)   FPGA中预计算，R(x)存入外部DDR
% Len_row = log2(row);
% r_row= zeros(1,row);
% r_row(1) = 1;
% %r为蝴蝶变换重新排列的坐标
% for i=2:row
%     %
%     r_row(i) =bitor(bitshift(r_row(bitshift(i-1,-1)+1),-1),bitshift(bitand(i-1,1),Len_row-1))+1;
% end
% %交换数据位置
% for i=1:row
%     if i<r_row(i)
%         s1_tmp = s1(i,:);
%         s1(i,:) = s1(r_row(i),:);
%         s1(r_row(i),:) = s1_tmp;
%     end
% end
%% 第二步乘旋转因子 
N_1 = N;
N_1(1) = 0;%N为素数，N-1只需把N的低位置0；
mi = N_1(Len+1:end);%除法左移，二进制为右移   (FPGA中结果直接写入ddr)
%单位原根wn
if type==1
    wn = MontgomeryExpMod( lenthN , R, N_inverse , G , mi , N, R2modN );%(NTT时，FPGA中结果直接写入ddr
end
if type==-1
    wn_inverse = MontgomeryExpMod( lenthN , R, N_inverse , G_inverse , mi , N, R2modN );%(INTT时，FPGA中结果直接写入ddr
end
for i = 1:col
    for j = 1: row
        mi2_tem= fliplr(dec2bin((i-1)*(j-1)));
        mi2 = zeros();
        for k=1:size(mi2_tem,2)
            mi2(k) = str2num(mi2_tem(k));
        end
        if type==1
            wij = MontgomeryExpMod( lenthN , R, N_inverse , wn , mi2 , N, R2modN);%(NTT时，FPGA中结果直接写入ddr
        end
        if type==-1
            wij = MontgomeryExpMod( lenthN , R, N_inverse , wn_inverse , mi2 , N, R2modN );%(INTT时，FPGA中结果直接写入ddr
        end
        s1{i,j} = MontgomeryMultiplyMod( lenthN , R, N_inverse , wij , s1{i,j} , N, R2modN );
    end
end
%% 第三步按行NTT
s2 = cell(row,col);%保存行的NTT结果
for i = 1:row
    s_tmp = s1(i,:)';
    s2_tmp = BN_NTT( n2,R,s_tmp,G,G_inverse,N,N_inverse,R2modN,nR_inverse2,type);
    s2(i,:) = s2_tmp';
end
%% 第四步 数据重新排列 按列输出得到最终结果
s3 = cell(row*col,1);
outIndex = 1;
for i = 1:col
    for j = 1:row
           s3{outIndex} = s2{j,i} ;    
           outIndex = outIndex+1;
    end
end
% %位逆操作   不需要位逆操作
% %初始变换后的序列R(x)   FPGA中预计算，R(x)存入外部DDR
% r= zeros(1,BN_num);
% r(1) = 1;
% %r为蝴蝶变换重新排列的坐标
% for i=2:BN_num
%     %
%     r(i) =bitor(bitshift(r(bitshift(i-1,-1)+1),-1),bitshift(bitand(i-1,1),Len-1))+1;
% end
% %交换数据位置
% for i=1:BN_num
%     if i<r(i)
%         tmp = s3{i,1};
%         s3{i,1} = s3{r(i),1};
%         s3{r(i),1} = tmp;
%     end
% end
s = s3;
end



