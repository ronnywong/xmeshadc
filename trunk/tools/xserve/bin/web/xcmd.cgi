#!/bin/perl -w
# CGI script to call xlisten from web server
# $Id: xcmd.cgi,v 1.9.2.10 2007/03/13 22:35:45 rkapur Exp $

$serialstr="";
$xmlnodeid=0;
$xmlgroupid=145;
$xmlseqno=20000;
$methodName="";
$methodValue="";
$gvalue=0;
$RespFlag=0;
%cmdlist = (
        1=>"reset",
        2=>"sleep",
        3=>"wake",
        5=>"get_config",
        17=>"actuate",
        18=>"actuate",
        19=>"actuate",
        20=>"actuate",
        0x81=>"set_groupid",
        0x82=>"set_nodeid",
        0x83=>"set_rfpower",
        0x84=>"set_rate",
        0xA0=>"configuid",
    );
    

sub GetSettingStr($$$)
{
	my $cmd=0;
	my $val=0;
	my $str="";
	$cmd=$_[0];
	$val=$_[1];
	$exstr=$_[2];
	if($cmd==0x82)
	{
		$str=sprintf("<member><name>newNodeId</name><value><int>%d</int></value></member></struct></value></param></params></methodCall>",$val);
	}
	if($cmd==0x83)
	{
		$str=sprintf("<member><name>newRfPower</name><value><int>%d</int></value></member></struct></value></param></params></methodCall>",$val);
	}
	if($cmd==0x84)
	{
		$str=sprintf("<member><name>newRate</name><value><int>%d</int></value></member></struct></value></param></params></methodCall>",$val);
	}
	if($cmd==0xa0)
	{
		$str=sprintf("xmesh_configuid %s %d -a=249",$exstr,$val);
	}
	return $str;
}

sub GetLampStr($$)
{
	my $cmd=0;
	my $val=0;
	my $str="";
	$cmd=$_[0];
	$stateval=$_[1];
	$cmdval=0;
	if($cmd==17)
	{
		$cmdval=2;
	}
	if($cmd==18)
	{
		$cmdval=1;
	}
	if($cmd==19)
	{
		$cmdval=0;
	}
	if($cmd==20)
	{
		$cmdval=3;
	}	
	$str="<member><name>actDevice</name><value><int>$cmdval</int></value></member>".
	"<member><name>actState</name><value><int>$stateval</int></value></member>".
	"</struct></value></param></params></methodCall>";
	return $str;
}

sub GetCmdStr($$$)
{
	my $cmd=0;
	my $val=0;
	my $exstr=0;
	$str="";
	$cmd=$_[0];
	$val=$_[1];
	$exstr=$_[2];
	
	$methodName="xmesh.".$cmdlist{$cmd};
	if($cmd>0 && $cmd<16)
	{
		if($cmd eq 5)
		{
			$RespFlag=1;
		}
		else
		{
			$RespFlag=0;
		}
		$methodValue="</struct></value></param></params></methodCall>";
	}
	elsif($cmd>=16 && $cmd<32)
	{
		$RespFlag=0;
		$methodValue=GetLampStr($cmd,$val);
	}
	elsif($cmd>=0x80 && $cmd<0xFF)
	{
		$RespFlag=1;
		$methodValue=GetSettingStr($cmd,$val,$exstr);
	}
	else
	{
		$methodValue="error";
	}
	my $xmlstr="<?xml version='1.0' encoding='UTF-8'?><methodCall><methodName>$methodName</methodName><params><param><value><struct>".
	"<member><name>seqNumber</name><value><int>$xmlseqno</int></value></member><member><name>destAddress</name><value><int>$xmlnodeid</int></value></member>".
	"<member><name>groupId</name><value><int>$xmlgroupid</int></value></member>";
	$xmlstr=$xmlstr.$methodValue;
	return $xmlstr;
}

