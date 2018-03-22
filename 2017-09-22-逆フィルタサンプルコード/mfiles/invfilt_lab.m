%%% [Input]
%%% imp                     : �t�t�B���^�����߂����C���p���X����
%%% inv_length              : ��������t�t�B���^�̒���
%%% delay                   : ���t�C���p���X�̒x���̑傫��
%%% alpha                   : ���������p�����[�^�A�f�t�H���g��0.002�A������0.05���x�܂�
%%% LPFon                   : ���t�C���p���X�Ƀ��[�p�X�t�B���^�[�������邩�I������I�v�V�����A0�ŃI�t
%%% [Output]
%%% h                       : ���������t�t�B���^

function h = invfilt(imp, inv_length, delay, alpha, LPFon)
  M = length(imp);
  % �C���p���X���������炵�ĂȂ�ׂ��s��G�̐���
  G = zeros(M+inv_length-1, inv_length);
  for i = 1:inv_length
    for j = i:M+i-1
      G(j, i) = imp(j-i+1);
    end
  end
  if LPFon == 1
    d = butterfilt(M+inv_length-1, delay);
  else
    d = zeros(M+inv_length-1, 1);
    d(delay) = 1;
  end
  % �����������܂߂��t�t�B���^�̌v�Z
  h = inv(G'*G + alpha.*eye(inv_length)) * G' * d;
end
