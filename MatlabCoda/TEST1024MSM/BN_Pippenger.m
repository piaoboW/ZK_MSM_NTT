function [x y] = BN_Pippenger( n,R,s,x_p,y_p,k,N,a,b,N_inverse,R2modN)
%%
%  ====================================================
% Function����Բ����y^2=x^3+ax+b�ϱ�����;
% Input Para��n-N��λ����
%R-������R=2;
%s-ѡ���Ĵ��ڴ�С,int���ͣ�������λ����ӦΪ��ֵ ������ȡ4
%EC��P (x_p,y_p)-�����ƣ���λ��ǰ,x_p��y_p�Ǿ���ÿһ��Ϊһ�����꣬���еĵ�Ϊ
% ��x_p(1,:)��x_p(1,:)������x_p(2,:)��y_p(2,:)��......����x_p(m,:)��y_p(m,:)����m=size(x_p,1)��������mȡ2;
% N-�������������ƣ���λ��ǰ��N��0����
% k-�����˷����ӣ���λ��ǰ��k��0���������ƾ���������x_p��ͬ��k�ĳ���ӦΪs�ı�����
% a,b-��Բ���߲���
% N_inverse-����N����Ԫ�������ƣ���λ��ǰy��0��
% R2modN-R2modN=R^2(modN)����ҪԤ�ȼ������
% Output��kP����λ��ǰ��
% Author by Wang Pengfei
% data��2022.3.17
% Revised by��
% ====================================================
m1=size(x_p,1);%
m2 =size(y_p,1);
if m1~=m2
    disp('������Բ������������')
    return;%
end
if (mod(size(k,2),s)==0)
    k_tmp = k;
else
    k_tmp = zeros(size(k,1),size(k,2)+mod(size(k,2),s));%k��λ��s�ı���
    k_tmp(:,1:size(k,2)) = k;
end
iter=size(k_tmp,2)/s;%ӦΪ��ֵ
%Ԥ����
B1 = cell(m1,2);
B2 = cell(m1,2);
B3 = cell(m1,2);
B4 = cell(m1,2);
B5 = cell(m1,2);
B6 = cell(m1,2);
B7 = cell(m1,2);
B8 = cell(m1,2);
B9 = cell(m1,2);
B10 = cell(m1,2);
B11 = cell(m1,2);
B12 = cell(m1,2);
B13 = cell(m1,2);
B14 = cell(m1,2);
B15 = cell(m1,2);
for i = 1:1:m1
    [B1{i,1} B1{i,2}]= BN_PMULT( n,R,x_p(i,:),y_p(i,:),[1 0 0 0],N,a,b,N_inverse,R2modN);
    [B2{i,1} B2{i,2}] = BN_PMULT( n,R,x_p(i,:),y_p(i,:),[0 1 0 0],N,a,b,N_inverse,R2modN);
    [B3{i,1} B3{i,2}] = BN_PMULT( n,R,x_p(i,:),y_p(i,:),[1 1 0 0],N,a,b,N_inverse,R2modN);
    [B4{i,1} B4{i,2}] = BN_PMULT( n,R,x_p(i,:),y_p(i,:),[0 0 1 0],N,a,b,N_inverse,R2modN);
    [B5{i,1} B5{i,2}] = BN_PMULT( n,R,x_p(i,:),y_p(i,:),[1 0 1 0],N,a,b,N_inverse,R2modN);
    [B6{i,1} B6{i,2}]= BN_PMULT( n,R,x_p(i,:),y_p(i,:),[0 1 1 0],N,a,b,N_inverse,R2modN);
    [B7{i,1} B7{i,2}] = BN_PMULT( n,R,x_p(i,:),y_p(i,:),[1 1 1 0],N,a,b,N_inverse,R2modN);
    [B8{i,1} B8{i,2}] = BN_PMULT( n,R,x_p(i,:),y_p(i,:),[0 0 0 1],N,a,b,N_inverse,R2modN);
    [B9{i,1} B9{i,2}] = BN_PMULT( n,R,x_p(i,:),y_p(i,:),[1 0 0 1],N,a,b,N_inverse,R2modN);
    [B10{i,1} B10{i,2}] = BN_PMULT( n,R,x_p(i,:),y_p(i,:),[0 1 0 1],N,a,b,N_inverse,R2modN);
    [B11{i,1} B11{i,2}]= BN_PMULT( n,R,x_p(i,:),y_p(i,:),[1 1 0 1],N,a,b,N_inverse,R2modN);
    [B12{i,1} B12{i,2}] = BN_PMULT( n,R,x_p(i,:),y_p(i,:),[0 0 1 1],N,a,b,N_inverse,R2modN);
    [B13{i,1} B13{i,2}] = BN_PMULT( n,R,x_p(i,:),y_p(i,:),[1 0 1 1],N,a,b,N_inverse,R2modN);
    [B14{i,1} B14{i,2}] = BN_PMULT( n,R,x_p(i,:),y_p(i,:),[0 1 1 1],N,a,b,N_inverse,R2modN);
    [B15{i,1} B15{i,2}] = BN_PMULT( n,R,x_p(i,:),y_p(i,:),[1 1 1 1],N,a,b,N_inverse,R2modN);
end

x = 0 ;
y = 0;

G_x = 0;
G_y = 0;
for i = 1:1:iter
    for j = 1:m1
        switch num2str(k(j,(i-1)*s+1:i*s))
            case '1  0  0  0'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B1{j,1},B1{j,2},N,a,b,N_inverse,R2modN);break;
             case '0  1  0  0'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B2{j,1},B2{j,2},N,a,b,N_inverse,R2modN);break;
             case '1  1  0  0'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B3{j,1},B3{j,2},N,a,b,N_inverse,R2modN);break;
             case '0  0  1  0'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B4{j,1},B4{j,2},N,a,b,N_inverse,R2modN);break;
              case '1  0  1  0'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B5{j,1},B5{j,2},N,a,b,N_inverse,R2modN);break;
             case '0  1  1  0'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B6{j,1},B6{j,2},N,a,b,N_inverse,R2modN);break;
             case '1  1  1  0'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B7{j,1},B7{j,2},N,a,b,N_inverse,R2modN);break;
             case '0  0  0  1'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B8{j,1},B8{j,2},N,a,b,N_inverse,R2modN);break;
             case '1  0  0  1'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B9{j,1},B9{j,2},N,a,b,N_inverse,R2modN);break;
             case '0  1  0  1'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B10{j,1},B10{j,2},N,a,b,N_inverse,R2modN);break;
             case '1  1  0  1'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B11{j,1},B11{j,2},N,a,b,N_inverse,R2modN);break;
             case '0  0  1  1'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B12{j,1},B12{j,2},N,a,b,N_inverse,R2modN);break;
             case '1  0  1  1'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B13{j,1},B13{j,2},N,a,b,N_inverse,R2modN);break;
             case '0  1  1  1'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B14{j,1},B14{j,2},N,a,b,N_inverse,R2modN);break;
             case '1  1  1  1'
             [G_x G_y] = BN_PADD( n,R,G_x,G_y,B15{j,1},B15{j,2},N,a,b,N_inverse,R2modN);break;    
            otherwise
                 break;
        end
    end
    exPara = zeros(1,(i-1)*s+1);
    exPara(end) = 1;
    [G_x G_y] = BN_PMULT( n,R,G_x,G_y,exPara,N,a,b,N_inverse,R2modN);
    [x y] = BN_PADD( n,R,x,y,G_x,G_y,N,a,b,N_inverse,R2modN);
    G_x = 0;
    G_y = 0;
end


end



