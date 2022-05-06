
close all;clear all;clc;
%% test BN_NTT  8个
% G = [1 1];%3
% G_inverse = [0 1 1 0 1 0 1 0 1 0 1 0 1 0 1];%21846
% N = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];%65537
% N_inverse= [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];%N_inverse = 65535,       -N=65535
% R2modN = [0 0 1];%4
% R = 2;
% n = 3;%n=log2(size(x))
% nR_inverse = [1 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1];%2^n的逆元=57345
% x=cell(8,1);%x的值随意取几个数 看看正反变换完是不是原来的数
% x{1,1} = [0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1];%32784
% x{2,1} = [0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 1];%32771
% x{3,1} = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];%32768
% x{4,1} = [0 0 1 0 0 0 0 1 0 0 0 1];%2180
% x{5,1} = [0 0 0  0 1 0 0 0 0 0 1 0 0 1];%9232
% x{6,1} = [0 1 0 0 0 0 0 1 0 0 0 1 0 0 1];%18562
% x{7,1} = [1 0 0 0 0 0 0 0 1 0 0 0 0 1];%8449
% x{8,1} = [1 1 0 0 1 0 0 0 0 1 0 1 1];%6675
% 
% %正变换
% s = BN_NTT( n,R,x,G,G_inverse,N,N_inverse,R2modN,nR_inverse,1);
% %反变换
% s2 = BN_NTT( n,R,s,G,G_inverse,N,N_inverse,R2modN,nR_inverse,-1);

%% test BN_NTT   16个数 位逆操作，迭代处理
% G = [1 1];%3
% G_inverse = [0 1 1 0 1 0 1 0 1 0 1 0 1 0 1];%21846
% N = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];%65537
% N_inverse= [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];%N_inverse = 65535,       -N=65535
% R2modN = [0 0 1];%4
% R = 2;
% n = 4;%n=log2(size(x))
% nR_inverse = [1 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1];%2^n的逆元=61441
% x=cell(2^n,1);%x的值随意取几个数 看看正反变换完是不是原来的数
% x{1,1} = [0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1];%32784
% x{2,1} = [0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 1];%32771
% x{3,1} = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];%32768
% x{4,1} = [0 0 1 0 0 0 0 1 0 0 0 1];%2180
% x{5,1} = [0 0 0  0 1 0 0 0 0 0 1 0 0 1];%9232
% x{6,1} = [0 1 0 0 0 0 0 1 0 0 0 1 0 0 1];%18562
% x{7,1} = [1 0 0 0 0 0 0 0 1 0 0 0 0 1];%8449
% x{8,1} = [1 1 0 0 1 0 0 0 0 1 0 1 1];%6675
% x{9,1} = [0 1 0 0 1 0 0 0 0 0 0 1 0 0 0 1];%
% x{10,1} = [0 0 1 0 1 0 0 0 0 0 0 0 1 0 0 1];%
% x{11,1} = [0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1];%
% x{12,1} = [0 0 1 0 1 0 0 1 0 0 0 1];%
% x{13,1} = [0 0 1  0 1 0 0 0 0 0 1 0 0 1];%
% x{14,1} = [0 1 0 0 0 0 0 1 0 1 0 1 0 0 1];%
% x{15,1} = [1 0 1 0 0 0 0 1 1 1 0 0 0 1];%
% x{16,1} = [1 1 0 0 1 0 0 1 1 1 0 1 1];%
% 
% %正变换
% s = BN_NTT( n,R,x,G,G_inverse,N,N_inverse,R2modN,nR_inverse,1);
% %反变换
% s2 = BN_NTT( n,R,s,G,G_inverse,N,N_inverse,R2modN,nR_inverse,-1);


%% 验证原根
% g = [0 1 1 0 1];
% mi = N(11:end);
% gn = MontgomeryExpMod( 256 , 2, N_inverse , g , mi , N, R2modN);


