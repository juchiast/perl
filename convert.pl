#!/usr/bin/perl
@dict=(0..9,a..z,A..Z);

#make %dict from @dict
$index;
foreach (@dict){$dict{"$_"}=$index++;}

$in=$ARGV[0]; #input format:from-to-number
@in=split(/-/,$in);
$index=0;

#convert to decimal
	for(reverse(split(//,$in[2]))){
		die "input number invalid" unless $dict{$_}<$in[0];
		$t+= $dict{$_}*($in[0]**$index++);
	}
#convert to output base
	while($t>0){
		$mod=$t % $in[1];
		$t=($t-$mod)/$in[1];
		$out=$dict[$mod].$out;
	}	
print $out."\n";
