function cathedral_filt()
  path(path,'ogawa/mfiles');    % �y�������w��z

  %%% ���̓t�@�C����(�X�e���I)
  is = 'ogawa/ex2_ogawa.wav';

  %%% �o�̓t�@�C����(�X�e���I)
  os = 'ogawa/cathedral_ogawa.wav';

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% �y���Ӂz�ȉ��͕ύX���Ȃ�����
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% �吹���̃C���p���X����
  [cathedral_impulse,Fs] = audioread(['imp/minster1_000_ortf_48k.wav']);
  % 5�b�ԕ��؂�o��
  imp_l = cathedral_impulse(1:240000,1);
  imp_r = cathedral_impulse(1:240000,2);

  %%% ���^�ς݉������t�@�C������ǂݍ���(�X�e���I)
  disp(['>> Now loading ' is ' ...']);
  % [ss, fs, nbit] = wavread(is);
  [ss, fs] = audioread(is);
  s1 = ss(:,1);
  s2 = ss(:,2);

  S = zeros(length(s1)+240000-1,2);
  % myfilt�֐��̎g�p�͑�ώ��Ԃ�������̂Ŕ�����
  S1 = conv(imp_l,s1);
  S2 = conv(imp_r,s2);
  S(:,1) = powernorm(S1);
  S(:,2) = powernorm(S2);
  % S(:,1) = myfilt(imp_l,voice(:,1));
  % S(:,2) = myfilt(imp_r,voice(:,2));
  audiowrite(os, S, Fs);


end
