#!/usr/bin/perl -w

use Text::ParseWords;

###########################
# Global vars
###########################


$PLATFORM = "none";
$ARCH = "none";
$OPERATION = 0;
$CROSSPLATFORM = 0;


%CMDLIST = ();
%PKGLIST = ();
$PKGCMD = "none";

$WORKINGDIR = `pwd` ;
$WORKINGDIR =~ s/\s+$//;

$NOXML = 0;
$NOPGRES = 0;
$NOCMD = 0;
$YESLEGACY = 0;

$XMLRPC_CONFIG_OPT = " ";
$GLIB_CONFIG_OPT = " ";
$LIBXML_CONFIG_OPT = " ";
$GDOME_CONFIG_OPT = " ";
$MTHEVAL_CONFIG_OPT = " ";
$PGRES_CONFIG_OPT = " ";
$FLEX_CONFIG_OPT = " ";
$JAM_VARS = " ";

$EXTTYPE = "none";
$EXTNAME = "none";
$EXTFILES = "none";
$EXTLIBS = "none";

$exe = "";



@HDRDIRS = ("server/include", "serial/include", "util/include", "amtypes/include", "configxml/include", "commands/commands/include", "commands/server/include");
@LIBDIRS = ("lib", "lib/datasinks", "lib/commands", "lib/parsers", "3rdparty/gdome2/lib", "3rdparty/httpd/lib", 
			"3rdparty/libmatheval/lib", "3rdparty/libxml2/lib", "3rdparty/modbus/lib", "3rdparty/postgresql/lib", "3rdparty/xmlrpc/lib");
@BINDIRS = ( "3rdparty/libxml2/bin","3rdparty/postgresql/bin","3rdparty/xmlrpc/bin","bin" );


###########################
# Functions
###########################

sub check_pkg {
	my $cmdlist = $_[0];
	my $testcmd = $_[1];
	
	if ( $cmdlist =~ /$testcmd/){
		return 1;
	}else{
		return 0;
	}
}


sub check_cmd  {
	my $testcmd = $_[0];	
  	if ( `which $testcmd | wc -c` != 0){ 
		return 1;
  	}else{
		return 0;
	}
}



