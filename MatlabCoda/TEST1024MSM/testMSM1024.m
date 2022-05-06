%% test-测试m文件，测试每个函数的正确性
% ====================================================
close all; clear all;clc;

%test 
% test BN_multiply
% n=384;%位数
% R=2;%进制
% x = randi([0 1],[1 n]);
% % x=[1 2 3 4 5];
% % y =randi([0 1],[1 n]);
% y= [0];
% [s1] = BN_multiply(n,R,x,y);
% [s2] = BN_multiply2(n,R,x,y);

nDataNum = 16;%1024;%输入点数
N_bit = 384;
k_bit = 256;

%% 读实际的数据  bls12_377
%读取椭圆曲线上的点
fileID = fopen('input_16','r','l');
number1 = fread(fileID,inf,'ubit1');%'ubit1'\f
fclose(fileID);
inputdata = reshape(number1,N_bit,nDataNum*2)';

% 读取k
fileID = fopen('k_16','r','l');
number2 = fread(fileID,inf,'ubit1');%'ubit1'
fclose(fileID);
input_k = reshape(number2,k_bit,nDataNum)';
% 保存
% save inputdata inputdata

fileID = fopen('output_16','r','l');
number3 = fread(fileID,inf,'ubit1');%'ubit1'\f
fclose(fileID);
outputdata = reshape(number3,N_bit,nDataNum*2+2)';

fileID = fopen('params','r','l');
number4 = fread(fileID,inf,'ubit1');%'ubit1'\f
fclose(fileID);
% N = number4';

%系数k组成元胞数据
Lambda = cell(nDataNum,1);%1024个标量k，每个256位；（可输入任意位数）
for i=1:nDataNum
    Lambda{i,1} = input_k(i,:);
end
%椭圆曲线点组成元胞数据
Point = cell(nDataNum,2);%1024个椭圆曲线上的点，每个点有 384位（可输入任意位数）
for i=1:nDataNum
    Point{i,1} = inputdata((i-1)*2+1,:);
    Point{i,2} = inputdata((i-1)*2+2,:);
end

nReadNum = 1;%每次读两个标量和两个点
N = number4';%大素数，二进制，低位在前；
nBitN = 384;%素数P的位数  （可输入任意p的位数）
nBitLambda = 256;%标量k的位数  （可输入任意标量的位数）
R = 2;%采用二进制计算。
RR = zeros(1,nBitN+1);%R=2^384
RR(end) = 1;%相当于真正的R
RR_sub2 = BN_sub( nBitN+1 , 2 , RR, [0 1]);%相当于N-2
N_negative = BN_sub( nBitN+1 , 2 , RR, N );%-N
nWinS = 4;%Pippenger算法的窗口大小，二进制的位数

a = [0];%椭圆曲线参数a
b = [1];%椭圆曲线参数b
% N_inverse = [];%素数N的逆元,N_inverse*（-N）=1(mod 2^nBitN),其中:-N=2^nBitN-N(mod 2^nBitN)
%%**********求N_inverse。N_inverse*（-N）=1mod R,**************
% Ntmp = '0101111111010010100100000010111111110111011001000001011100011110100100010111110000000000101000001100000000110101000111100111011000101101100100100010110111000011011001100111011010111101000010011001101011110110100010011010001111001011100001101111010111111111111010001111010010100010101110111101000000000000000000000000000001000010100001000101111111111111111111111111111111111111111111111';
% for n = length(Ntmp):-1:1
%      N_inverse(1,length(Ntmp)-n+1) = str2num(Ntmp(n));
% end
%  N_inverse = N_inverse(1:nBitN);
% save N_inverse N_inverse
load N_inverse

%%**********验证N_inverse**************
tmp = BN_multiply(nBitN+1,2,N_inverse,N_negative);
result = BN_Rapidmod( nBitN+1 , 2 , tmp , RR);

%%****************R2modN。R^2(modN),******************
% R2modN = BN_Rapidmod( nBitN , 2 , BN_multiply(nBitN+1,2,RR,RR) , N);
% R2modN =R2modN(1:375) ;%R^2(modN)
% save R2modN R2modN
load R2modN

%初始化
MidResult = cell(nDataNum,2);
tmpx =0;
tmpy = 0;
ResultX = 0;
ResultY = 0;
x_pro = zeros(nReadNum,nBitN);
y_pro = zeros(nReadNum,nBitN);
lambda_pro = zeros(nReadNum,nBitLambda);
%PMULT计算MSM

