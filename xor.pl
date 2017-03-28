#!/usr/bin/perl
open(F,"<$ARGV[0]")or die$!;open(G,">>$ARGV[0].xor");my@k=$ARGV[1]=~m/./g;for(@k){$_=ord$_;}my($d,$o,$i);while((read F,$d,1)!=0){print G chr(ord($d)^$k[$i%@k]);$i++;}close(F);close(G);