sub set_system_vars(){
	#Cygwin and x86 system
	if ($PLATFORM eq "cygwin" and $ARCH eq "x86"){		
		%CMDLIST = ("gcc" => 0, "make" => 0, "perl" => 0, "jam" => 0);
		%PKGLIST = ("pkgconfig" => 0, "glib2" => 0, "glib2-devel" => 0,"libxml2" => 0, "libxml2-devel" => 0, "postgresql" => 0, "flex" => 0, "libreadline" => 0);
		$PKGCMD = "cygcheck -c";
		
		$XMLRPC_CONFIG_OPT = "LDFLAGS=-liconv";	
		$GDOME_CONFIG_OPT = " ";
		
	#Linux and x86 system
	}elsif ($PLATFORM eq "linux" and $ARCH eq "x86"){
		%CMDLIST = ("gcc" => 0, "make" => 0, "perl" => 0, "jam" => 0);
		%PKGLIST = ("pkg-config" => 0 );
		if (`more /proc/version | grep "Red Hat" | wc -c` != 0){
			$PKGCMD = "yum list installed";
		}else{
			$PKGCMD = "dpkg -l";
		}
		
		$GDOME_CONFIG_OPT = " --enable-static --disable-shared --with-libxml-prefix=$WORKINGDIR/build.$PLATFORM.$ARCH/3rdparty/libxml2 ";
		$XMLRPC_CONFIG_OPT = " --enable-static --disable-shared ";
		$GLIB_CONFIG_OPT = " --enable-static --disable-shared ";
		$LIBXML_CONFIG_OPT = " --enable-static --disable-shared ";
		$MTHEVAL_CONFIG_OPT = " --enable-static --disable-shared ";
		$PGRES_CONFIG_OPT = " --enable-static --disable-shared ";
		$FLEX_CONFIG_OPT = " --enable-static --disable-shared ";
	
	#Linux and arm system
	}elsif ( $PLATFORM eq "linux" and $ARCH eq "arm" ){
		%CMDLIST = ("arm-linux-gcc" => 0, "make" => 0, "perl" => 0, "jam" => 0);
		%PKGLIST = ("pkg-config" => 0);
		if (`more /proc/version | grep "Red Hat" | wc -c` != 0){
			$PKGCMD = "yum list installed";
		}else{
			$PKGCMD = "dpkg -l";
		}
				
		$GDOME_CONFIG_OPT = " --enable-static --disable-shared --with-libxml-prefix=$WORKINGDIR/build.$PLATFORM.$ARCH/3rdparty/libxml2 --build=i686-pc-linux-gnu --host=arm-linux ";
		$XMLRPC_CONFIG_OPT = " --enable-static --disable-shared --cache-file=linux_arm.cache --host=arm-linux CC=arm-linux-gcc ";
		$GLIB_CONFIG_OPT = " --enable-static --disable-shared --cache-file=linux_arm.cache --host=arm-linux CC=arm-linux-gcc ";
		$LIBXML_CONFIG_OPT = " --enable-static --disable-shared --host=arm-linux CC=arm-linux-gcc ";
		$MTHEVAL_CONFIG_OPT = " --enable-static --disable-shared --host=arm-linux CC=arm-linux-gcc ";
		$PGRES_CONFIG_OPT = " --enable-static --disable-shared --without-readline --without-zlib --host=arm-linux CC=arm-linux-gcc ";
		$FLEX_CONFIG_OPT = " --enable-static --disable-shared --host=arm-linux";
		$JAM_VARS = " -s OSPLAT=ARM ";		
	}else{
		print "Unsupported Platform and Arch $PLATFORM.$ARCH \n";
		exit();
	}
	
}


sub parse_input {
	# first arg is operation	
	$OPERATION = $ARGV[0] unless $#ARGV < 0 ;
	
	# parse options
	for(my $i = 0; $i <= $#ARGV; $i++){	
		if ($ARGV[$i] =~ /-p=/){
			$PLATFORM = $';
		}
		if ($ARGV[$i] =~ /-a=/){
			$ARCH = $';
		}
		if ($ARGV[$i] =~ /--no-postgres/){
			$NOPGRES = 1;
		}
		if ($ARGV[$i] =~ /--no-configxml/){
			$NOXML= 1;
		}
		if ($ARGV[$i] =~ /--no-cmd/){
			$NOCMD= 1;
		}
		if ($ARGV[$i] =~ /--yes-legacy/){
			$YESLEGACY= 1;
		}
		if ($ARGV[$i] =~ /-type=/){
			$EXTTYPE = $';
		}
		if ($ARGV[$i] =~ /-name=/){
			$EXTNAME = $';
		}
		if ($ARGV[$i] =~ /-files=/){
			$EXTFILES = $';
		}
		if ($ARGV[$i] =~ /-libs=/){
			$EXTLIBS = $';
		}


	}	
}


sub check_options() {
	my $GPLAT = "none";
	my $GARCH = "none";

	#guess the platform and arch
	if(`uname -a` =~ /cygwin/i){
		$GPLAT = "cygwin";
	}else{
		$GPLAT = "linux";
	}
	if(`uname -m` =~ /arm/i){
		$GARCH = "arm";
	}else{
		$GARCH = "x86";
	}


	if ($PLATFORM eq "none"){
		$PLATFORM = $GPLAT;
		print "Guessing Platform...$PLATFORM \n";
	}
	
	if ($ARCH eq "none"){
		$ARCH = $GARCH;
		print "Guessing Architecture...$ARCH \n";		
	}
	
	if (not($ARCH eq $GARCH) or not($PLATFORM eq $GPLAT)){
		$CROSSPLATFORM = 1;
		print "Cross platform compile...yes \n";		
	}else{
		print "Cross platform compile...no \n";		
	}


if($PLATFORM eq "cygwin"){
	 $exe = ".exe";
   }


	
}

