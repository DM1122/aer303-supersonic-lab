clear
%% Data and parameters
%%
AAs = [1.58; 1.26; 1.06; 1.00; 1.05; 1.15; 1.23; 1.27; 1.28]; %cross section areas at pressure tap locations
x_tunn = [0; 11.6; 24.7; 36.6; 48.3; 61.0; 73.7; 86.4; 99.1]; %x-coordinates of the pressure taps
pmeanvals = [67232.63540665884	58379.9603081509	43518.64272953275	30793.995226776566	35985.56088900427	30874.066861982985	30409.154704693323];
pmeanstdevs = [86.47104583978987	86.87833137652527	86.0700904157968	48.28540299050161	56.76168793999601	43.07532938404587	227.28091729476492];
%pmeanstdevs = pmeanstdevs.^2;
pzerostdev = 60.9175;
pzero = 91416.1915;
pmeanvals = round(pmeanvals,4);
pmeanvals = pmeanvals.';
pmeanstdevs = round(pmeanstdevs,4);
pmeanstdevs = pmeanstdevs.';
%parameters
gamma = 1.4; %gamma of air
%misc, utility variables and declariations

A = AAs(1); %used to individually go through areas in the mach number function. 
Mtheo = zeros(7,1); %theoretical Mach number distribution
fguess = [0.8;1;1;1;1;2;2;2;2]; %starting guess values for the mach number. These values are provided in this way to avoid the same values of M to be solved for before and after the nozzle

%% Theoretical Mach number distribution calculation using area relation
%%
% summary: given the area fraction, the Mfunc function uses root-finding to
% obtain the distribution of mach number in the tunnel. 
for i = 1:9
    Mfunc = @(M) 1./M.*(2.*(1+((gamma-1).*M.^2)./2)./(gamma+1)).^((gamma+1)./(2.*(gamma-1)))-A;
    A = AAs(i); % a bit of a lazy skip will fix if I have time. 
    Mtheo(i) = fzero(Mfunc,fguess(i)); %fzero can take a vector argument somehow.
end

%% Experimental mach number distribution data import and processing
%%
pmean_port1 = [67490.09415311318	58390.076304166716	43580.806865888175	30526.749496428863	35987.48538457074	31227.377431235775	31170.904528549225	46260.27933880318	39447.14475449894	70507.99503050186	55208.21020732521	100912.85485200191];
pstd_port1 = [97.71688962619336	115.6838025438463	111.5734092100098	54.88243111735022	59.917118383534564	58.228268484537054	67.1042470444366	172.79904852397442	590.7332559284866	37.01934996355994	624.1394802296998	38.671585953220806];
ptotstd_port1 = pstd_port1(end);
pstd_port1 = pstd_port1(1:7);
ptot_port1 = pmean_port1(end);
pmean_port1 = pmean_port1(1:7);

pmean_port2 = [67949.35902013426	57723.26337898748	43405.61354437492	30837.660318512917	35932.69697888156	30617.848671511336	31329.923298624453	32989.07960219968	39677.171551855165	70521.53297794354	55401.11609927405	100931.50262812857]; 
pstd_port2 = [111.25626623236161	111.79469370887189	122.56907684883758	66.13174278515719	66.72562925315614	53.56909508316883	78.31509002008917	85.11355701019448	762.7430045116307	43.91497535313043	618.2836857207649	42.73893538284874];
ptotstd_port2 = pstd_port2(end);
pstd_port2 = pstd_port2(1:7);
ptot_port2 = pmean_port2(end);
pmean_port2 = pmean_port2(1:7);

pmean_port3 = [67208.75498567829	58408.053661755905	50132.63821962004	32005.72659272878	36112.11562731166	30962.719854468785	30853.543040705365	33656.00520276338	39321.69761522081	70573.66787832881	54979.39467035192	100373.32567486748];
pstd_port3 = [105.12667762505727	116.54412835192416	124.87527037623296	100.0170191050436	83.1212809948851	59.486196789528556	78.73130235329455	58.049579639309364	512.8265054817105	38.196503008940304	627.1402756478122	53.46557999434904];
ptotstd_port3 = pstd_port3(end);
pstd_port3 = pstd_port3(1:7);
ptot_port3 = pmean_port3(end);
pmean_port3 = pmean_port3(1:7);

pmean_port4 = [67208.24231267901	58388.46504616909	43536.83529710633	30856.48837525462	36738.63583501132	30752.326742853205	31893.018532416885	34869.55852968201	38203.816957239316	70577.39179978496	55058.0984263908	96030.9403010601];
pstd_port4 = [110.12066895265316	104.05697562148241	110.63001646267121	69.10011160556401	84.17626952454366	82.24788375508548	72.86569113639476	99.13639247886107	541.0397217437936	44.69493560702979	628.1333228046511	151.9555502745192];
ptotstd_port4 = pstd_port4(end);
pstd_port4 = pstd_port4(1:7);
ptot_port4 = pmean_port4(end);
pmean_port4 = pmean_port4(1:7);

pmean_port5 = [67200.84517368992	58403.236789070615	43534.51981795579	31251.78179275379	36010.20074207596	30888.528747577242	30663.606145136808	33292.19892144895	38469.66325931231	70577.07067493928	55341.90518474527	92684.43067895113];
pstd_port5 = [106.74895666085577	114.43266919238333	103.82893532165454	113.29677546584658	66.69532069031735	55.198449418621244	97.75945459799047	85.73033427173108	667.8061096127224	40.5456838101303	632.060940923707	50.39495684192856];
ptotstd_port5 = pstd_port5(end);
pstd_port5 = pstd_port5(1:7);
ptot_port5 = pmean_port5(end);
pmean_port5 = pmean_port5(1:7);

