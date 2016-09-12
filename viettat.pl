#!/usr/bin/perl
chop($a=<>);
@a=split(/\s+/,$a);
for(@a){
	s/^(.).*$/\1/;
}
print @a;