sub check_operation() {
	if( $OPERATION eq "check"){
		$OPERATION = 10;
	}elsif($OPERATION eq "libs"){
		$OPERATION = 20;
	}elsif($OPERATION eq "dev"){
		$OPERATION = 30;
	}elsif($OPERATION eq "prod"){
		$OPERATION = 40;
	}elsif($OPERATION eq "install"){
		$OPERATION = 3;
	}elsif($OPERATION eq "clean"){
		$OPERATION = 1;
	}elsif($OPERATION eq "distclean"){
		$OPERATION = 2;
	}elsif($OPERATION eq "external"){
		$OPERATION = 4;
	}else{
		print "Usage: xbuild [check|libs|dev|prod|install]  [-p=<platform>|-a=<arch>|--no-postgres|--no-configxml|--no-cmd|--yes-legacy] \n";
		print "              [external -type=<parser|datasink> -name=<lib name> -files=<file1:file2:etc> -libs=<lib1:lib2:etc>] \n";
		
		print "		check 	  - check for necessary tools and libraries to build xserve2\n";
		print "		libs 	  - build necessary 3rdparty libraries \n";		
		print "		dev 	  - build xserve2 for development (including runtime scripts to start binaries)  \n";
		print "		prod	  - package xserve2 for production \n";
		print "		install	  - install production build  \n";
		print "		external  - build external parsers and datasinks.   \n";
		print "		clean 	  - clean dev/prod builds \n";
		print "		distclean - clean dev/prod builds and 3rdparty libraries \n";
		exit();
	}
}


sub check_environment(){

	#for right now we need all the packages and 
	#cmds listed so lets just put a boolean that 
	#dies if we don't find one but in the future
	#we have a hash of packages found so we can
	#be smarter and do selective builds based on 
	#whats installed

	my $MISSING = 0;

	for $cmd (keys(%CMDLIST)){		
		if(check_cmd($cmd) == 1){
			$CMDLIST{$cmd} = 1;
			print "Checking for $cmd.....yes \n";
		}else{
			print "Checking for $cmd.....no \n";
			$MISSING = 1;
		}
	}

	#calling each of the pkgcmds can be expensive 
	#so call it once and then search it everytime
	my $pkgresult = `$PKGCMD`;
	for $pkg (keys(%PKGLIST)){		
		if(check_pkg($pkgresult,$pkg) == 1){
			$PKGLIST{$pkg} = 1;
			print "Checking for $pkg.....yes \n";
		}else{
			print "Checking for $pkg.....no \n";
			$MISSING = 1;
		}
	}
	
	if($MISSING == 1){
		print "ERROR: Missing necessary commands and packages. Please install and retry. \n";
		exit;
	}
	
}

