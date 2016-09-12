while(<>){
	$m=$_%2;
	if(!$m&&$_!=2){print "false|2\n";}
	else{
		for($i=3;$i*$i<=$_&&$m;$i+=2){$m=$_%$i;}
		print"true\n" if $m||$_==2;
		print"false|".($i-2)."\n" if !$m&&$_!=2;
	}
}