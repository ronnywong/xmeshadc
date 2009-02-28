#!/usr/bin/perl
#
# FILE:         ide
# AUTHOR:       Martin Turon
# DATE CREATED: May 5, 2006
# DESCRIPTION:  TAke PN shell command and execute it.
#
# $Id: ide.pl,v 1.1.2.1 2006/05/29 07:22:52 lwei Exp $
#

$| = 1;

my $g_version = '$Id: ide.pl,v 1.1.2.1 2006/05/29 07:22:52 lwei Exp $';

print "ide.pl Ver:$g_version\n";

# Grab first two command line arguments
$cmd = &prepare_cmd(shift);
$dir = &prepare_dir(shift);
print "Executing: $dir $cmd\n";

# Change to the proper directory and Run it!
chdir $dir;

# Run the command and in a separate process 
# and pipe the output of STDOUT and STDERR output 
# so we can display it as it becomes available.
open (CMD_OUTPUT, "$cmd 2&>1 |");
while (<CMD_OUTPUT>) { print; }


# Prepend the command with the shell to use so internal shell commands 
# such as "ls" or "echo" execute properly as well.
sub prepare_cmd {
	local ($l_cmd) = @_;
	
	$l_cmd = 'bash -c "'.$l_cmd.'"';
	return $l_cmd;
}

# Prepare the given win32 directory for use by unix/cygwin environment.
sub prepare_dir {
	local ($l_dir) = @_;

	# Convert Windows to unix directory delimeter
	# Then search for root using /opt/* regular expression pattern match
	$l_dir =~ tr|\\|/|;
	$l_dir =~ m|.*(/opt/.*)|;
	$l_dir = $1;
	return $l_dir;
}

