#!/usr/bin/perl
@stack=();
@out=();
$set="false";
$_=$ARGV[0];
$bracket=0;
$_="(".$_.")";
@element=();

sub uutien{
	if($_[0]=~/[+-]/){return 1;}
	elsif($_[0]=~/[*%]/ || $_[0] eq "/"){return 2;}
	elsif($_[0] eq "^"){return 3;}
}
sub xetdau{
	my $i=0;
	for(split(//,$_[0])){
		if($_ eq "-"){
			$i++;
		}
	}
	if($i%2!=0){return "-";}
	else{return "+";}
}

@a=split(//);
for($i=0;$i<@a;){
	$n='';
	if($a[$i]=~/[0-9]/){
		do{
			$n.=$a[$i];
			$i++;
		}while($a[$i]=~/[0-9]/);
		push(@element,$n);
	}elsif($a[$i]=~/[+-]/){
		do{
			$n.=$a[$i];
			$i++;
		}while($a[$i]=~/[+-]/);
		push(@element,xetdau($n));
	}elsif($a[$i] eq "("){
		$bracket++;
		push(@element,"(");
		$i++;
		$xet="true";
	}elsif($a[$i] eq ")"){
		$bracket--;
		push(@element,")");
		$i++;
	}elsif($a[$i]=~/[*%]/ || $a[$i] eq "/" || $a[$i] eq "^"){
		push(@element,$a[$i]);
		$i++;
		$xet="true";
	}
	else{$i++;}

	if($xet eq "true"){
		if($a[$i]=~/[+-]/){
			do{
				$n.=$a[$i];
				$i++;
			}while($a[$i]=~/[+-]/);
			$n=xetdau($n);
			if($n eq "+"){$n='';}
			while($a[$i]=~/[0-9]/){
				$n.=$a[$i];
				$i++;
			}
			push(@element,$n);
		}
		$xet="false";
	}
}

if($bracket!=0){
	print "Bracket error\n";
	exit;
}

#infix to postfix
$i=0;

for(@element){
	if(/[0-9]/){
		push(@out,$_);
	}elsif($_ eq "("){
		push(@stack,"(");
	}elsif($_ eq ")"){
		$s=pop(@stack);
		while($s ne "("){
			push(@out,$s);
			$s=pop(@stack);
		}
	}elsif($_ eq "*" || $_ eq "/" || $_ eq "%" || $_ eq "+" || $_ eq "-" || $_ eq "^"){
		while(@stack!=0){
			$s=pop(@stack);
			if($s eq "("){
				push(@stack,"(");
				last;
			}else{
				$u1=uutien($_);
				$u2=uutien($s);
				if($u2 >= $u1){
					push(@out,$s);
				}else{
					push(@stack,$s);
					last;
				}
			}
		}
		push(@stack,$_);
	}
}
while(@stack!=0){
	push(@out,pop(@stack))
}
print "@out\n";

#postfix eval
$x=0,$y=0;
for(@out){
	if(/[0-9]/){
		push(@stack,$_);
	}
	elsif($_ eq "+"){
		$y=pop(@stack);
		$x=pop(@stack);
		push(@stack,$x+$y);
	}
	elsif($_ eq "-"){
		$y=pop(@stack);
		$x=pop(@stack);
		push(@stack,$x-$y);}
	elsif($_ eq "*"){
		$y=pop(@stack);
		$x=pop(@stack);
		push(@stack,$x*$y);
	}
	elsif($_ eq "/"){
		$y=pop(@stack);
		$x=pop(@stack);
		push(@stack,$x/$y);
	}
	elsif($_ eq "%"){
		$y=pop(@stack);
		$x=pop(@stack);
		push(@stack,$x % $y);
	}elsif($_ eq "^"){
		$y=pop(@stack);
		$x=pop(@stack);
		push(@stack,$x ** $y);
	}
}
print "$_=@stack\n";
