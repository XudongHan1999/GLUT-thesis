clear all; close all; clc

%% 参数设置
N = 1;
sgn = -1;
T_max = 10; N_t = 512; 
t = 2*T_max/N_t*[-N_t/2:N_t/2-1];
omega = (pi/T_max)*[0:N_t/2-1 -N_t/2:-1].';
Z = 4; h = 0.25;
z = 0:h:Z;
[T, Z] = meshgrid(t, z);


%% 初始条件
u = 4*sech(t); ut = fft(u);

%% ODE求解
[z, UT] = ode45('NLSE', z, ut, [], sgn, omega, N);
U = ifft(UT, [], 2);

%% 可视化
figure
waterfall(t, z, abs(U))
view(-45,45)
xlabel('时间 T/T_0'), ylabel('传输距离 z/L_D'), zlabel('强度')
axis([-10 10 0 inf 0 inf]),
colormap([0 0 0]); 

figure
waterfall(fftshift(omega)./(2.*pi), z, abs(fftshift(UT, 2)))
view(-45,45)
xlabel('频率 (\nu-\nu_0)T_0'), ylabel('传输距离 z/L_D'), zlabel('频谱强度')
axis([-inf inf 0 inf 0 inf]),
colormap([0 0 0]); 

figure
surf(T, Z, abs(U))
xlabel('时间 T/T_0'), ylabel('传输距离 z/L_D'), zlabel('强度')
view(-20,70)
axis([-10 10 0 inf 0 inf]),
shading interp
colormap(gca, 'jet');

figure
surf(T, Z, abs(U))
xlabel('时间 T/T_0'), ylabel('传输距离 z/L_D'), zlabel('强度')
view(0,90)
axis([-10 10 0 inf 0 inf]),
shading interp
colormap(gca, 'jet');