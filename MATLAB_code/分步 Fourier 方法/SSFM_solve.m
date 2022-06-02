close all; clear all; clc


%% 参数设置
beta_2 = -1; N = 1;
T_max = 10; N_t = 1024;
Z = 4; h = 0.001;
t = 2*T_max/N_t*[-N_t/2:N_t/2-1];
omega = (pi/T_max).*[0:N_t/2-1 -N_t/2:-1];
z = 0:h:Z;
[T, Z] = meshgrid(t, z);

%% 色散项和非线性项
D = exp(1i/2*beta_2*omega.^2*h);
NL = 1i*N^2*h;

%% 初始条件
tic;
u = 3*sech(t);
U = []; UT = [];
U(1,:) = abs(u); UT(1,:) = abs(fftshift(fft(u)));

%% 分步 Fourier 求解 1/2N->D->1/2N
u = u.*exp(abs(u).^2.*NL/2);
for n = 2:length(z)
    ut = fft(u).*D;
    u = ifft(ut);
    u = u.*exp(abs(u).^2.*NL);
    u_r = u.*exp(-abs(u).^2.*NL/2);
    U(n,:) = u_r;
    UT(n,:) = fftshift(fft((u_r)));
end

%% 可视化
figure
waterfall(t, z, U)
view(-45,50)
xlabel('时间 T/T_0'), ylabel('传输距离 z/L_D'), zlabel('强度')
axis([-10 10 0 inf 0 inf]), 
colormap([0 0 0]); 

figure
waterfall(fftshift(omega)./(2.*pi), z, UT)
view(-45,45)
xlabel('频率 (\nu-\nu_0)T_0'), ylabel('传输距离 z/L_D'), zlabel('频谱强度')
axis([-inf inf 0 inf 0 inf]),
colormap([0 0 0]); 

figure
surf(T, Z, abs(U))
xlabel('时间 T/T_0'), ylabel('传输距离 z/L_D'), zlabel('强度')
view(-20,70)
axis([-inf inf 0 4 0 inf]),
shading interp
colormap(gca, 'jet');

figure
surf(T, Z, abs(U))
xlabel('时间 T/T_0'), ylabel('传输距离 z/L_D'), zlabel('强度')
view(0,90)
axis([-inf inf 0 4 0 inf]),
shading interp
colormap(gca, 'jet');

