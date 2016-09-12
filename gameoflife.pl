while($w<=0){
	print "width=";
	chop($w=<STDIN>);
	print "width>0.\n" if $w<=0;
}
while($h<=0){
	print "height=";
	chop($h=<STDIN>);
	print "height>0.\n" if $h<=0;
}
$b="aa";
print "input with 0&1 only,length=width:\n";
for($i=0;$i<$h;$i++){
	chop($s=<STDIN>);
	@a=split(//,$s);
	if($s !~ /[^01]/ && @a == $w){
		for($j=0;$j<$w;$j++){
			$t{$i.":".$j}=$a[$j];
		}
	}else{
		$b="";
		print "stupid.\n";
		last;
	}
}
print "____________________\n";
while($b){
	for($i=0;$i<$h;$i++){
		for($j=0;$j<$w;$j++){
			$n=0;
			if($t{($i-1).":".($j-1)}==1){$n++;}
			if($t{($i-1).":".$j}==1){$n++;}
			if($t{($i-1).":".($j+1)}==1){$n++;}
			if($t{$i.":".($j-1)}==1){$n++;}
			if($t{$i.":".($j+1)}==1){$n++;}
			if($t{($i+1).":".($j-1)}==1){$n++;}
			if($t{($i+1).":".$j}==1){$n++;}
			if($t{($i+1).":".($j+1)}==1){$n++;}
			if($n==3){$t1{$i.":".$j}=1;}
			elsif($n==2){$t1{$i.":".$j}=$t{$i.":".$j};}
			else{$t1{$i.":".$j}=0;}
		}
	}
	for($i=0;$i<$h;$i++){
		for($j=0;$j<$w;$j++){
			$t{$i.":".$j}=$t1{$i.":".$j};
		}
	}
	for($i=0;$i<$h;$i++){
		for($j=0;$j<$w;$j++){
			print $t{$i.":".$j};
		}
		print "\n";
	}
	print "___________________\n";
	$b1="a";
	for($i=0;$i<$h;$i++){
		if(!($b1)){last;}
		else{
			for($j=0;$j<$w;$j++){
				if($t{$i.":".$j}!=$tb{$i.":".$j}){
					$b1="";
					last;
				}
			}
		}
	}
	if($b1){$b="";}
	else{
		for($i=0;$i<$h;$i++){
			for($j=0;$j<$w;$j++){
				$tb{$i.":".$j}=$t{$i.":".$j};
			}
		}
	}
}
<>;