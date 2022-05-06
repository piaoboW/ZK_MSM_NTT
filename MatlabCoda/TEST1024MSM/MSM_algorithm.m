%MSM algorithm
%  ====================================================
% Author by Wang Pengfei
% data��2022.3.20
% Revised by��
% ====================================================
clear all;close all;clc;
%��Ƭ��洢������Ƭ�ϻ�����������
nDataNum = 1024;
Lambda = cell(nDataNum,1);%1024��������ÿ��256λ��������������λ����
Point = cell(nDataNum,2);%1024����Բ�����ϵĵ㣬ÿ������ 768λ������������λ����

nReadNum = 2;%ÿ�ζ�����������������
nBitP = 768;%����P��λ��  ������������p��λ����
nBitLambda = 256;%������λ��  �����������������λ����
R = 2;%���ö����Ƽ��㡣
nWinS = 4;%Pippenger�㷨�Ĵ��ڴ�С�������Ƶ�λ��
p = [];%�������������ƣ���λ��ǰ��N��0����
a = [];%��Բ���߲���a
b = [];%��Բ���߲���b
p_inverse = [];%����p����Ԫ,p_inverse*��-p��=1(mod 2^nBitP),����:-p=2^nBitP-p(mod 2^nBitP)
R2modp = [];%R^2(mod p),��2^((nBitP)*2) (mod p)
%��ʼ��
tmpx =0;
tmpy = 0;
ResultX = 0;
ResultY = 0;
x_pro = zeros(nReadNum,nBitP);
y_pro = zeros(nReadNum,nBitP);
lambda_pro = zeros(nReadNum,nBitLambda);
for i = 1:nDataNum/nReadNum% �ɲ��д���
    x_pro(1,:) = Point{(i-1)*nReadNum+1,1};%����Ƭ�ϻ���ȡ����
    x_pro(2,:) = Point{(i-1)*nReadNum+2,1};%����Ƭ�ϻ���ȡ����
    y_pro(1,:) = Point{(i-1)*nReadNum+1,2};%����Ƭ�ϻ���ȡ����
    y_pro(2,:) = Point{(i-1)*nReadNum+2,2};%����Ƭ�ϻ���ȡ����
    lambda_pro(1,:) = Lambda{(i-1)*nReadNum+1,1};%����Ƭ�ϻ���ȡ����
    lambda_pro(2,:) = Lambda{(i-1)*nReadNum+2,1};%����Ƭ�ϻ���ȡ����    
    
    [tmpx tmpy] = BN_Pippenger( nBitP,R,nWinS,x_pro,y_pro,lambda_pro,p,a,b,p_inverse,R2modp);%Pippengerÿ�μ���������
    [ResultX ResultY] = BN_PADD( nBitP,R,ResultX,ResultY,tmpx,tmpy,p,a,b,p_inverse,R2modp);%�ۼӼ���������nDataNum/nReadNum��
end

