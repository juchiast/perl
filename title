#!/usr/bin/perl
($id) = `xprop -root | grep '_NET_ACTIVE_WINDOW(WINDOW)'`=~m/0x[0-9a-f]*/g;
`xwit -id "$id" -name "$ARGV[0]"`;
