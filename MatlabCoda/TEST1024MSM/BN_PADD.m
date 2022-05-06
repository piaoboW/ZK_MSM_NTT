function [ x3 y3 ] = BN_PADD( n,R,x1,y1,x2,y2,N,a,b,N_inverse,R2modN)
%%
%  ====================================================
% Function����Բ����y^2=x^3+ax+b�ϵ�� ;
% Input Para��n-x1��y1��x2,y2�����λ������ʱ���ã�Ԥ������R-���ƣ�Ԥ������
%EC��P (x1,y1)-�����ƣ���λ��ǰ������EC��Q��x2��y2��-�����ƣ���λ��ǰy��0��
% N-�������������ƣ���λ��ǰ��N��0����
% a,b-��Բ���߲���
% N_inverse-����N����Ԫ�������ƣ���λ��ǰy��0��
% R2modN-R2modN=R^2(modN)����ҪԤ�ȼ������
% Output��EC��R��x3��y3��=P+Q����λ��ǰ��
% Author by Wang Pengfei
% data��2022.3.13
% Revised by��
% ====================================================
for i=length(x1):-1:1
    if x1(i)==1
        break;
    end
end
x1 = x1(1:i);

for i=length(x2):-1:1
    if x2(i)==1
        break;
    end
end
x2 = x2(1:i);

for i=length(y1):-1:1
    if y1(i)==1
        break;
    end
end
y1 = y1(1:i);

for i=length(y2):-1:1
    if y2(i)==1
        break;
    end
end
y2 = y2(1:i);

if length(x1)==1&&length(y1)==1&&x1(1)==0&&y1(1)==0
    x3 = x2;
    y3 = y2;
    return;
end
if length(x2)==1&&length(y2)==1&&x2(1)==0&&y2(1)==0
    x3 = x1;
    y3 = y1;
    return;
end

if BN_Equal(x1,x2)&&(BN_Equal(y1,y2)==0)
    x3 = [0];
    y3 = [0];
    return;
end

if BN_Equal(x1,x2)&&BN_Equal(y1,y2)%���ʱ��ò��ô˷���
    doubleY = zeros();
    doubleY(2:length(y1)+1)=y1;%��λ�൱�ڡ�2
    inverseDoubleY = FermatLittleTheoremInverseMod( n , R, N_inverse , doubleY ,  N, R2modN );
    n1 = BN_multiply(n,R,x1,x1);
    n2 = BN_multiply(n,R,n1,[1 1]);%��3
    n3 = BN_add(n,R,n2,a);
    %     m = MontgomeryMultiplyMod( n , R, N_inverse , n3 , inverseDoubleY, N,
    %     R2modN ) ;  ������n3���ܴ���N
    n4 = BN_multiply(n,R,n3,inverseDoubleY);
    m= BN_Rapidmod( n , R , n4, N);
else
    if BN_compare( y1, y2 )
        subY = BN_sub( n , R , y1, y2 );
    else
        subY = BN_sub( n , R , BN_add( n , R , y1, N ), y2 );
    end
    if BN_compare( x1, x2 )
        subX = BN_sub( n , R , x1, x2 );
    else
        subX = BN_sub( n , R , BN_add( n , R , x1, N ), x2 );
    end
    inverseSubX = FermatLittleTheoremInverseMod( n , R, N_inverse , subX ,  N, R2modN );
    m = MontgomeryMultiplyMod( n , R, N_inverse , subY , inverseSubX, N, R2modN );
end
m1 = BN_multiply(n,R,m,m);
if BN_compare( m1, x1 )
    m2 = BN_sub( n , R , m1, x1 );
else
    m2 = BN_sub( n , R , BN_add( n , R , m1, N ), x1 );
end
if BN_compare( m2, x2 )
    m3 = BN_sub( n , R , m2, x2 );
else
    m3 = BN_sub( n , R , BN_add( n , R , m2, N ), x2 );
end
x3 = BN_Rapidmod( n , R , m3 , N);
% if BN_compare( m3, N )
%     x3 = BN_sub( n , R , m3, N );
% else
%     x3 = m3;
% end

if BN_compare( x1, x3)
    m4 = BN_sub( n , R , x1, x3 );
else
    m4 = BN_sub( n , R , BN_add( n , R , x1, N ), x3 );
end
m5 = BN_multiply( n , R , m, m4 );
if BN_compare( m5, y1)
    m6 = BN_sub( n , R , m5, y1 );
else
    m6 = BN_sub( n , R , BN_add( n , R , m5, N ), y1 );
end
y3 = BN_Rapidmod( n , R , m6 , N);

end

