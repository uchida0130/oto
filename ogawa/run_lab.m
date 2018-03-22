path(path,'mfiles');    % �y�������w��z

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% �p�����[�^�ݒ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alpha       = 0.05;    % �������p�����[�^(�ύX��)
Fs          = 48000;    % �T���v�����O���g���y�������w��z
inv_length  = 6000;     % �t�t�B���^�̃t�B���^���y�������w��z
delay       = 900;      % �x����(�ύX��)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ���o�̓t�@�C�����w�肷�邱��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% ���̓t�@�C����(�X�e���I)
is = 'ex2_ogawa.wav';

%%% �o�̓t�@�C����(�X�e���I)
os = 'ex7_ogawa.wav';

%%% ���̓t�@�C����(���m����x2)
% il = 'ex2_ogawa_left.wav';
% ir = 'ex2_ogawa_right.wav';

%%% �o�̓t�@�C����(���m����x2)
% ol = 'ex7_ogawa_left.wav';
% or = 'ex7_ogawa_right.wav';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% �y���Ӂz�ȉ��͕ύX���Ȃ�����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
impdir = 'imp/old_imp/';

%%% (G_11 G_22 - G_12 G_21) �̋t�t�B���^�o�͂��v�Z����
disp('>> Now calculating Inverse(G_11 G_22 - G_12 G_21) ...')
[invdet, y, error] = invdet_lab(impdir, inv_length, delay, alpha);

%%% ���^�ς݉������t�@�C������ǂݍ���(�X�e���I)
disp(['>> Now loading ' is ' ...']);
% [ss, fs, nbit] = wavread(is);
[ss, fs] = audioread(is);
d = butterfilt(inv_length, 1);
s1 = ss(:,1);
s1_lpf = conv(s1,d);
s2 = ss(:,2);
s2_lpf = conv(s2,d);

%%% ���^�ς݉������t�@�C������ǂݍ���(���m����x2)
% disp(['>> Now loading ' il ' ...']);
% disp(['>> Now loading ' ir ' ...']);
% % [s1, fs, nbit] = wavread(il);
% % [s2, fs, nbit] = wavread(ir);
% [s1, fs] = audioread(il);
% [s2, fs] = audioread(ir);

%%% �Đ���������������
disp('>> Now generating output signal ...')
[x1, x2] = myreproduce(impdir, s1_lpf, s2_lpf, invdet);
x1n = powernorm(x1);
x2n = powernorm(x2);

%%% �����������t�@�C���ɏ����o��(�X�e���I)
disp(['>> Now saving ' os ' ...']);
len = length(x1n);
S = zeros(len,2);
S(:,1) = x1n;
S(:,2) = x2n;
% wavwrite(S, Fs, os);
audiowrite(os, S, Fs);

%%% �����������t�@�C���ɏ����o��(���m����x2)
% disp(['>> Now saving ' ol ' ...']);
% disp(['>> Now saving ' or ' ...']);
% % wavwrite(x1n, Fs, ol);
% % wavwrite(x2n, Fs, or);
% audiowrite(ol, x1_n, Fs);
% audiowrite(or, x2_n, Fs);
