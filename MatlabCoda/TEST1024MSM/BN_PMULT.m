function [x y] = BN_PMULT( n,R,x1,y1,k,N,a,b,N_inverse,R2modN)
%%
%  ====================================================
% Function：椭圆曲线y^2=x^3+ax+b上标量积;
% Input Para：n-x1，y1的最大位数（暂时不用，预留）；R-进制（预留）；
%EC点P (x1,y1)-二进制，低位在前；
% N-大素数，二进制，低位在前，N（0）；
% k-标量乘法因子，低位在前，k（0）；
% a,b-椭圆曲线参数
% N_inverse-素数N的逆元，二进制，低位在前y（0）
% R2modN-R2modN=R^2(modN)，需要预先计算的数
% Output：kP，低位在前。
% Author by Wang Pengfei
% data：2022.3.15
% Revised by：
% ====================================================
%确保k高位为1
for i=length(k):-1:1
    if k(i)==1
        break;
    end
end
k_tmp = k(1:i);
x = [0];
y = [0];
x_tmp = x1;
y_tmp = y1;
for i = 1:length(k_tmp)
    if k_tmp(i)==1
        [x,y] = BN_PADD( n,R,x,y,x_tmp,y_tmp,N,a,b,N_inverse,R2modN);
    end
    [x_tmp,y_tmp] = BN_PADD( n,R,x_tmp,y_tmp,x_tmp,y_tmp,N,a,b,N_inverse,R2modN);
end
end



