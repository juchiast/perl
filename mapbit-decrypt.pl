$in='(4:1A1:1)B)11A1))91:';
for(split(//,$in)){
	for(ord){
		$i+=$_&7;
		grep(vec($s,$i++,1)=1,1..($_>>3)-4);
	}
}
print $s;
<>;
