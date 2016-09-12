while($p=<>){
$a='';
if($p%2==0){
	while($p%2==0){$p=$p/2;$n++;}
	$a.="2^$n ";$n=0;
}
for($i=3;$i<=$p;$i+=2){
		if($p%$i==0){
			for($m=3,$mj=1;$m<$i&&$mj;$m+=2){
				$mj=$i%$m;
			}
		if($mj){
			while($p%$i==0){$p=$p/$i;$n++;}
			$a.="$i^$n ";$n=0;
		}
	}
}
print "$a\n";
}