for i = 1:nDataNum% 可并行处理
    x_pro = Point{i,1};%读入片上缓冲取数据
    y_pro= Point{i,2};%读入片上缓冲取数据
    lambda_pro = Lambda{i,1};%读入片上缓冲取数
    [tmpx tmpy] = BN_Pippenger( nBitN,R,nWinS,x_pro,y_pro,lambda_pro,N,a,b,N_inverse,R2modN);%Pippenger每次计算1个点
%     [tmpx tmpy] = BN_PMULT( nBitN,R,x_pro,y_pro,lambda_pro,N,a,b,N_inverse,R2modN);
    MidResult{i,1} = tmpx;
    MidResult{i,2} = tmpy;
end
save MidResult1 MidResult


%PIPPENGER计算MSM
for i = 1:nDataNum/nReadNum% 可并行处理
    for j = 1:nReadNum
        x_pro(j,:) = Point{(i-1)*nReadNum+j,1};%读入片上缓冲取数据
        y_pro(j,:) = Point{(i-1)*nReadNum+j,2};%读入片上缓冲取数据
        lambda_pro(j,:) = Lambda{(i-1)*nReadNum+j,1};%读入片上缓冲取数据
    end
    
%     x_pro(1,:) = Point{(i-1)*nReadNum+1,1};%读入片上缓冲取数据
%     x_pro(2,:) = Point{(i-1)*nReadNum+2,1};%读入片上缓冲取数据
%     y_pro(1,:) = Point{(i-1)*nReadNum+1,2};%读入片上缓冲取数据
%     y_pro(2,:) = Point{(i-1)*nReadNum+2,2};%读入片上缓冲取数据
%     lambda_pro(1,:) = Lambda{(i-1)*nReadNum+1,1};%读入片上缓冲取数据
%     lambda_pro(2,:) = Lambda{(i-1)*nReadNum+2,1};%读入片上缓冲取数据    
    
    [tmpx tmpy] = BN_Pippenger( nBitN,R,nWinS,x_pro,y_pro,lambda_pro,N,a,b,N_inverse,R2modN);%Pippenger每次计算两个点
    MidResult{i,1} = tmpx; 
    MidResult{i,2} = tmpy;
    [ResultX ResultY] = BN_PADD( nBitN,R,ResultX,ResultY,tmpx,tmpy,N,a,b,N_inverse,R2modN);%累加计算结果，共nDataNum/nReadNum次
end
save MidResult MidResult

MidResult_mat = zeros(32,384);
for i=1:16
    MidResult_mat((i-1)*2+1,1:length(MidResult{i,1})) = MidResult{i,1} ;
    MidResult_mat((i-1)*2+2,1:length(MidResult{i,2})) = MidResult{i,2} ;
end


%% test BN_Pippenger  
%结果参考：[6]零知识证明 - 椭圆曲线基础
% n=7;%N的位数
% R=2;%进制R=2^7=128
% N=[1 0 0 0 0 1 1];%97
% N_inverse = [1 1 1 1 1 0 1];%%N_inverse*（-N）=1mod 2^7,N_inverse= 95,   其中-N=31
% R_inverse = [0 0 0 1 0 0 1];%R_inverse = inverse(2^7) = 72
% R2modN =[0 0 0 1 1 0 1] ;%R^2(modN) =88
% a=[0 1];
% b =[1 1];
% s = 4;
% % x_p=[1 1 0 0 0 0 0;0 0 0 0 1 0 1];%3,80
% % y_p = [0 1 1 0 0 0 0;0 1 0 1 0 0 0];%6,10
% % k=[0 1 0 0 1 0 0 1 0 1 0 1;1 1 0 0 1 0 0 1 0 0 0 1];%
% x_p=[1 1 0 0 0 0 0;1 1 0 0 0 0 0];%3
% y_p = [0 1 1 0 0 0 0;0 1 1 0 0 0 0];%6
% k=[1 0 0 1 1 0 0 1 0 1 0 1;0 1 0 0 1 0 0 1 0 1 0 1];%
% [x y] = BN_Pippenger( n,R,s,x_p,y_p,k,N,a,b,N_inverse,R2modN);


