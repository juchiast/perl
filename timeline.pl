#!/usr/bin/perl
$FILE="/home/qwe/Documents/timeline.txt";
$BLOCK=43;
$DAY=86400;

sub valid{
	my($h, $m, $s)=@_;
	$m+=int($s/60);
	$s%=60;
	$h+=int($m/60);
	$m%=60;
	return ($h, $m, $s);
}
sub get{
	my $d;
	seek($_[0], $_[1]*$BLOCK, 0);
	read($_[0], $d, 4);
	$d=unpack("L", $d);
	return $d;
}
sub timein{
	my($h, $m, $s)=(0, 0, 0);
	my$label='';
	my($hh, $mm, $ss)=(0, 0, 0);
	my$d;
	my$x=int(time/$DAY)-$_[0];
	my$l=0;
	my$r=int((-s $FILE)/$BLOCK)-1;
	my$n=$r;
	my$i;
	open(my$f, "<", $FILE);
	while($l<=$r){
		$i=int(($l+$r)/2);
		$d=get($f, $i);
		$d=int($d/$DAY);
		if($d==$x){
			seek($f, $i*$BLOCK+4, 0);
			read($f, $label, 10);
			$i-- while(int(get($f, $i-1)/$DAY)==$x);
			for(;$i<=$n && int(get($f, $i)/$DAY)==$x;$i++){
				seek($f, ($i+1)*$BLOCK-9, 0);
				read($f, $d, 9);
				($hh, $mm, $ss)=$d=~m/\d+/g;
				($h, $m, $s)=($h+$hh, $m+$mm, $s+$ss);
			}
			$l=$r+1;
		}elsif($d>$x){
			$r=$i-1;
		}elsif($d<$x){
			$l=$i+1;
		}
	}
	close($f);
	return ($label, valid($h, $m, $s));
}
sub count{
	if($_[0]=~m/^-\d+$/){
		printf "%s: %dh%dm%ds\n", timein(-$_[0]);
	}elsif($_[0]=~m/^\d+$/){
		my@a;
		for($i=$_[0];$i>=0;$i--){
			@a=timein($i);
			printf "%s: %dh%dm%ds\n", @a if $a[0]!~m/^$/;
		}
	}elsif($_[0]=~m/^\+\d+$/){
		my($t, $h, $m, $s, $hh, $mm, $ss);
		for($i=$_[0];$i>=0;$i--){
			($t, $hh, $mm, $ss)=timein($i);
			($h, $m, $s)=($h+$hh, $m+$mm, $s+$ss);
		}
		printf "%dh%dm%ds\n", valid($h, $m, $s);
	}elsif($_[0]=~m/^\d+\/\d+\/\d+$/){
		my$d=`$0 cat | grep $_[0]`;
		my@a=$d=~m/\d+:\d+:\d+\n/g;
		my($h, $m, $s, $hh, $mm, $ss)=(0,0,0);
		for(@a){
			($hh, $mm, $ss)=m/\d+/g;
			($h, $m, $s)=($h+$hh, $m+$mm, $s+$ss);
		}
		printf "%dh%dm%ds\n", valid($h, $m, $s);
	}
}

sub now{ #return uptime in (h, m, s)
	my($f, $time, $idx);
	$idx= -s $FILE;
	return (0,0,0) if($idx % $BLOCK==0);
	$idx-=$idx % $BLOCK;
	open($f, "<", $FILE);
	seek($f, $idx, 0);
	read($f, $time, 4);
	close($f);
	($time)=unpack("L", $time);
	$time=time-$time;
	my$h=int($time/3600);
	my$m=int($time/60)%60;
	my$s=int($time)%60;
	return ($h, $m, $s);
}
sub on{
	return if (-s $FILE) % $BLOCK!=0;
	open(my$f, ">>", $FILE);
	print$f pack("L", time);
	close($f);
	system("echo -n `date +%Y/%m/%d-%H:%M:%S` >> $FILE");
}
sub off{
	return if (-s $FILE) % $BLOCK==0;
	my $f;
	system("echo -n `date +-%H:%M:%S` >> $FILE");
	my($h, $m, $s)=now();
	open($f, ">>", $FILE);
	printf $f "-%03d:%02d:%02d\n", $h, $m, $s;
	close($f);
}
sub cat{
	my($n, $f, $d);
	$num=$_[0];
	open($f, "<", $FILE);
	$n=-s $FILE;
	$n=int($n/$BLOCK);
	$num=$n if $num eq "all";
	for(my$i=$n-$num;$i<=$n;$i++){
		seek($f, $i*$BLOCK+4, 0);
		read($f, $d, $BLOCK-4);
		$d=~tr/-/ /;
		print $d;
	}
	print "\n";
	close($f);
}

sub conv{ #convert from old file format to new one
	my($a, $b)=@_;
	my$d;
	open(my$f, "<", $a);
	open(my$g, ">", $b);
	while(<$f>){
		($d, $c)=split(/_/, <$f>);
		chomp($c);
		print $g pack("L", $c).$d;
		$d=<$f>;
		($c)=$d=~m/\d+:\d+:\d+/g;
		print $g "-$c" if $d=~m/\d+:\d+:\d+/;
		$d=<$f>;
		printf $g "-%03d:%02d:%02d\n", $d=~m/\d+/g if $d=~m/\d+/;
		<$f>;
	}
	close($f);
	close($g);
}

if($ARGV[0] eq "cat" && @ARGV>=2){cat($ARGV[1]);}
elsif($ARGV[0] eq "on"){on;}
elsif($ARGV[0] eq "off"){off;}
elsif($ARGV[0] eq "now"){printf "%dh%dm%ds\n", now;}
elsif($ARGV[0] eq "count" && @ARGV>=2){count($ARGV[1]);}
#elsif($ARGV[0] eq "conv"){conv($ARGV[1], $ARGV[2])}