sub build_3rdparty_lib($$) {

	($libname, $confopts) = @_;	
	$_ = $libname =~ m/-/; 
	my $libbase = $`;
	
	#next check for libxml	
	if(not -e "$WORKINGDIR/build.$PLATFORM.$ARCH/3rdparty/$libbase"){
		print "\n";
		print "Checking $libname.....no \n";
		print "\n";
		print "Building $libname \n";
		
		if ( -e "$WORKINGDIR/3rdparty/$libname" and -d "$WORKINGDIR/3rdparty/$libname"){					
			`rm -r $WORKINGDIR/3rdparty/$libname`;
		}
		
		print "Extracting $WORKINGDIR/3rdparty/$libname.tgz \n";
		`tar xzvf $WORKINGDIR/3rdparty/$libname.tgz --directory=$WORKINGDIR/3rdparty/`;		

		if(-e "$WORKINGDIR/3rdparty/$libname"){
			chdir "$WORKINGDIR/3rdparty/$libname";
		}else{
			print "$libname extract failed. \n";
			return -1;
		}
		
		print "Configuring $WORKINGDIR/3rdparty/$libname \n";
		print "\n";
		if(($libbase eq "gdome2" or $libbase eq "flex") and $PLATFORM eq "linux" and $ARCH eq "arm"){
			open(CCCONFIG, ">$WORKINGDIR/3rdparty/$libname/ccconfig");
			print CCCONFIG "#!/bin/sh \n";
			print CCCONFIG "export CC=arm-linux-gcc \n";
			print CCCONFIG "$WORKINGDIR/3rdparty/$libname/configure --prefix=$WORKINGDIR/build.$PLATFORM.$ARCH/3rdparty/$libbase $confopts";
			close(CCCONFIG);
			`chmod 755 $WORKINGDIR/3rdparty/$libname/ccconfig`;
			system("$WORKINGDIR/3rdparty/$libname/ccconfig");
		}else{ 
			system("$WORKINGDIR/3rdparty/$libname/configure --prefix=$WORKINGDIR/build.$PLATFORM.$ARCH/3rdparty/$libbase $confopts");
		}
		if($? >> 8){	
			print "$libname configure Failed. \n";
			chdir "$WORKINGDIR";
			return -1;
		}
		print "\n";
		print "Making $WORKINGDIR/3rdparty/$libname \n";
		print "\n";

		#GDOME specific hack for linux builds.
		#GDOME needs Glib and its ask the pkgconfig for the include and lib
		#dirs. This is fine for cygwin since on cygwin we need it already 
		#installed.  But on linux we need to link to the one we build.
		#In this case we need to override the vars in the make file so 
		#we build a script with the vars in it...and then execute the file.
        if($libbase eq "gdome2" and $PLATFORM eq "linux" ){
			open(GDMAKEFILE, ">$WORKINGDIR/3rdparty/$libname/gdomemake");
			print GDMAKEFILE "#!/bin/sh \n";
			print GDMAKEFILE "export GLIB_CFLAGS=\"-I$WORKINGDIR/build.$PLATFORM.$ARCH/3rdparty/glib/include/glib-2.0/ -I$WORKINGDIR/build.$PLATFORM.$ARCH/3rdparty/glib/lib/glib-2.0/include/\" \n";
			print GDMAKEFILE "export GLIB_LIBS=\"-L$WORKINGDIR/build.$PLATFORM.$ARCH/3rdparty/glib/lib/ -lglib-2.0\" \n";
			print GDMAKEFILE "make --directory=$WORKINGDIR/3rdparty/$libname/ -e \n";
			close(GDMAKEFILE);
			`chmod 755 $WORKINGDIR/3rdparty/$libname/gdomemake`;
			system("$WORKINGDIR/3rdparty/$libname/gdomemake");

        }else{
			system("make --directory=$WORKINGDIR/3rdparty/$libname/");
        }
		if($? >> 8){	
			print "$libname make failed. \n";
			chdir "$WORKINGDIR";
			return -1;	
		}
		print "\n";
		print "Installing $WORKINGDIR/3rdparty/$libname \n";
		print "\n";
		system("make --directory=$WORKINGDIR/3rdparty/$libname install");
		if($? >> 8){
			print "$libname make install failed. \n";
			chdir "$WORKINGDIR";
			return -1;
		}
	
		chdir "$WORKINGDIR";
	
		`chmod -R 755 $WORKINGDIR/3rdparty/$libname`;
		`rm -r $WORKINGDIR/3rdparty/$libname`;
		print "\n";
		print "$libname installed successfully. \n";
		
	}else{
		print "Checking $libname.....yes \n";
	}
	
	return 0;
}



sub build_libs() {

	#first check for build directory
	if(not -e "$WORKINGDIR/build.$PLATFORM.$ARCH"){
		print "Checking build directory.....$WORKINGDIR/build.$PLATFORM.$ARCH \n";
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH"`;
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/bin"`;
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/obj"`;
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/lib"`;
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/lib/commands"`;
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/lib/parsers"`;
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/lib/datasinks"`;
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/include"`;
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/configxml"`;
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/sim"`;
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/web"`;	
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/logs"`;	

	}

	#build config xml libraries as long as we're not building legacy
	if($NOXML != 1 && $YESLEGACY != 1){
		#glib doesn't build well on cygwin so on cygwin platforms the user needs to 
		#already have glib installed so we don't try to compile it since we've already checked
		#for it.  i've made libxml2 also prerequired since it is a standard cygwin package.  we need
		#to get both of them under our standard compile for next release.  
		#Added postgres to the list of things we don't build to cygwin.  Assume its in the install.
		if($PLATFORM eq "cygwin"){
			if(not (build_3rdparty_lib("gdome2-0.8.1","$GDOME_CONFIG_OPT ") == 0 &&					
					build_3rdparty_lib("libmatheval-1.1.2","$MTHEVAL_CONFIG_OPT ") == 0) ){
						print "WARNING: Unable to build config xml package. \n";
						$NOXML = 1;
			}
		}else{	
			if(not (build_3rdparty_lib("flex-2.5.4","$FLEX_CONFIG_OPT ") == 0 &&
				build_3rdparty_lib("glib-2.8.4","$GLIB_CONFIG_OPT ") == 0 && 
				build_3rdparty_lib("libxml2-2.6.22","$LIBXML_CONFIG_OPT ") == 0 &&
				build_3rdparty_lib("gdome2-0.8.1","$GDOME_CONFIG_OPT ") == 0 &&
				build_3rdparty_lib("libmatheval-1.1.2","$MTHEVAL_CONFIG_OPT ") == 0) ){
						print "WARNING: Unable to build config xml package. \n";
						$NOXML = 1;
			}
		}
	}


	#build postgres library
	if($NOPGRES != 1){
		if(not ($PLATFORM eq "cygwin")){
			if(not ( build_3rdparty_lib("postgresql-8.0.4","$PGRES_CONFIG_OPT ") == 0)){
				print "WARNING: Unable to build postgres packages. \n";
				$NOPGRES = 1;
			}
		}
	}



	#build cmd library as long as were not building legacy
	if($NOCMD != 1 && $YESLEGACY != 1){
		if(not ( build_3rdparty_lib("xmlrpc-epi-0.51","$XMLRPC_CONFIG_OPT") == 0)){
			print "WARNING: Unable to build xml command packages. \n";
			$NOCMD = 1;
		}
	}

	
	
	#build 3rdparty libraries (modbus and http)	
	print "\nBuilding 3rdparty tools \n";
	system("jam -f JambaseXServe $JAM_VARS 3rdparty");
	
	#copy config file into server
	`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/3rdparty/httpd"`;
	`cp $WORKINGDIR/3rdparty/httpd/config $WORKINGDIR/build.$PLATFORM.$ARCH/3rdparty/httpd/.`;
	
	
}

