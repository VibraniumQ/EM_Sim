load ASMparameters_SI
as = Machines(15);
syms rs lls llr rr s lm rm u f p
x1=rs+1i*lls;
x2=rr/s+1i*llr;
I = u/(x1+x2);
P = I^2*(rr/s);
Tem = P/(2*pi*f/p)

Tem2 = 3*p/(2*pi*f)*(u^2*rr/s)/((rs+rr/s)^2+(lls+llr)^2);

rs = as.Rs;     subs(rs);
lls = as.Lls;   subs(lls);
llr = as.Llr;   subs(llr);
rr = as.Rr;     subs(rr);
lm = as.Lm;     subs(lm);
u = 300+400*1i;       subs(u);
f = as.f;       subs(f);
p = as.ppole;   subs(p);
s = 0.2;        subs(s);
x1=rs+1i*lls;
x2=rr/s+1i*llr;
I = u/(x1+x2);
P = I^2*(rr/s);
Tem = P/(2*pi*f/p)*3
Tem2 = 3*p/(2*pi*f)*(500^2*rr/s)/((rs+rr/s)^2+(lls+llr)^2)
abs(Tem)
abs(Tem)/Tem2