%% test  BN_parallelNTT   16个数分为4*4并行处理
% G = [1 1];%3
% G_inverse = [0 1 1 0 1 0 1 0 1 0 1 0 1 0 1];%21846
% N = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];%65537
% N_inverse= [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];%N_inverse = 65535,       -N=65535
% R2modN = [0 0 1];%4
% R = 2;
% n = 4;%n=log2(size(x))
% n1 = 2;
% n2 = 2;
% nR_inverse = [1 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1];%2^n的逆元=61441
% x=cell(2^n,1);%x的值随意取几个数 看看正反变换完是不是原来的数
% x{1,1} = [0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1];%32784
% x{2,1} = [0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 1];%32771
% x{3,1} = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];%32768
% x{4,1} = [0 0 1 0 0 0 0 1 0 0 0 1];%2180
% x{5,1} = [0 0 0  0 1 0 0 0 0 0 1 0 0 1];%9232
% x{6,1} = [0 1 0 0 0 0 0 1 0 0 0 1 0 0 1];%18562
% x{7,1} = [1 0 0 0 0 0 0 0 1 0 0 0 0 1];%8449
% x{8,1} = [1 1 0 0 1 0 0 0 0 1 0 1 1];%6675
% x{9,1} = [0 1 0 0 1 0 0 0 0 0 0 1 0 0 0 1];%
% x{10,1} = [0 0 1 0 1 0 0 0 0 0 0 0 1 0 0 1];%
% x{11,1} = [0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1];%
% x{12,1} = [0 0 1 0 1 0 0 1 0 0 0 1];%
% x{13,1} = [0 0 1  0 1 0 0 0 0 0 1 0 0 1];%
% x{14,1} = [0 1 0 0 0 0 0 1 0 1 0 1 0 0 1];%
% x{15,1} = [1 0 1 0 0 0 0 1 1 1 0 0 0 1];%
% x{16,1} = [1 1 0 0 1 0 0 1 1 1 0 1 1];%
% 
% %正变换
% row = 4;
% col = 4;
% nR_inverse1 = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1];%2^n1的逆元=49153
% nR_inverse2 = nR_inverse1;
% s3 = BN_parallelNTT( n1,n2,R,x,row,col,G,G_inverse,N,N_inverse,R2modN,nR_inverse1,nR_inverse2,1);
% %反变换
% s4 = BN_parallelNTT( n1,n2,R,s3,row,col,G,G_inverse,N,N_inverse,R2modN,nR_inverse1,nR_inverse2,-1);


%% 读实际的数据
% fileID = fopen('fft-input','r','l');
% number1 = fread(fileID,inf,'ubit1');%'ubit1'\f
% fclose(fileID);
% inputdata = reshape(number1,256,1029)';
% % 
% fileID = fopen('fft-output','r','l');
% number2 = fread(fileID,inf,'ubit1');%'ubit1'
% fclose(fileID);
% outputdata = reshape(number2,256,1024)';
% % 保存
% save inputdata inputdata
% save outputdata outputdata

% fileID = fopen('ifft-input','r','l');
% number3 = fread(fileID,inf,'ubit1');%'ubit1'\f
% fclose(fileID);
% ifftinputdata = reshape(number3,256,1029)';
% 
% fileID = fopen('ifft-output','r','l');
% number4 = fread(fileID,inf,'ubit1');%'ubit1'
% fclose(fileID);
% ifftoutputdata = reshape(number4,256,1024)';
% 保存
% save ifftinputdata ifftinputdata
% save ifftoutputdata ifftoutputdata

%% 测试实际数据  曲线bls12_377
parallelFlag = 1;%串并行设置  0为穿行，1为并行
load ('inputdata.mat');%前32770有数，NTT有效数有1024个。
N = inputdata(1,:);%
% G =  inputdata(2,:);%
G = [0 1 1 0 1];
% G_inverse2 =inputdata(3,:);%
R_inverse2 = inputdata(4,:);
R2modN2 = inputdata(5,:);
%求逆
n=256;%N的位数  0也算
R=2;%进制R=2^6=64
RR = zeros(1,n+1);%R=2^256
RR(end) = 1;
RR_sub2 = BN_sub( n+1 , 2 , RR, [0 1]);
N_negative = BN_sub( n+1 , 2 , RR, N );
%%**********求N_inverse。N_inverse*（-N）=1mod R,**************
% Ntmp = '00110100110010010110100001111101001101000101100101001010101010110001001001001011101100101110000110100011110010000101000000000000001000101001000100001011111001100100100000000000000000000000000010000101000010001011111111111111111111111111111111111111111111111';
% for n = length(Ntmp):-1:1
%      N_inverse(1,length(Ntmp)-n+1) = str2num(Ntmp(n));
% end
%  N_inverse = N_inverse(1:255);
% save N_inverse N_inverse
load N_inverse