sub clean_build(){	
	if(-e "$WORKINGDIR/build.$PLATFORM.$ARCH"){			
		system("jam -f JambaseXServe $JAM_VARS clean");
		chdir "$WORKINGDIR/build.$PLATFORM.$ARCH";
		`rm -rf ./web`;	
		`rm -rf ./include`;
		`rm -rf ./configxml`;
		`rm -rf ./sim`;
		`rm -f ./start_xserve`;
		`rm -f ./start_xserveterm`;
		`rm -f ./start_xsim`;
		chdir "$WORKINGDIR";
	}
}

sub clean_dist(){	
	`rm -rf ./build.$PLATFORM.$ARCH`;
}


sub build_base() {
	
	#build core
	print "\nBuilding Core \n";
	system("jam -f JambaseXServe $JAM_VARS core");
	if($YESLEGACY != 1){
		#build parsers
		print "\nBuilding Parsers \n";
		system("jam -f JambaseXServe $JAM_VARS parsers");
		#build datasinks
		print "\nBuilding Datasinks \n";
		system("jam -f JambaseXServe $JAM_VARS dsinks");
	}
	#check postgres
	if ($NOPGRES == 0){
		#build pgres items
		#xsim
		print "\nBuilding XSim \n";
		system("jam -f JambaseXServe $JAM_VARS xsim");

		if($YESLEGACY != 1){
			#pgres dsinks
			print "\nBuilding Datasinks (Postgres) \n";
			system("jam -f JambaseXServe $JAM_VARS dsinks_pgres");
		}		
		
		#legacy items (built but not put in loadable directories)
		print "\nBuilding Legacy Parsers and Datasinks \n";
		system("jam -f JambaseXServe $JAM_VARS legacy");		
		if($YESLEGACY == 1){
			`mv $WORKINGDIR/build.$PLATFORM.$ARCH/lib/legacy_parse* $WORKINGDIR/build.$PLATFORM.$ARCH/lib/parsers/.` ;
			`mv $WORKINGDIR/build.$PLATFORM.$ARCH/lib/legacy_dsink* $WORKINGDIR/build.$PLATFORM.$ARCH/lib/datasinks/.` ;
		}
		
		
		#copy sim files
		print "Moving Simulation Files \n";
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/sim/simfile"`;
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/sim/simdb"`;
		`cp sim/simfile/* $WORKINGDIR/build.$PLATFORM.$ARCH/sim/simfile/.` ;
		`cp sim/simdb/* $WORKINGDIR/build.$PLATFORM.$ARCH/sim/simdb/.` ;
		
	}

	#check config xml
	if ($NOXML == 0 && $YESLEGACY != 1){
		#build config xml
		print "\nBuilding ConfigXML Parser \n";
		system("jam -f JambaseXServe $JAM_VARS parsers_configxml");
		
		#copy config xml 
		print "Moving ConfigXML Files \n";
		`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/configxml"`;
		`cp configxml/xml/* $WORKINGDIR/build.$PLATFORM.$ARCH/configxml/.`;
	}

	#check command xml
	if ($NOCMD == 0 && $YESLEGACY != 1){
		#build command xml
		print "\nBuilding Command XML Server \n";
		system("jam -f JambaseXServe $JAM_VARS commandserver");
		print "\nBuilding Command XML Modules \n";
		system("jam -f JambaseXServe $JAM_VARS commands");
		#build xserve term
		print "\nBuilding Command XML Terminal \n";
		system("jam -f JambaseXServe $JAM_VARS xserveterm");
	}

	#copy web directory over
	print "Moving Web Files \n";
	`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/web"`;
	`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/web/images"`;
	`cp web/* $WORKINGDIR/build.$PLATFORM.$ARCH/web/.`;
	`cp web/images/* $WORKINGDIR/build.$PLATFORM.$ARCH/web/images/.`;

	#copy include files
	`mkdir -p "$WORKINGDIR/build.$PLATFORM.$ARCH/include"`;
	foreach $hdir (@HDRDIRS){
		print "Moving Header Files from $hdir \n";
		`cp $hdir/*.h $WORKINGDIR/build.$PLATFORM.$ARCH/include/.`;
	}

}

