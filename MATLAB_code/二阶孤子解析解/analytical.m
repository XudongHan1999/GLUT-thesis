clear all; close all; clc

%% 参数设置
T_max = 10; N_t = 256; 
t = 2*T_max/N_t*[-N_t/2:N_t/2-1];
Z_max = 4; h = 0.2;
z = 0:h:Z_max;

%% 解析值计算
for m = 1:length(t)
    for n = 1:length(z)
        U(n,m)=1/7.9*abs(4*(cosh(3*t(m))+3*exp(4*1i*z(n))*cosh(t(m)))/(cosh(4*t(m))+4*cosh(2*t(m))+3*cos(4*z(n))))^2;
    end
end

%% 可视化
figure
waterfall(t, z, U)
view(-45, 45)
xlabel('时间 T/T_0'), ylabel('传输距离 z/L_D'), zlabel('强度')
axis([-10 10 0 4 0 inf]),
colormap([0 0 0]); 