#! /usr/bin/perl

# rundenwechsel.pl - stellt von Q1 auf Q2 um.

my $old = shift @ARGV; 
my $new = shift @ARGV;


if (!$old || !$new) { print "usage: rundenwechsel.pl <alter runde> <neue runde>"; exit 1;}
#my $v = "/tmapp/tmsrc/cgi-bin/cl";
my $v = "/home/tm/www/cgi-bin/cl";

chdir $v;

my $lib = "$v/library.pl";
# Ergebnisse eintragen

print `$v/auswerter.pl $old C`;
print `$v/auswerter.pl $old U`;

# Neue Runde Auslosen

$erg = `$v/uefa_datenerstellung.pl $new 2>&1`;

print "Meldung UEFA: $erg\n";

$erg = `$v/datenerstellung.pl $new 2>&1`;

print "Meldung CL: $erg\n";

#print "Auslosung fertig, $lib wird ge�ndert\n";
#&changelib($old,$new,$lib);

exit 0;


sub changelib {
  my $old = shift;
  my $new = shift;
  my $lib = shift;
  my $tmplib = "/tmp/library.pl.temp";
  
  open(K,"<$lib") or die "Cannot oben $lib: $!";
  open(L,">$tmplib") or die "Cannot write to tmp lib: $!";

  while (<K>) {
    s/derzeitige_runde = \"$old\";/derzeitige_runde = \"$new\";/;
    print L;
  }

  close(K);
  close(L);
  `cp $lib $lib.before_$new`;
  print `cp $tmplib $lib`;

  return;
}