sub install_base {

	my $basedir = $_[0];

	#generate a properties file
	print "Building  $basedir/xparams.properties \n" ;
	open(PARAMFILE, ">$basedir/xparams.properties");
	print PARAMFILE "#The following parameters are used by XServe \n";
	print PARAMFILE "#to locate operating directories \n\n" ;
	print PARAMFILE "#The location of the configuration xml \n" ;
	print PARAMFILE "ConfigXMLDir = $basedir/configxml \n\n" ;
	print PARAMFILE "#The location of the parser dll files \n" ;
	print PARAMFILE "ParserLibDir = $basedir/lib/parsers \n\n" ;
	print PARAMFILE "#The location of the datasink dll files \n" ;
	print PARAMFILE "DataSinkLibDir = $basedir/lib/datasinks \n\n" ;
	print PARAMFILE "#The location of the datasink dll files \n" ;	
	print PARAMFILE "CommandLibDir = $basedir/lib/commands \n\n" ;
	print PARAMFILE "#The location of the xserve web directory for reporting \n" ;
	print PARAMFILE "XServeWebDir = $basedir/web \n\n" ;
	print PARAMFILE "#The location of the xserve Log files \n" ;
	print PARAMFILE "XServeLogDir = $basedir/logs \n\n" ;	
	close(PARAMFILE);
	
	#generate a start file
	
	my $libdirs = ".";
	my $bindirs = ".";
	foreach $ldir (@LIBDIRS) {
		$libdirs = "$libdirs:$basedir/$ldir"; 
	}
	foreach $bdir (@BINDIRS) {
		$bindirs = "$bindirs:$basedir/$bdir"; 
	}


	print "Building  $basedir/start_xserve \n" ;
	open(STARTFILE, ">$basedir/start_xserve");
	print STARTFILE "#!/bin/sh \n";
	print STARTFILE "export PATH=$libdirs:$bindirs:\"\$PATH\" \n" ;
	print STARTFILE "export LD_LIBRARY_PATH=$libdirs:$bindirs:\$LD_LIBRARY_PATH \n" ;
	print STARTFILE "export XSERVE_PARAMETER_FILE=$basedir/xparams.properties \n" ;
	print STARTFILE "$basedir/bin/xserve$exe \$@ \n" ;
	close(STARTFILE);
	`chmod 755 $basedir/start_xserve`;

	print "Building  $basedir/start_xsim \n" ;
	open(STARTFILE, ">$basedir/start_xsim");
	print STARTFILE "#!/bin/sh \n";
	print STARTFILE "export PATH=$libdirs:$bindirs:\"\$PATH\" \n" ;
	print STARTFILE "export LD_LIBRARY_PATH=$libdirs:$bindirs:\$LD_LIBRARY_PATH \n" ;
	print STARTFILE "export XSERVE_PARAMETER_FILE=$basedir/xparams.properties \n" ;
	print STARTFILE "$basedir/bin/xsim$exe \$@ \n" ;
	close(STARTFILE);
	`chmod 755 $basedir/start_xsim`;

	print "Building  $basedir/start_xserveterm \n" ;
	open(STARTFILE, ">$basedir/start_xserveterm");
	print STARTFILE "#!/bin/sh \n";
	print STARTFILE "export PATH=$libdirs:$bindirs:\"\$PATH\" \n" ;
	print STARTFILE "export LD_LIBRARY_PATH=$libdirs:$bindirs:\$LD_LIBRARY_PATH \n" ;
	print STARTFILE "export XSERVE_PARAMETER_FILE=$basedir/xparams.properties \n" ;
	print STARTFILE "$basedir/bin/xserveterm$exe \$@ \n" ;
	close(STARTFILE);
	`chmod 755 $basedir/start_xserveterm`;
}

