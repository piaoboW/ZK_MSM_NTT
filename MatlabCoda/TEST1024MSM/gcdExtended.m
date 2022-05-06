function [ x y gcd] = gcdExtended(a,b)
%   extended Euclidean Algorithm
if a==0
    x=0;
    y=1;
    gcd = b;
end
[x1 y1 gcd]=gcdExtended(mod(b,a),a);
 x = y1 - (b / a) * x1;
 y = x1;
end

