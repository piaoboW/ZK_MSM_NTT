function [s] = BN_Rapidmod( n , R , x , p)
%%
%  ====================================================
% Function：取模运算s=mod(x,p)
% Input Para：n-p的最大位数（暂时不用，预留）；R-进制（预留）；
%x-EC点P (x,y)-二进制，低位在前，；p-大素数，二进制，低位在前p（0）
% Output：s=mod(x,p)，低位在前。
% Author by Wang Pengfei
% data：2022.3.11
% Revised by：
% ====================================================
%快速取模，x<2p
% p的最高位不能为0
for n = length(p):-1:1
    if p(n) == 1
        break;
    end
end
p = p(1:n);

for m = length(x):-1:1
    if x(m) == 1
        break;
    end
end
x = x(1:m);

if BN_compare( p, x )
    s = x;
    return;
end
xl = length(x);
pl = length(p);
dl = xl - pl;

if dl ==0
    s = BN_sub( n , R , x,  p );
    return;
end
for i = dl:-1:0
    x1 = x(i+1:end);%左移i位
    if BN_compare( p, x1 )
        continue;
    end
    x2 = zeros();
    x2(i+1:length(x1)+i) = x1;%x1右移 补零
    b1 = BN_sub( n , R , x,  x2 );%低位取或
    x1 = BN_sub( n , R , x1,  p );
    x3 = zeros();
    x3(i+1:length(x1)+i) = x1;
    x = BN_add(n , R , x3,  b1);
end
s = x;
if BN_compare( s, p )
    s = BN_sub( n , 2 , s, p )
end
s = s(1:n+1);%取有效位数
end

