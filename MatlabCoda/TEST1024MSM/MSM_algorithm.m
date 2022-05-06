%MSM algorithm
%  ====================================================
% Author by Wang Pengfei
% data：2022.3.20
% Revised by：
% ====================================================
clear all;close all;clc;
%由片外存储器读入片上缓冲区的数据
nDataNum = 1024;
Lambda = cell(nDataNum,1);%1024个标量，每个256位；（可输入任意位数）
Point = cell(nDataNum,2);%1024个椭圆曲线上的点，每个点有 768位（可输入任意位数）

nReadNum = 2;%每次读两个标量和两个点
nBitP = 768;%素数P的位数  （可输入任意p的位数）
nBitLambda = 256;%标量的位数  （可输入任意标量的位数）
R = 2;%采用二进制计算。
nWinS = 4;%Pippenger算法的窗口大小，二进制的位数
p = [];%大素数，二进制，低位在前，N（0）；
a = [];%椭圆曲线参数a
b = [];%椭圆曲线参数b
p_inverse = [];%素数p的逆元,p_inverse*（-p）=1(mod 2^nBitP),其中:-p=2^nBitP-p(mod 2^nBitP)
R2modp = [];%R^2(mod p),即2^((nBitP)*2) (mod p)
%初始化
tmpx =0;
tmpy = 0;
ResultX = 0;
ResultY = 0;
x_pro = zeros(nReadNum,nBitP);
y_pro = zeros(nReadNum,nBitP);
lambda_pro = zeros(nReadNum,nBitLambda);
for i = 1:nDataNum/nReadNum% 可并行处理
    x_pro(1,:) = Point{(i-1)*nReadNum+1,1};%读入片上缓冲取数据
    x_pro(2,:) = Point{(i-1)*nReadNum+2,1};%读入片上缓冲取数据
    y_pro(1,:) = Point{(i-1)*nReadNum+1,2};%读入片上缓冲取数据
    y_pro(2,:) = Point{(i-1)*nReadNum+2,2};%读入片上缓冲取数据
    lambda_pro(1,:) = Lambda{(i-1)*nReadNum+1,1};%读入片上缓冲取数据
    lambda_pro(2,:) = Lambda{(i-1)*nReadNum+2,1};%读入片上缓冲取数据    
    
    [tmpx tmpy] = BN_Pippenger( nBitP,R,nWinS,x_pro,y_pro,lambda_pro,p,a,b,p_inverse,R2modp);%Pippenger每次计算两个点
    [ResultX ResultY] = BN_PADD( nBitP,R,ResultX,ResultY,tmpx,tmpy,p,a,b,p_inverse,R2modp);%累加计算结果，共nDataNum/nReadNum次
end

