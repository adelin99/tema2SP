%Numar de ordine: 12
P = 40; %Perioada semnalului
t=-P:1:P; %vector pentru axa timpului
D=12;   %pulsul semnalului
duty = D/P;      %factorul de umplere
N = 50;       %numarul de coeficienti
w0 = 2*pi/P;  %pulsatie
x_tr= sawtooth(w0*t,duty);   %semnalul triunghiular
f=@(t)sawtooth(w0*t,duty);   % @ l-am folosit pentru a calcula integrala
CC=1/P*integral(f,0,P);      
Ck=zeros(1,N);
Ak=zeros(1,N);
x_modificat=0;
for k=1:1:N
   f=@(t)sawtooth(w0*t,duty).*exp(-w0*t*1i*(k-25));
   Ck(k)=1/P*integral(f,0,P);             %coeficientii SFC
   Ak(k+1)=2*abs(Ck(k));
   x_modificat=x_modificat+Ck(k)*exp(w0*t*1i*(k-25)); %reconstructia semnalului initial
end
figure(1);
plot(t,x_modificat,t,x_tr);
title('x(t) si reconstructia folosind N coeficienti');
ylabel('Amplitudinea[V]');
xlabel('Timp[s]');
grid;
figure(2)
Ak(51)=abs(CC);
Ak(1)=Ak(51);                %Amplitudinea Ak
stem([0:N],Ak);              %se afiseaza spectrul de valori
hold on;
plot([0:N],Ak,"-o");
title('Spectrul de amplitudini');
grid;
end