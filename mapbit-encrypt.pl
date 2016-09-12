$_=join('',reverse(split(//,"a")));
for$a(0..1){for$b(0..1){for$c(0..1){for$d(0..1){$bin[$i++]=$a.$b.$c.$d;}}}}
$i=0;
for$a(0..9,a..f){for$b(0..9,a..f){$hex[$i++]=$a.$b;}}
s/(.)/$hex[ord $1]/g;
s/(.)/$bin[hex($1)]/g;
s/^0//;
$_=join('',reverse(split(//)));
@a=/0*1*/g;
for(@a){
	s/(0*)//;
	$a=split(//,$1);
	$b=split(//)+4;
	if($a!=0||$b!=0){
		if($a<8&&$b<32){$out.=chr(($b<<3)+$a);}
		elsif($a>7&&$b<32){$out.=(chr 39)x(($a-$a%7)/7);$out.=chr(($b<<3)+($a-7*(($a-$a%7)/7)));}
		elsif($a<8&&$b>31){$out.=chr(($b-31*(($b-$b%31)/7)<<3)+$a);$out.=chr(248)x(($b-$b%31)/31);}
		elsif($a>7&&$b>31){$out.=(chr 39)x(($a-$a%7)/7);$out.=chr(($b-31*(($b-$b%31)/7)<<3)+($a-7*(($a-$a%7)/7)));$out.=chr(248)x(($b-$b%31)/31);}
	}
}
chop $out;
print $out;
