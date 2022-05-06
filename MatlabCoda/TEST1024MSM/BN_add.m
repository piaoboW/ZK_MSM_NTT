function [s] = BN_add( n , R , x, y )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%  ====================================================
% Function��������ĺ�  
% Input Para��n-x��y�����λ������ʱ���ã�Ԥ������R-���ƣ�Ԥ������
% x-�����ƣ���λ��ǰ��x��0����y-�����ƣ���λ��ǰy��0��
% Output��s-x+y����λ��ǰ��
% Author by Wang Pengfei
% data��2022.2.25
% Revised by��
% ====================================================
% BN_add(2*n,R,tmp2,S)
%32λ�ӷ�:
% C=A+B����ȻC[i]�����ǵ���A[i]+B[i]����ΪA[i]+B[i]����>0xffffffff����C[i]����<=0xffffffff����ʱ����Ҫ��λ��
% ��Ȼ�ڼ���C[i-1]ʱҲ���ܲ����˽�λ�����Լ���C[i]ʱ��Ҫ�����ϴεĽ�λֵ��
% �����һ��64λ����result����¼�ͣ�64λ��Ϊ�˷�׼���ģ�ʵ�ʼӼ���ֻҪ33λ���ɣ�
% ��һ��32λ����carry����¼��λ(ΪʲôҪ32λ��Ϊ�˷�׼���ģ�ʵ�ʼӼ�����λֻ��1)�����У�
% carry=0;
% for(i=0;i<=p;i++) ��      //i��0��p ��ΪA>B
% ����result=A[i]+B[i]+carry;
% ����C[i]=result%0x100000000 ;   //�����￴resultӦ�ô���64λ������65λ
% ����carry=result/0x100000000;
% ��
% if(carry=0) n=p;
% else n=p+1;
%%
% R_num = ceil(n/log2(R));%R����λ��
% R_num = n;%R����λ��
R_num = max(length(x),length(y));
x_tmp = zeros(1,R_num);     % ����
x_tmp(1:length(x)) = x;
y_tmp = zeros(1,R_num);     % ����
y_tmp(1:length(y)) = y;
s = zeros(1,R_num+1);     % s=x+y
c = zeros(1,R_num+1);         % ��ͽ�λ
for i = 1:R_num
    result=x_tmp(i)+y_tmp(i)+c(i);
    s(i)=mod(result,R);
    c(i+1)=fix(result/R);
end
s(R_num+1) = c(R_num+1);
end

