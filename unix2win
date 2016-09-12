#2015-02-05
#!/usr/bin/perl
die("Script for converting from UNIX line endings to Windows line endings\nExample:\nunix2win *.txt \"ab c.html\"\n") if @ARGV==0;

sub dkm{
open(F, "<$_[0]") || return(print "Error opening \"$_[0]\" for reading.\n");
open(G, ">$_[1]") || return(print "Error opening \"$_[1]\" for writing.\n");
while(<F>){
	s/\n$/\r\n/;
	print G;
}
close(F);
close(G);
system("cp \"$_[1]\" \"$_[0]\"");
}
$file="/tmp/".rand(1000);
while(open(Z, "<$file")){
	close(Z);
	$file="/tmp/".rand(1000);
}
system("touch $file");
$ls="/tmp/".rand(1000);
while(open(Z, "<$ls")){
	close(Z);
	$ls="/tmp/".rand(1000);
}
system("touch $ls");

for(@ARGV){
	$_='"'.$_.'"' if m/\s/;
	system("ls $_ > $ls");
	open(L, "<$ls");
	while($a=<L>){
		chomp($a);
		dkm($a, $file);
	}
	close(L);
}

system("rm $file");
system("rm $ls");
