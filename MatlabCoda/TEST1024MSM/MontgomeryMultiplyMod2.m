function [ MonVar ] = MontgomeryMultiplyMod2( n , R, N_inverse , A , B , N )
% 蒙哥马利作模乘运算
%   此处显示详细说明
k = log2(R);
R_num = ceil(n/k);
[S] = BN_multiply(n,R,A,B);             % S = A*B, BN_multiply采用数据分组累加寄存器值的方式实现
q1 = S(1:R_num);                        % q1 = mod(S,R), 模R相当于移位
[tmp1] = BN_multiply(n,R,q1,N_inverse);
q = tmp1(1:R_num);                       % q = mod(q1*N_inv,R); 精度修正系数的获得
[tmp2] = BN_multiply(n,R,q,N);
[tmp3] = BN_add(2*n,R,tmp2,S);
MonVar = tmp3(R_num+1:2*R_num+1);          % Mon = (AB + q*N)/R, Montgomery模乘约减表达式
flag = 0;
if (MonVar(end)==1)
    flag = 1;
end
for i = length(MonVar)-1 : -1 : 1
    if (MonVar(i)<N(i))
        break;
    end
    if (MonVar(i)>N(i))
        flag = 1;
        break;
    end
end
if (flag==1)
    [MonVar] = BN_minus(n+k,R,MonVar,[N 0]);  % if Mon>=N,then Mon=Mon-N
end
MonVar = MonVar(1:R_num);
end