pmean_port6 = [67219.99998904641	58411.94659628874	43544.97609363283	30817.277341465775	36002.792335548336	31879.6890344363	30688.321490716076	35245.99008782415	39292.63863357096	70578.83967847514	55409.955483184276	91840.18219210817];
pstd_port6 = [107.81926618649689	119.16677687794864	110.47166137313961	61.00197934819859	63.61838891745209	295.48913034182107	74.5694598371885	135.70094923164234	687.9348839733744	39.08072420614531	639.2039399873228	59.788055152686205];
ptotstd_port6 = pstd_port6(end);
pstd_port6 = pstd_port6(1:7);
ptot_port6 = pmean_port6(end);
pmean_port6 = pmean_port6(1:7);

pmean_port7 = [67239.6618436331	58372.41443765422	43512.57065306483	30789.660604736942	35954.685580157115	30872.63025083123	30549.911048456834	35682.95086249322	38813.62740542499	70557.57783342926	55526.60830870611	91402.16226882537];
pstd_port7 = [86.89886509677645	95.96867073776528	93.27409958475866	49.17692392348884	60.056094075754785	43.15593358373294	225.43056678560714	149.8246186826364	739.9953707017365	38.58918787184945	618.8769652841042	66.55167977545024];
ptotstd_port7 = pstd_port7(end);
pstd_port7 = pstd_port7(1:7);
ptot_port7 = pmean_port7(end);
pmean_port7 = pmean_port7(1:7);

ptot_ports = [ptot_port1; ptot_port2; ptot_port3; ptot_port4; ptot_port5; ptot_port6; ptot_port7];
pmeanports = [pmean_port1(1); pmean_port2(2); pmean_port3(3); pmean_port4(4); pmean_port5(5); pmean_port6(6); pmean_port7(7)];
ptotstd_ports = [ptotstd_port1; ptotstd_port2; ptotstd_port3; ptotstd_port4; ptotstd_port5; ptotstd_port6; ptotstd_port7];
pstdports = [pstd_port1(1); pstd_port2(2); pstd_port3(3); pstd_port4(4); pstd_port5(5); pstd_port6(6); pstd_port7(7)];

%% Turning the ptot data into pitot (:D) Mach number
%%
% Bypassing the intermediate calculations, we will go straight to the
% upwind mach number
Mfwd = zeros(1,7);
upper = zeros(1,7);
lower = zeros(1,7);
presserror = zeros(1,7);
for i = 1:7
    Pitot = ptot_ports(i);
    Pstat = pmeanports(i);
    ptoterr = ptotstd_ports(i);
    perr = pstdports(i)
    Psonicfrac = @(M) ((0.5.*(gamma+1).*M.^2).^(gamma/(gamma-1))).*(((2*gamma.*M.^2)-(gamma-1))./(gamma+1))^(-1/(gamma-1))-Pitot/Pstat;
    Mfwd(i) = fzero(Psonicfrac,fguess(i))
    presserror(i) = (Pitot/Pstat)*sqrt((ptoterr/Pitot)^2+(perr/Pstat)^2)
    Psonicfrac = @(M) ((0.5.*(gamma+1).*M.^2).^(gamma/(gamma-1))).*(((2*gamma.*M.^2)-(gamma-1))./(gamma+1))^(-1/(gamma-1))-(Pitot/Pstat)+presserror(i);
    upper(i) = fzero(Psonicfrac,fguess(i)) - Mfwd(i)
    Psonicfrac = @(M) ((0.5.*(gamma+1).*M.^2).^(gamma/(gamma-1))).*(((2*gamma.*M.^2)-(gamma-1))./(gamma+1))^(-1/(gamma-1))-(Pitot/Pstat)-presserror(i);
    lower(i) = fzero(Psonicfrac,fguess(i)) - Mfwd(i)
end

plot(x_tunn,Mtheo,'-*');
hold on
errorbar(x_tunn(3:end),Mfwd,upper,lower,'-o');
xlabel("x,mm");
ylabel("M");
legend("Theoretical Mach number","Experimental Mach number data")
title("Mach number distribtuion in the supersonic regime")
saveas(gcf,"supersonic-mach-dist.png");
%% Pressure - experimental vs theoretical + plot
%%
P1 = pmeanvals(1); %This "ref" pressure is used to calculate P0, which is then used to calculate the rest of the pressures
pressurefrac = @(M) ((1+((gamma-1).*M.^2)./2).^(gamma/(gamma-1))).*P1; %isentropic relation
P0root = pressurefrac(Mtheo(3)); 
pressurefrac = @(M) ((1+((gamma-1).*M.^2)./2).^(-gamma/(gamma-1))).*P0root; %After finding the P0 we carry on with theoretical calculations fo the pressure values
pressurestheo = pressurefrac(Mtheo)
length(pmeanvals)
length(pmeanstdevs)
plot(x_tunn,pressurestheo,'-*');
hold on 
errorbar(x_tunn(3:end),pmeanvals,pmeanstdevs,'-o');
xlabel("x, mm");
ylabel("P, Pa");
legend("Theoretical prediction","Experimental data")
title("Pressure distribtuion in supersonic regime")
saveas(gcf,"supersonic-pressure-dist.png");



%% Sanity checks and utility functions
%%

%AA = @(M) 1./M.*(2.*(1+((gamma-1).*M.^2)./2)./(gamma+1)).^((gamma+1)./(2.*(gamma-1)));
%Athroat = AA(Mtheo)
%plot(x_tunn,Athroat);