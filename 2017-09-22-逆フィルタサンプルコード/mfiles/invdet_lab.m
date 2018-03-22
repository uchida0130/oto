%%% 実習で制作するmyfilt関数の実行速度に問題があるので、実験内での音声の畳込みにはこちらを用いる
%%% [Input]
%%% impdir                  : インパルス応答の格納ディレクトリ
%%% inv_length              : 生成する逆フィルタの長さ
%%% delay                   : 教師インパルスの遅延の大きさ
%%% alpha                   : 正則化項パラメータ、デフォルトが0.002、推奨は0.05程度まで
%%% LPFon                   : 教師インパルスにローパスフィルターをかけるか選択するオプション、0でオフ
%%% [Output]
%%% invdet                  : 生成した逆フィルタ
%%% y                       : フィルタ＊逆フィルタの生成波形
%%% error                   : フィルタ＊逆フィルタの生成波形と教師インパルス間の誤差

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
  % インパルスの行列式の計算
  impdet = conv(g11, g22)-conv(g12, g21);
  % 行列式に対する逆フィルタの計算
  invdet = invfilt_lab(impdet, inv_length, delay, alpha, LPFon);
  % フィルタ*逆フィルタ
  y = conv(impdet, invdet);
  % 誤差の計算
  if LPFon == 1
    d = butterfilt(2*(impulse_length-1)+inv_length,delay);
  else
    d = zeros(2*(impulse_length-1)+inv_length,1);
    d(delay) = 1;
  end
  error = mean(abs(y-d));
end