sub GetValbyName($$$)
{
my $content=$_[0];
my $name=$_[1];
my $type=$_[2];
my $pos1=0;
my $pos2=0;
my $temstr="";
$content=lc($content);
$tagstr=$name;
$tagstr=lc($tagstr);
$pos1=index($content,$tagstr,0);
if($pos1==(-1))
{
	return "";
}
$content=substr($content,$pos1);
if($type==1)
{
	$pos2=index($content,"<int>",0);
	$pos2=$pos2+5;
	$pos1=index($content,"</int>",0);
}
if($type==2)
{
	$pos2=index($content,"<string>",0);
	$pos2=$pos2+8;
	$pos1=index($content,"</string>",0);
}
if($pos1==(-1) || $pos2==(-1) || $pos1<=$pos2)
{
	return "";
}
$temstr=substr($content,$pos2,$pos1-$pos2);
return $temstr;
}

sub RespOutput($)
{
my $content=$_[0];
my $name="";
my $tmpstr="";
$type=1;
@nested = ("nodeId","groupId","Rate","rfpower","rfchannel","uidstring");
foreach $name (@nested)
{
	if($name eq "uidstring")
	{
		$type=2;
	}
	else
	{
		$type=1;
	}
	$tmpstr=GetValbyName($content,$name,$type);
	if($tmpstr ne "")
	{
	print"<H4>	$name	 =	$tmpstr</H4>";
	}
}
}

sub CommandProcess($)
{
my $port=9003; 
my $host='localhost'; 
my $msg_out=$_[0];
my $msg_len=length($msg_out);
my $packhost=inet_aton($host); 
my $address=sockaddr_in($port,$packhost); 
my $buf = "";
my $blen= 0;
my $xmllen=0;
my $xmlstr="";
socket(CLIENT,AF_INET,SOCK_STREAM,6); 
connect(CLIENT,$address); 
$len=length($msg_out);
$lenstr=pack("l",$len);
syswrite(CLIENT,$lenstr,4);
syswrite(CLIENT,$msg_out,$len);
if($RespFlag eq 0)
{
	close CLIENT; 
	print ("<H3>  Command execute Successfully!</H3>\n");
	return 0;
}
$rin = '';
vec($rin, fileno(CLIENT), 1) = 1;
$timeout = 10;
$nfound = select($rout = $rin, undef, undef, $timeout);
if (vec($rout, fileno(CLIENT),1)){
    # data to be read on SOCKET
    $blen=sysread(CLIENT,$buf,4);
}
if($blen)
{
	$xmllen=unpack("l",$buf);
	$blen=sysread(CLIENT,$xmlstr,$xmllen);
	if($blen)
	{
		print "<H2>Response:</H2>";
		RespOutput($xmlstr);
	}
	else
	{
		print "not received\n";
	}
}
else
{
	print "CAN NOT GET RESPONSE!\n";
}
close CLIENT; 

}

sub main {
	$| = 1;                   # enable auto-flushing
	print "Content-Type: text/html\n\n";
	my $cmdnum=0;
	my $val=0;
	my $exstr="";
	my $setstr="";
	my $cmdstr="";
	my $tmpstr="";
	my $xmlmsgstr="";
	my $pid=0;
	my $len=0;
	my $url="";
	
	@strlist;

	use CGI;
	use Socket; 
	
	my $cgi = new CGI; 
	$cmdnum = $cgi->param('cmd'); 
	if($cmdnum == 0)
	{
		print "\n";
		return 0;
	}
	$val = $cgi->param('val');
	$gvalue=$val;
	$exstr=$cgi->param('estr');
	$setstr=$cgi->param('set');
	$serialstr=$exstr;
	@strlist=split(",",$setstr,10);
	$len=@strlist;
	if($len==2)
	{
		$xmlnodeid=sprintf("%i",$strlist[0]);
		$xmlgroupid=sprintf("%i",$strlist[1]);
	}
	$xmlmsgstr=GetCmdStr($cmdnum,$val,$exstr);
	CommandProcess($xmlmsgstr);
}
exit main();




