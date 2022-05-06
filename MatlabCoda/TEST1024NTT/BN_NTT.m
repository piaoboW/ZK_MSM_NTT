function [s] = BN_NTT( n,R,x,G,G_inverse,N,N_inverse,R2modN,nR_inverse,type)
%%
%  ====================================================
% Function：x的数论变换;
% Input Para：n-x含有数据的行数的2次幂(如x=（1000），n=3)；R-进制（预留）设为2；
% x-输入,cell类型；
% G-原根；
% G_inverse-原根的逆；
% N-大素数，二进制，低位在前，N（0）；NTT中N为费马素数N=c*2^k+1; 保证N-1为2的幂次方整除
% N_inverse-素数N的逆元，二进制，低位在前y（0）
% R2modN-R2modN=R^2(modN)，需要预先计算的数
%nR_inverse-2^n的逆元
% type ：1时为NTT，-1时为INTT
% Output：s，NTT结果。
% Author by Wang Pengfei
% data：2022.3.20
% Revised by：
% ====================================================
for o = length(N):-1:1
    if N(o) == 1
        break;
    end
end
lenthN = 2^ nextpow2(o);%N的位数   待定
N_1 = N;
N_1(1) = 0;%N为素数，N-1只需把N的低位置0；
Len = n;
BN_num = 2^n;%x中数据的数目
limit = BN_num;
%初始变换后的序列R(x)   FPGA中预计算，R(x)存入外部DDR
r= zeros(1,BN_num);
r(1) = 1;
%r为蝴蝶变换重新排列的坐标
for i=2:BN_num
    %
    r(i) =bitor(bitshift(r(bitshift(i-1,-1)+1),-1),bitshift(bitand(i-1,1),Len-1))+1;
end
%交换数据位置
for i=1:BN_num
    if i<r(i)
        tmp = x{i,1};
        x{i,1} = x{r(i),1};
        x{r(i),1} = tmp;
    end
end

mid = 1;
miBitShiftNum = 1;
while mid<limit  %可改为for循环
    mi = N_1(miBitShiftNum+1:end);%除法左移，二进制为右移   (FPGA中结果直接写入ddr)
    if type==1
        wn = MontgomeryExpMod( lenthN , R, N_inverse , G , mi , N, R2modN );%(NTT时，FPGA中结果直接写入ddr
    end
    if type==-1
        wn = MontgomeryExpMod( lenthN , R, N_inverse , G_inverse , mi , N, R2modN );%(INTT时，FPGA中结果直接写入ddr
    end
    i = 0;
    while i< limit  %可改为for循环
        w = [1];
        for j = 0:1:mid-1
            A1 = x{i+j+1,1};
            A2 = MontgomeryMultiplyMod( lenthN , R, N_inverse , w , x{i+j+1+mid,1} , N, R2modN );
            
            x{i+j+1,1} = BN_Rapidmod( lenthN , R ,  BN_add( lenthN , R , A1, A2 ), N);%注意位数
            
            x{i+j+1+mid,1} = BN_Rapidmod( lenthN , R , BN_sub( lenthN , R , BN_add( lenthN , R , A1, N ), A2 ) , N);%注意位数
            
            w = MontgomeryMultiplyMod( lenthN , R, N_inverse , w , wn , N, R2modN );
        end
        i = i+bitshift(mid,1);
    end
    mid = bitshift(mid,1);
    miBitShiftNum = miBitShiftNum+1;
end
%逆变换要除以BN_num
if type==-1
    for i=1:BN_num
            x{i,1} = MontgomeryMultiplyMod( lenthN , R, N_inverse , x{i,1}  , nR_inverse, N, R2modN );
    end
end
s = x;
  
end



