#!/bin/perl -w
# CGI script to call xotap from web server
# $Id: xotap.cgi,v 1.9.2.10 2007/03/13 22:35:52 rkapur Exp $

sub CleanXotap()
{
	my $line="";
	my $reval=0;
	my $tmpstr="";
	my $cmd="ps -a|grep xotap >runxotap";
	$len=0;
	if(system($cmd) == -1)
	{
		return 0;
	}
	unless(open (TMPFILE, "runxotap" ))
	{
		return 0;
	}
    	while($line=<TMPFILE>)
    	{
    		$len=$len+length($line);
    		$tmpstr=$line;
	}
	close(TMPFILE);
    	if ($len > 100) 
    	{ 
    		$tmpstr=substr($tmpstr,2);
        	$reval=sprintf("%i",$tmpstr);
        	$cmd="kill -9 ".$reval;
        	system($cmd);
    	} 
    	else 
    	{ 
    		print "find no xotap\n";
        	return 0; 
    	}         
    	return 0;
}

sub GetNodeList($)
{
    my $name="";
    my $line="";
    my $nodelist="";
    $name=$_[0];
    unless(open (NLFILE, $name ))
    {
        printf("\nCould not Open the config file.\n");
        return "";
    }
    while($line=<NLFILE>)
    {   
    	$nodelist=$nodelist.$line;
    }
    close(NLFILE);
    return $nodelist;
}

sub main {
	$| = 1;                   # enable auto-flushing
	print "Content-Type: text/plain\n\n";
	my $cmdnum=0;
	my $val=0;
	my $pid=0;
	my $pos1=0;
	
	my $param="";
	my $line="";
	my $tmpstr="";
	use CGI;
	my $cgi = new CGI; 
	$cmdnum = $cgi->param('cmd'); 
	$val = $cgi->param('val');
	$pos1=index($val,"n=all",0);
	if($pos1>=0)
	{
		$param=substr($val,0,$pos1-1);
		$line= GetNodeList("nlcfg.cfg");
		$tmpstr=$line;
		$tmpstr=~ m/^([0-9]).*/;
		$tmpstr=$1;
		if($tmpstr eq "")
		{
			print "  No motes specified.\n";
			return;
		}
		$param=$param." ".$line;
	}
	else
	{
		$param=$val;
	}
	if($cmdnum == 0)
	{
		print " \n" ;
	}
	else
	{
		$cmdstr="./xotap.exe "."-r xotap.html ".$param." 2>&1";
		system($cmdstr);
	}
}
exit main();