sub build_dev(){
	build_base();
	install_base("$WORKINGDIR/build.$PLATFORM.$ARCH");
}

sub build_prod(){
	build_base();
	
	print "Creating Final Production Directory  \n";
	if( -e "$WORKINGDIR/bin.$PLATFORM.$ARCH"){		
		`rm -rf "$WORKINGDIR/bin.$PLATFORM.$ARCH"`;
	}
	`cp -r "./build.$PLATFORM.$ARCH" "./bin.$PLATFORM.$ARCH"`;	
	`cp ./xbuild.pl $WORKINGDIR/bin.$PLATFORM.$ARCH/.`; 	

	#clean up based on build
	chdir "$WORKINGDIR/bin.$PLATFORM.$ARCH";
	
	#all bins need to remove the obj/ directory
	print "Removing Object Files \n";
	`rm -rf ./obj`;
	
	#cygwin specific clean up 
        #CHANGE: Now all platforms make static 3rdparty libs so everyone can remove 3rdparty
	#makes for a bigger build but more portable since we don't have worry about shared libs
	#if ($PLATFORM eq "cygwin"){
		#cygwin is build with static libraries so there is no need for the 3rdparty
		#lib after the binaries have been built.  they are not dynamically loaded.
		print "Removing Static 3rdparty Libraries \n";
		`rm -rf ./3rdparty`;
	#}
	`rm -f ./start_xserve`;
	`rm -f ./start_xserveterm`;
	`rm -f ./start_xsim`;
	
}

