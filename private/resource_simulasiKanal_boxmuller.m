function z1=resource_simulasiKanal_boxmuller(N)

for i=1:N
   	u1=resource_simulasiKanal_randmcg; 
   	u2=resource_simulasiKanal_randmcg; 
	z1(i)=sqrt(-2*log(u1))*cos(2*pi*u2);
end
