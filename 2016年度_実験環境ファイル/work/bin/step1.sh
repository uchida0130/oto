###################################################
# 実際に音声にする。
export HEARFILE=around.wav

#ここで逆フィルタを作成する。
/work/bin/dconv g0inv g22s h11 1.0
/work/bin/dconv g0inv g21s h12 1.0
/work/bin/dconv g0inv g12s h21 1.0
/work/bin/dconv g0inv g11s h22 1.0

/work/bin/double2ascii h11 > h11.txt
/work/bin/double2ascii h12 > h12.txt
/work/bin/double2ascii h21 > h21.txt
/work/bin/double2ascii h22 > h22.txt

#音声を畳み込んでみる。

/work/bin/sox $HEARFILE -t raw -c 1 hear1.pcm pick -l
/work/bin/sox $HEARFILE -t raw -c 1 hear2.pcm pick -r

/work/bin/make-impulse hear1.pcm h11 s1p
/work/bin/make-impulse hear2.pcm h12 s1n
/work/bin/make-impulse hear1.pcm h21 s2n
/work/bin/make-impulse hear2.pcm h22 s2p

/work/bin/dsub s1p s1n s1
/work/bin/dsub s2p s2n s2

/work/bin/double2ascii s1 > s1.txt
/work/bin/double2ascii s2 > s2.txt

echo '*** done. ***'