sub build_install(){
	if (not(-e "./bin/xserve$exe")){
		print "ERROR: xbuild install must be run from the home directory of the installed build. \n";
		exit;
	}	
	install_base("$WORKINGDIR");	
}


sub build_external(){

	my @extfilelist = ();
	my @extliblist = ();

	if($EXTNAME eq "none"){
		print "ERROR: xbuild external -name value must be provided.  \n";
		exit;	
	}

	if($EXTFILES eq "none"){
		print "ERROR: xbuild external -files value must be provided.  \n";
		exit;	
	}else{
		@extfilelist = &parse_line(":",1, $EXTFILES);				
		foreach $filename (@extfilelist) {
			if(not(-e $filename)){
				print "ERROR: xbuild external file $filename does not exist.  \n";
				exit;
			}
		}

	}

	if(not($EXTLIBS eq "none")){
		@extliblist = &parse_line(":",1, $EXTLIBS);		
		foreach $libname (@extliblist) {
			if(not($libname =~ /-l/)){
				print "ERROR: xbuild external included library $libname does not begin with a -l.  Included libraries should be of the format -l<libname>.  \n";
				exit;			
			}
		}
	}



	if($EXTTYPE eq "datasink"){
		print "\nBuilding External Datasink \n";
		print "Datasink name: dsink_$EXTNAME located in lib/datasinks \n";
		print "Datasink files: @extfilelist \n";
		print "Datasink included libs: @extliblist \n";
		system("jam -f JambaseXServe $JAM_VARS -s EXTBUILDLIBNAME=$EXTNAME -s EXTBUILDFILES=\"@extfilelist\" -s EXTBUILDINCLIBS=\"@extliblist\" extdsink");
		
	
	}elsif($EXTTYPE eq "parser"){

		print "\nBuilding External Datasink \n";
		print "Datasink name: parse_$EXTNAME located in lib/parsers \n";
		print "Datasink files: @extfilelist \n";
		print "Datasink included libs: @extliblist \n";
		system("jam -f JambaseXServe $JAM_VARS -s EXTBUILDLIBNAME=$EXTNAME -s EXTBUILDFILES=\"@extfilelist\" -s EXTBUILDINCLIBS=\"@extliblist\" extparser");
		

	
	}else{
		print "ERROR: xbuild external type must be \"datasink\" or \"parser\" \n";
		exit;
	}



}

sub main() {

	if (not(-e "./xbuild.pl")){
		print "ERROR: xbuild must be run from its home directory. Exiting. \n";
		exit;
	}

	# Get params
	parse_input();
	#check operation
	check_operation();
	#check options and guess defaults
	check_options();

	#set system vars
	set_system_vars();

	if ($OPERATION == 1){
		clean_build();		
		exit;
	}

	if ($OPERATION == 2){
		clean_dist();		
		exit;
	}


	if ($OPERATION >= 10){
		check_environment();		
	}

	if ($OPERATION >= 20){
		build_libs();
	}

	if ($OPERATION == 30){
		build_dev();
	}

	if ($OPERATION == 40){
		build_prod();
	}

	if ($OPERATION == 3){
		build_install();
	}

	if ($OPERATION == 4){
		build_external();
	}


}


main();
