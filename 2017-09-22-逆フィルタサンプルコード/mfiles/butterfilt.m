%%% [Input]
%%% d_length                : ��������C���p���X�g�`�̒���
%%% delay                   : �C���p���X�̒x��
%%% [Output]
%%% y                       : ��������6���o�^���[�XLPF�̃C���p���X�g�`

function y = butterfilt(d_length,delay)
  % �J�b�g�I�t���g��
  fc = 8000;
  % �T���v�����O���g��
  fs = 48000;
  % �o�^���[�X�t�B���^�̃t�B���^�W��
  [b,a] = butter(6,fc/(fs/2));
  % �o�^���[�X�t�B���^�̐}��(�m�F�p)
  % freqz(b,a);
  % saveas(gcf,'butter.png')
  d = zeros(d_length,1);
  d(delay) = 1;
  y = filter(b,a,d);
  % ����LPF�C���p���X�g�`�̐}��(�m�F�p)
  % plot(delay-10:delay+100,y(delay-10:delay+100));
  % saveas(gcf,'butterhakei.png')
end
