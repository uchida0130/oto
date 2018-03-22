function simmakewave(impfile,infile,outfile)

% �C���p���X�t�@�C���Ɠ���wav�t�@�C���̏�ݍ��݂��s��
% ���̌��ʂ�wav�t�@�C���ɏ����o��

%  impfile : impluse file�i�`���H�j
%  infile  : wav�t�@�C���i���m�����j
%  outfile : wave�t�@�C���i���m�����j

imp = readfloat(impfile);

[rawdata,fs,nbits] = wavread(infile);

simdata = fftfilt(imp,rawdata);

wavwrite(simdata,fs,nbits,outfile);