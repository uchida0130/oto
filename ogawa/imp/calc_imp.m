function calc_imp(DIRNAME)

disp('Calculating Impulse Responce')
files_=dir([DIRNAME '/*.wav']);

for i=1:length(files_)
    fname=files_(i).name;
    disp(['Proc: ' DIRNAME '/' fname])
    calc_imp_([DIRNAME '/' fname],8,128,80,0.001);
end

end

function calc_imp_(TSPFILE,NUM,zero_points,interval,GAIN_CTL)

%%%%%%%%%%%%%%%%%%%%%%%
%%% --- Setting --- %%%
%%%%%%%%%%%%%%%%%%%%%%%
TSP='./tsp/tsp.wav';
ITSP='./tsp/itsp.wav';
switch nargin
	case 1
		NUM=8;
		zero_points=128;
		interval=80;
end
delta=zero_points+interval;

if exist('sync_wav')~=7
    mkdir('sync_wav');
end

if exist('imp_wav')~=7
    mkdir('imp_wav');
end

[~,TSPBASENAME,~]=fileparts(TSPFILE);

%%%%%%%%%%%%%%%%%%%%%%%%%
%%% --- WAVE read --- %%%
%%%%%%%%%%%%%%%%%%%%%%%%%
[tsp,fs]=audioread(TSP);
[itsp,fs]=audioread(ITSP);
[x,fs_]=audioread(TSPFILE);
if fs_~=fs
    disp('Sampling frequency is different');
    return
end
M=length(tsp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% --- Overlap and Add --- %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% --- Optimal position --- %%%
bgap=0;
egap=length(tsp);
for D=[25 1]
    Z=[];
    for gap=bgap:D:egap
        T_hed=1+gap;
        T_end=M+gap;
        x_=x(T_hed:T_end);
        r=corrcoef(x_,tsp);
        z=[gap;r(1,2)];
        Z=[Z z];
    end
    [~,idx]=max(Z(2,:));
    if idx-5>0
        bgap=Z(1,idx-5);
    else
        bgap=Z(1,1);
    end
    if idx+5>length(Z(1,:))
        egap=Z(1,idx+5);
    else
        egap=Z(1,end);
    end
end
[~,gidx]=max(Z(2,:));
gap=Z(1,gidx);
%%% --- overlap and add --- %%%
x_add=zeros(M,1);
% for k=2:NUM
for k=2
% for k=1:NUM+1
    T_hed=(k-1)*M+1+gap;
    T_end=k*M+gap;
    if T_end>length(x)
        T_end=length(x);
    end
    x_add=x_add+x(T_hed:T_end);
end
x_add=x_add/NUM;
x_add=x_add(1:end-delta);
audiowrite(['./sync_wav/' TSPBASENAME '.wav'],x_add,fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% --- Impulse Estimation --- %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
itsp=itsp(1:end-delta);
imp=fftfilt(itsp,x_add)*GAIN_CTL;
%imp=imp./max(abs(imp))*0.8;
% imp_=real(ifft(fft(itsp).*fft(x_add)));

audiowrite(['./imp_wav/' TSPBASENAME '.wav'],imp,fs);

end
