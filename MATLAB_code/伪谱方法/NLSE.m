function dut=NLSE(z, ut, dummy, sgn, omega, N)
u = ifft(ut);
dut = sgn*(i/2)*(omega.^2).*ut+i*N^2*fft((abs(u).^2).*u);