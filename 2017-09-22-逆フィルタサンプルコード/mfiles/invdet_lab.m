%%% ���K�Ő��삷��myfilt�֐��̎��s���x�ɖ�肪����̂ŁA�������ł̉����̏􍞂݂ɂ͂������p����
%%% [Input]
%%% impdir                  : �C���p���X�����̊i�[�f�B���N�g��
%%% inv_length              : ��������t�t�B���^�̒���
%%% delay                   : ���t�C���p���X�̒x���̑傫��
%%% alpha                   : ���������p�����[�^�A�f�t�H���g��0.002�A������0.05���x�܂�
%%% LPFon                   : ���t�C���p���X�Ƀ��[�p�X�t�B���^�[�������邩�I������I�v�V�����A0�ŃI�t
%%% [Output]
%%% invdet                  : ���������t�t�B���^
%%% y                       : �t�B���^���t�t�B���^�̐����g�`
%%% error                   : �t�B���^���t�t�B���^�̐����g�`�Ƌ��t�C���p���X�Ԃ̌덷

function [invdet, y, error] = myinvdet(impdir, inv_length, delay, alpha, LPFon)
  switch nargin
  case {1,2}
  		disp('Syntax error');
  		return;
  	case 3
        alpha=0.002;
        LPFon = 1;
    case 4
      LPFon = 1;
  end

  [g11, fs] = audioread([impdir 'in_left_out_left.wav']);
  [g12, fs] = audioread([impdir 'in_left_out_right.wav']);
  [g21, fs] = audioread([impdir 'in_right_out_left.wav']);
  [g22, fs] = audioread([impdir 'in_right_out_right.wav']);
  % [g11, fs, nbit] = wavread([impdir 'in_left_out_left.wav']);
  % [g12, fs, nbit] = wavread([impdir 'in_left_out_right.wav']);
  % [g21, fs, nbit] = wavread([impdir 'in_right_out_left.wav']);
  % [g22, fs, nbit] = wavread([impdir 'in_right_out_right.wav']);

  impulse_length = length(g11);
  % �C���p���X�̍s�񎮂̌v�Z
  impdet = conv(g11, g22)-conv(g12, g21);
  % �s�񎮂ɑ΂���t�t�B���^�̌v�Z
  invdet = invfilt_lab(impdet, inv_length, delay, alpha, LPFon);
  % �t�B���^*�t�t�B���^
  y = conv(impdet, invdet);
  % �덷�̌v�Z
  if LPFon == 1
    d = butterfilt(2*(impulse_length-1)+inv_length,delay);
  else
    d = zeros(2*(impulse_length-1)+inv_length,1);
    d(delay) = 1;
  end
  error = mean(abs(y-d));
end
