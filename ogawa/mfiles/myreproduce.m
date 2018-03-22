%%% ���K�Ő��삷��myfilt�֐��̎��s���x�ɖ�肪����̂ŁA�������ł̉����̏􍞂݂ɂ͂������p����
%%% [Input]
%%% impdir      : �C���p���X�����̊i�[�f�B���N�g��
%%% trgL(s1)    : �ړI������LEFT��
%%% trgR(s2)    : �ړI������RIGHT��
%%% invdet      : �s�񎮂ɑ΂���t�t�B���^
%%% [Output]
%%% outL(x1)    : ���������g�����X�I�[�����V�X�e��������LEFT��
%%% outR(x2)    : ���������g�����X�I�[�����V�X�e��������RIGHT��

function [outL, outR] = myreproduce(impdir, trgL, trgR, invdet)
  fid = fopen([impdir 'g11s']);
  g11 = fread(fid, 'double');
  fid = fopen([impdir 'g12s']);
  g12 = fread(fid, 'double');
  fid = fopen([impdir 'g21s']);
  g21 = fread(fid, 'double');
  fid = fopen([impdir 'g22s']);
  g22 = fread(fid, 'double');
  % [g11, fs, nbit] = wavread([impdir 'in_left_out_left.wav']);
  % [g12, fs, nbit] = wavread([impdir 'in_left_out_right.wav']);
  % [g21, fs, nbit] = wavread([impdir 'in_right_out_left.wav']);
  % [g22, fs, nbit] = wavread([impdir 'in_right_out_right.wav']);

  outL = conv(invdet, conv(trgL,g22)-conv(trgR,g21));
  outR = conv(invdet, conv(trgR,g11)-conv(trgL,g12));
end
