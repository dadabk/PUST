%PUST projekt 1
clear all;
close all;

% 1. Sprawdzenie Upp i Ypp 

save=0; % 1 - zapis wykres�w

Upp=0.8;
Ypp=2;
simTime=100;
Y=symulacja_obiektu_UppYpp(0.8,2,simTime);
Y1=symulacja_obiektu_UppYpp(0.7,2,simTime);
Y2=symulacja_obiektu_UppYpp(0.9,2,simTime);
Y3=symulacja_obiektu_UppYpp(0.8,1.9,simTime);
Y4=symulacja_obiektu_UppYpp(0.8,2.1,simTime);

figure(1);
plot(Y,'r');
hold on;
plot(Y1,'b--');
plot(Y2,'g--');
plot(Y3,'m--');
plot(Y4,'k--');
legend('Upp=0.8, Ypp=2.0','Upp=0.7, Ypp=2.0','Upp=0.9, Ypp=2.0','Upp=0.8, Ypp=1.9', 'Upp=0.8, Ypp=2.1');
title('R�ne warto�ci Upp, Ypp');
xlabel('k');
ylabel('Y(k)');
grid on;

if save==1
    print('PLOTS/UppYpp', '-dpng', '-r500')
end

clear Y Y1 Y2 Y3 Y4 simTime

% 2. Odpowiedzi skokowe dla Upp=0.8
simTime=151;

Y1=stepResponse(0.2,simTime);
Y2=stepResponse(0.4,simTime);
Y3=stepResponse(0.6,simTime);
Y4=stepResponse(1.0,simTime);
Y5=stepResponse(1.2,simTime);
Y6=stepResponse(1.4,simTime);

xVal=[0:simTime-1];
figure(2);
plot(xVal,Y1,'r');
hold on;
plot(xVal,Y2,'b');
plot(xVal,Y3,'g');
plot(xVal,Y4,'m');
plot(xVal,Y5,'k');
plot(xVal,Y6,'c');
grid on;
xlabel('k');
ylabel('Y(k)');
legend('U=0.2','U=0.4','U=0.6','U=1.0','U=1.2','U=1.4');
title('Odpowiedzi skokowe dla Upp=0.8');

if save==1
    print('PLOTS/step_response_Upp_0_8', '-dpng', '-r500')
end

Y=[Y1(simTime);Y2(simTime);Y3(simTime);2.0;Y4(simTime);Y5(simTime);Y6(simTime)];
U=[0.2;0.4;0.6;0.8;1.0;1.2;1.4];
U2=[U ones(7,1)];

A=U2\Y;
xVal=[0:0.1:1.6];

Y0=A(2); % warto�� sygna�u dla U=0

figure(3);
plot(xVal,polyval(A,xVal),'r');
hold on;
plot(U,Y,'bo');
grid on;
xlabel('U');
ylabel('Y');
title('Charackterystyka statyczna');
legend('prosta najlepszego dopasowania','dane z modelu');

if save==1
    print('PLOTS/static_characteristics', '-dpng', '-r500')
end

clear Y1 Y2 Y3 Y5 Y6 xVal Y U U2

% 3. Odpowied� skokowa dla DMC
val=Y4(1);
DMCstep=(Y4-val)*5.0;
DMCstep=DMCstep+Y0;

xVal=[0:simTime-1];
figure(4);
plot(xVal,DMCstep,'r');
grid on;
xlabel('k');
ylabel('Y(k)');
title('Odpowied� skokowa dla DMC');

if save==1
    print('PLOTS/DMC_step_response', '-dpng', '-r500')
end

clear Y4 Y0 val xVal simTime 


