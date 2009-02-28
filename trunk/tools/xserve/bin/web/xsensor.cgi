#!/bin/perl -w
# CGI script to receive packet and parse packet from socket
# $Id: xsensor.cgi,v 1.8.2.10 2007/03/13 22:35:58 rkapur Exp $

$serialstr="";
$xmlnodeid=0;
$xmlgroupid=145;
$xmlseqno=20000;
$methodName="";
$methodValue="";
$gvalue=0;
$RespFlag=0;
$MyCount=0;

sub GetValbyName($$)
{
my $content=$_[0];
my $name=$_[1];
my $pos1=0;
my $pos2=0;
my $temstr="";
my $tagstr="<".$name.">";
$pos1=index($content,$tagstr,0);
if($pos1==(-1))
{
	return "";
}
$content=substr($content,$pos1+length($tagstr));
$tagstr="</".$name.">";
$pos2=index($content,$tagstr,0);
if($pos2==(-1))
{
	return "";
}
$temstr=substr($content,0,$pos2);
return $temstr;
}

sub GetFieldStr($$)
{
my $content=$_[0];
my $name=$_[1];
my $pos1=0;
my $pos2=0;
my $temstr="";
my $item="";
my $rstr="<tr align='center'><td>".substr($name,0,1)."</td>";
my $tagstr="<ParsedDataElement>";
$pos1=index($content,$tagstr,0);
while($pos1>0)
{
	$tagstr="</ParsedDataElement>";
	$pos2=index($content,$tagstr,0);
	if($pos2>0)
	{
		$temstr=substr($content,0,$pos2);
		$item=GetValbyName($temstr,$name);
		if($item ne "")
		{
			$item="<td>".$item."</td>";
		}
		$rstr=$rstr.$item;
	}
	else
	{
		$pos2=$pos1+19;
	}
	$content=substr($content,$pos2);
	$pos1=index($content,"<ParsedDataElement>",0);
}
$rstr=$rstr."</tr>";
return $rstr;
}

sub GetCounter($)
{
my $val=$_[0];
unless(open (LOGFILER, "counter" ))
{
    if( open(LOGFILEW,">counter"))
    {
    	print LOGFILEW "1\n";
    	close LOGFILEW;
    }
    return 1;
}
$line=<LOGFILER>;
close LOGFILER;
$MyCount=sprintf("%i",$line);
if($val == 0)
{
    if( open(LOGFILEW,">counter"))
    {
	$MyCount=$MyCount+1;
    	$stmp=sprintf("%i",$MyCount);
    	print LOGFILEW $stmp;
    	close LOGFILEW;
    }
    return $MyCount;
}
return $MyCount;
}

sub GetRawdata($)
{
my $content=$_[0];
my $rstr="<td>RawPacket</td><td colspan='40'>";
my $str="";
my $pos1=-1;
my $pos2=-1;
$pos1=index($content,"<RawPacket>",0);
if($pos1<0) 
{
return "";
}
$pos2=index($content,"</RawPacket>",$pos1+5);
if($pos2<0) 
{
return "";
}
$str=substr($content,$pos1+11,$pos2-$pos1-11);
$rstr=$rstr.$str;
$rstr=$rstr."</td>";
return $rstr;
}

sub GetFlag($)
{
my $content=$_[0];
my $flag=0;
my $pos1=-1;
$pos1=index($content,"<RawPacket>",0);
if($pos1>=0)
{
	$flag=$flag + 0x01;
}
$pos1=index($content,"<RawValue>",0);
if($pos1>=0)
{
	$flag=$flag + 0x02;
}
$pos1=index($content,"<ConvertedValue>",0);
if($pos1>=0)
{
	$flag=$flag + 0x04;
}
return $flag;
}

sub ParseData($)
{
my $content=$_[0];
my $outstr="";
my $flag=0;
$flag=GetFlag($content);
if(($flag & 0x01) !=0)
{
$outstr=GetRawdata($content);
#write_stdout($outstr);
}
if(($flag & 0x06) !=0)
{
	$outstr=$outstr.GetFieldStr($content,"Name");
	if(($flag & 0x02) !=0)
	{
	$outstr=$outstr.GetFieldStr($content,"RawValue");
	}
	if(($flag & 0x04) !=0)
	{
	$outstr=$outstr.GetFieldStr($content,"ConvertedValue");
	}
	$outstr="<table width='725' height='10' border='1'>".$outstr."</table>";
	write_stdout($outstr);
}
return 0;
}

sub CommandProcess()
{
my $port=9005; 
my $host='localhost'; 
my $packhost=inet_aton($host); 
my $address=sockaddr_in($port,$packhost); 
my $buf = "";
my $blen= 0;
my $xmllen=0;
my $xmlstr="";
my $seqnum=0;
my $count=0;
my $num=0;
my $outstr="";
$RANDOMSTRING="\n--Crossbow..Technology..INC.\n\n"; 
$ENDSTRING="\n--Crossbow..Technology..INC.-- \n\n"; 
#$MSG="<table width='725' height='10' border='1'><tr><td>11</td><td>22</td><td>33</td></tr></table>";
socket(CLIENT,AF_INET,SOCK_STREAM,6); 
connect(CLIENT,$address); 
$seqnum=GetCounter(0);
$count=$seqnum;
while($count eq $seqnum)
{
	$rin = '';
	vec($rin, fileno(CLIENT), 1) = 1;
	$timeout = 10;
	$nfound = select($rout = $rin, undef, undef, $timeout);
	if (vec($rout, fileno(CLIENT),1)){
	    # data to be read on SOCKET
	    $blen=sysread(CLIENT,$buf,4);
	}
	if($blen==4)
	{
		$xmllen=unpack("l",$buf);
		$blen=sysread(CLIENT,$xmlstr,$xmllen);
		$seqnum=GetCounter(1);
		$num=($num+1)%100;
#		if($num==1)
#		{
#			write_stdout($HEADER);
#			write_stdout("Content-Type: text/html\n");
#		}
		if($num==0)
		{
			last;
		}
		if($blen)
		{
			ParseData($xmlstr);
#			write_stdout($ENDSTRING);
			write_stdout("-");
		}
	}
	else
	{
		last;
	}
}
close CLIENT; 
}

# OUTPUT with syswrite()
sub write_stdout { 
        ($buf) = @_; 
        $offset = 0; 
        $len=length($buf); 
        while ($len) {  # Handle partial writes 
                $written = syswrite(STDOUT, $buf, $len, $offset); 
                die "System write error: $!\n" 
                        unless defined $written; 
                $len -= $written; 
                $offset += $written; 
        } 

} 

sub main {
	select(STDOUT); 
	$| = 1;                   # enable auto-flushing
#	$HEADER= "Content-type:multipart/mixed;boundary=Crossbow..Technology..INC.\n\n"; 
	$HEADER= "Content-Type: text/html\n\n"; 
	write_stdout($HEADER);
#	write_stdout("\n--Crossbow..Technology..INC.\n\n");
#	write_stdout("Content-Type: text/plain\n\n");
	
	use Socket; 
	CommandProcess();
}
exit main();




