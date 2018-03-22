function simmakewave(impfile,infile,outfile)

% インパルスファイルと入力wavファイルの畳み込みを行い
% その結果をwavファイルに書き出す

%  impfile : impluse file（形式？）
%  infile  : wavファイル（モノラル）
%  outfile : waveファイル（モノラル）

imp = readfloat(impfile);

[rawdata,fs,nbits] = wavread(infile);

simdata = fftfilt(imp,rawdata);

wavwrite(simdata,fs,nbits,outfile);