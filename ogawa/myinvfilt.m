%%% [Input]
%%% imp                     : �t�t�B���^�����߂����C���p���X����
%%% inv_length              : ��������t�t�B���^�̒���
%%% delay                   : ���t�C���p���X�̒x���̑傫��
%%% alpha                   : ���������p�����[�^�A�f�t�H���g��0.002�A������0.05���x�܂�
%%% [Output]
%%% h                       : ���������t�t�B���^

function h = myinvfilt(imp, inv_length, delay, alpha)
  M = length(imp);
  % �C���p���X���������炵�ĂȂ�ׂ��s��G�̐���
  G = zeros(M+inv_length-1, inv_length);
  for i = 1:inv_length
    for j = i:M+i-1
      G(j, i) = imp(j-i+1);
    end
  end
  d = zeros(M+inv_length-1, 1);
  d(delay) = 1;
  % �����������܂߂��t�t�B���^�̌v�Z
  h = inv(G'*G + alpha.*eye(inv_length)) * G' * d;
end
