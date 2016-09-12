#chuyeenr tuwf heej hexx sang heej 41
@a=(0..9,a..z,"=","!","^","?","~");
$n=0;
for($i=0;$i<16;$i++){for($j=0;$j<16;$j++){for($k=0;$k<16;$k++){for($l=0;$l<16;$l++){$hex[$n++]=$a[$i].$a[$j].$a[$k].$a[$l];}}}}
$n=0;
for($i=0;$i<41;$i++){for($j=0;$j<41;$j++){for($k=0;$k<41;$k++){$htb{$hex[$n++]}=$a[$i].$a[$j].$a[$k];}}}
$n=0;
for($i=0;$i<16;$i++){for($j=0;$j<16;$j++){$h[$n++]=$a[$i].$a[$j];}}
$n=0;
for($i=0;$i<41;$i++){for($j=0;$j<41;$j++){for($k=0;$k<41;$k++){$bth{$a[$i].$a[$j].$a[$k]}=$hex[$n++];}}}
sub encrypt{
	my $z=$t='';
	$_=$_[0];
	if(split(//)%2==1){$t='O';}
	for(/..|.$/g){
		for(/./g){
			$s.=$h[ord $_];
		}
		$z.=$htb{('0'x(4-split(//,$s))).$s};
		$s='';
	}
	$z=$t.$z;
	return $z;
}
sub decrypt{
	my $out=$o=$boo='';
	$_=$_[0];
	if(/O/){s/O//;$boo="A";}
	for(/.../g){
		$o.=$bth{$_};
	}
	if($boo){$o=~s/00(..)$/$1/;}
	for($o=~/../g){
		$out.=chr hex($_);
	}
	return $out;
}
while(<>){
chop $_;
print encrypt($_)."-";
print decrypt(encrypt($_))."\n";
}