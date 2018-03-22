path(path,'mfiles');    % 【実験室指定】

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% パラメータ設定
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alpha       = 0.05;    % 正則化パラメータ(変更可)
Fs          = 48000;    % サンプリング周波数【実験室指定】
inv_length  = 6000;     % 逆フィルタのフィルタ長【実験室指定】
delay       = 900;      % 遅延量(変更可)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 入出力ファイルを指定すること
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% 入力ファイル名(ステレオ)
is = 'ex2_ogawa.wav';

%%% 出力ファイル名(ステレオ)
os = 'ex7_ogawa.wav';

%%% 入力ファイル名(モノラルx2)
% il = 'ex2_ogawa_left.wav';
% ir = 'ex2_ogawa_right.wav';

%%% 出力ファイル名(モノラルx2)
% ol = 'ex7_ogawa_left.wav';
% or = 'ex7_ogawa_right.wav';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 【注意】以下は変更しないこと
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
impdir = 'imp/old_imp/';

%%% (G_11 G_22 - G_12 G_21) の逆フィルタ出力を計算する
disp('>> Now calculating Inverse(G_11 G_22 - G_12 G_21) ...')
[invdet, y, error] = invdet_lab(impdir, inv_length, delay, alpha);

%%% 収録済み音声をファイルから読み込む(ステレオ)
disp(['>> Now loading ' is ' ...']);
% [ss, fs, nbit] = wavread(is);
[ss, fs] = audioread(is);
d = butterfilt(inv_length, 1);
s1 = ss(:,1);
s1_lpf = conv(s1,d);
s2 = ss(:,2);
s2_lpf = conv(s2,d);

%%% 収録済み音声をファイルから読み込む(モノラルx2)
% disp(['>> Now loading ' il ' ...']);
% disp(['>> Now loading ' ir ' ...']);
% % [s1, fs, nbit] = wavread(il);
% % [s2, fs, nbit] = wavread(ir);
% [s1, fs] = audioread(il);
% [s2, fs] = audioread(ir);

%%% 再生音声を合成する
disp('>> Now generating output signal ...')
[x1, x2] = myreproduce(impdir, s1_lpf, s2_lpf, invdet);
x1n = powernorm(x1);
x2n = powernorm(x2);

%%% 合成音声をファイルに書き出す(ステレオ)
disp(['>> Now saving ' os ' ...']);
len = length(x1n);
S = zeros(len,2);
S(:,1) = x1n;
S(:,2) = x2n;
% wavwrite(S, Fs, os);
audiowrite(os, S, Fs);

%%% 合成音声をファイルに書き出す(モノラルx2)
% disp(['>> Now saving ' ol ' ...']);
% disp(['>> Now saving ' or ' ...']);
% % wavwrite(x1n, Fs, ol);
% % wavwrite(x2n, Fs, or);
% audiowrite(ol, x1_n, Fs);
% audiowrite(or, x2_n, Fs);
