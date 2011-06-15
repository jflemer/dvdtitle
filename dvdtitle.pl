#!/usr/bin/env perl

# Copyright (C) 2011, James E. Flemer <jflemer@alum.rpi.edu>.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl 5.10.0.
#
# This program is distributed in the hope that it will be useful, but
# without any warranty; without even the implied warranty of
# merchantability or fitness for a particular purpose.

if (!@ARGV)
{
  use File::Basename;
  print STDERR "usage: ", basename($0), " /dev/dvd\n";
  exit 64;
}

my $dev = shift @ARGV;
open(DEV, '<', $dev)
  or die("ERROR: Unable to open DVD device: $dev - $!\n\t");
sysseek(DEV, 16*2048, 0)
  or die("ERROR: Cannot seek to sector 16 - $!\n\t");
my $buf = ("\0") x 2048;
sysread(DEV, $buf, 2048)
  or die("ERROR: Cannot read sector 16 - $!\n\t");
my $title = unpack('x40A32', $buf);
if (!$title)
{
  print STDERR "WARNING: No DVD title found, using UNKNOWN\n";
  $title = 'UNKNOWN';
}
print $title, "\n";
