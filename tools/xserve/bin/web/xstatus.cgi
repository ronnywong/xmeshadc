#!/bin/perl -w
# CGI script to call xotap from web server
# $Id: xstatus.cgi,v 1.9.2.10 2007/03/13 22:36:04 rkapur Exp $

sub wnodelistpage()
{
    my $stmp="";
    my $filename="nodelist.html";
    if( open(LISTFILE,">$filename"))
    {
        $stmp="<html>\n<head><meta http-equiv='content-type' content='text/html; charset=utf-8'>\n";
        print LISTFILE $stmp;
        $stmp="<meta http-equiv='refresh' content='10'>\n";
        print LISTFILE $stmp;
        $stmp="<title>Node List</title>\n</head>\n<body>\n<h3>Node List</h3>\n<hr>\n";
        print LISTFILE $stmp;
        $stmp="<br>Node List does not exist.<br> please use <h3>REFRESH NODE LIST</h3> to create it.<br>";
        print LISTFILE $stmp;
        $stmp="\n</body>\n</html>\n";
        print LISTFILE $stmp;
        close LISTFILE;
    }
}

sub main {
	$| = 1;                   # enable auto-flushing
	my $flag=1;
	my $count=0;
	my $url="";
	my $cmdnum=0;
	my $valnum=0;
	use CGI;
	my $cgi = new CGI; 
	$cmdnum = $cgi->param('cmd'); 
	$valnum = $cgi->param('val'); 
	no CGI;
    	if($cmdnum==0)
    	{
	    my $filename="nodelist.html";
	    if( open(RFILE,"<$filename"))
	    {
	    	close RFILE;
	    }
	    else
	    {
	    	wnodelistpage();
	    }
	    $url = "./nodelist.html";
	    print "Location: $url\n\n";
	    	
	}
	elsif( $cmdnum==255)
	{
	    	$url = "./uidlist.html";
	    	print "Location: $url\n\n";
	}
	elsif ($cmdnum==8)
	{
	    $url = "./nodelist.html";
	    print "Location: $url\n\n";
	}
	else
	{
	    	$url = "./status".$cmdnum.".html";
	    	print "Location: $url\n\n";
    	}
	
}
exit main();




