%%% [Input]
%%% imp                     : 逆フィルタを求めたいインパルス応答
%%% inv_length              : 生成する逆フィルタの長さ
%%% delay                   : 教師インパルスの遅延の大きさ
%%% alpha                   : 正則化項パラメータ、デフォルトが0.002、推奨は0.05程度まで
%%% [Output]
%%% h                       : 生成した逆フィルタ

function h = myinvfilt(imp, inv_length, delay, alpha)
  M = length(imp);
  % インパルス応答をずらしてならべた行列Gの生成
  G = zeros(M+inv_length-1, inv_length);
  for i = 1:inv_length
    for j = i:M+i-1
      G(j, i) = imp(j-i+1);
    end
  end
  d = zeros(M+inv_length-1, 1);
  d(delay) = 1;
  % 正則化項を含めた逆フィルタの計算
  h = inv(G'*G + alpha.*eye(inv_length)) * G' * d;
end