%%**********验证N_inverse**************
% tmp = BN_multiply(n+1,2,N_inverse,N_negative);
% result = BN_Rapidmod( n+1 , 2 , tmp , RR);

%%**********求R_inverse。R*R_inverse=1mod N,**************
% Rtmp = '00000011110110011000000011001000100100010100100001100000000101100100000111000010101010111111000100010011110110010100011100010111110111101000111101010111010010101011101001111111011101000011101010100000100100010110111010001101000011011111011101110110000000010';
% for n = length(Rtmp):-1:1
%      R_inverse(1,length(Rtmp)-n+1) = str2num(Rtmp(n));
% end
%  R_inverse = R_inverse(1:251);
%  save R_inverse R_inverse
load R_inverse

%%**********验证R_inverse**************
% tmp = BN_multiply(n+1,2,R_inverse,RR);
% result = BN_Rapidmod( n , 2 , tmp , N);

%%****************R2modN。R^2(modN),******************
% R2modN = BN_Rapidmod( n , 2 , BN_multiply(256,2,RR,RR) , N);
% R2modN =R2modN(1:249) ;%R^2(modN)
% save R2modN R2modN
load R2modN

%%**********求G_inverse。G*G_inverse=1mod N,**************
% N_2 = BN_sub( n , 2 , N, [0 1] );
% G_inverse = MontgomeryExpMod( n , 2, N_inverse , G , N_2 , N, R2modN);
% G_inverse = G_inverse(1:252);
% save G_inverse G_inverse
load G_inverse

%%**********验证G_inverse**************
% tmp = BN_multiply(n,2,G,G_inverse);
% result = BN_Rapidmod( n , 2 , tmp , N);

n0 = 1024;
n0_bin = zeros(1,log2(n0)+1);
n0_bin(end) = 1;
N_2 = BN_sub( 253 , 2 , N, [0 1] );
nR_inverse = MontgomeryExpMod( 256 , 2, N_inverse , n0_bin , N_2 , N, R2modN);

x=cell(n0,1);%
for i=1:n0
    x{i,1} = inputdata(i+5,:);
end

%%串行变换
if parallelFlag ==0
    s = BN_NTT( log2(n0),R,x,G,G_inverse,N,N_inverse,R2modN,nR_inverse,1);
    s2 = BN_NTT( log2(n0),R,s,G,G_inverse,N,N_inverse,R2modN,nR_inverse,-1);
else
%%并行行变换
    row = 32;
    col = 32;
    n1 = row;
    n2 = col;
    n1_bin = zeros(1,log2(row)+1);
    n1_bin(end) = 1;
    n2_bin = zeros(1,log2(col)+1);
    n2_bin(end) = 1;
    nR_inverse1 = MontgomeryExpMod( 256 , 2, N_inverse , n1_bin , N_2 , N, R2modN);
    nR_inverse2 = MontgomeryExpMod( 256 , 2, N_inverse , n2_bin , N_2 , N, R2modN);
    s = BN_parallelNTT( log2(n1),log2(n2),R,x,row,col,G,G_inverse,N,N_inverse,R2modN,nR_inverse1,nR_inverse2,1);
    %反变换
    s2 = BN_parallelNTT( log2(n1),log2(n2),R,s,row,col,G,G_inverse,N,N_inverse,R2modN,nR_inverse1,nR_inverse2,-1);
end

s_mat = zeros(n0,256);
for i = 1:n0
    s_mat(i,1:length(s{i,1})) = s{i,1};
end
s2_mat = zeros(n0,256);
for i = 1:n0
    s2_mat(i,1:length(s2{i,1})) = s2{i,1};
end

inputdata_mat = inputdata(6:end,:);%用于对比
load ('outputdata.mat');%前32770有数，NTT有效数有32768个。

% row = 2^7;
% col = 2^8;
% nR_inverse1 = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1];%2^n1的逆元=49153
% nR_inverse2 = nR_inverse1;
% s3 = BN_parallelNTT( n1,n2,R,x,row,col,G,G_inverse,N,N_inverse,R2modN,nR_inverse1,nR_inverse2,1);
% %反变换
% s4 = BN_parallelNTT( n1,n2,R,s3,row,col,G,G_inverse,N,N_inverse,R2modN,nR_inverse1,nR_inverse2,-1);







