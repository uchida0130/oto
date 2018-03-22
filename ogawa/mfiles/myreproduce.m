%%% 実習で制作するmyfilt関数の実行速度に問題があるので、実験内での音声の畳込みにはこちらを用いる
%%% [Input]
%%% impdir      : インパルス応答の格納ディレクトリ
%%% trgL(s1)    : 目的音声のLEFT側
%%% trgR(s2)    : 目的音声のRIGHT側
%%% invdet      : 行列式に対する逆フィルタ
%%% [Output]
%%% outL(x1)    : 生成したトランスオーラルシステム音声のLEFT側
%%% outR(x2)    : 生成したトランスオーラルシステム音声のRIGHT側

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
