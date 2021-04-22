clear all
close all
clc

mp = 68.5e-3; %kg
mw = 88e-3; %kg
lp = 43.2e-2; %m
dw = 5e-2; %m
ds = 2.5e-2; %m
g = 9.81; %m/s^2
lpcg = (lp-ds)/2; %m

tf = 3; %s
maxstep = 0.01;
tol = 1e-6;

theta0 = 0; %rad
omega0 = 0; %rad/s

lwcg = 4e-2; %m
J = ((mp*lp^2)/12)+mp*(lpcg^2)+(1/2)*mw*((dw/2)^2)+mw*(lwcg^2);
k = g*(mp*lpcg+mw*lwcg);
C = mp*lpcg+mw*lwcg;

sim('Schimmel_Evan_lab_4_model_single')
theta_deg=(180/pi)*(theta_rad);

figure
plot(t,theta_deg)
axis([0 3 -10 10]);
xlabel('Time (s)');
ylabel('Angular displacement (deg)');

i=0;
for offset=4:0.1:39 %cm
    lwcg=offset/100; %m
    J = ((mp*lp^2)/12)+mp*(lpcg^2)+(1/2)*mw*((dw/2)^2)+mw*(lwcg^2);
    k = g*(mp*lpcg+mw*lwcg);
    C = mp*lpcg+mw*lwcg;
    sim('Schimmel_Evan_lab_4_model_single')
    theta_deg=(180/pi)*(theta_rad);
    i=i+1;
    weightoffset(i)=offset;
    theta_max(i)=max(theta_rad(t > 1))*(180/pi);
end

figure
plot(weightoffset,theta_max)
axis([0 40 5 11]);
xlabel('Moveable weight offset (cm)');
ylabel('Residual swing amplitude (deg)');