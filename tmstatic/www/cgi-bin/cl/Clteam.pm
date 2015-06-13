package Clteam;
use strict;

my $spielstring = "";

sub new {
  my $proto = shift;
  my $class = ref($proto) || $proto;
  my $self = {};
  $self->{SLOT} = undef;
  $self->{ID} = undef;
  $self->{TEAM} = undef;
  $self->{TRAINER} = undef;
  $self->{PT} = undef;
  $self->{MT} = undef;
  $self->{PP} = undef;
  $self->{SPIELE} = [];
  bless($self,$class);
  return $self;
}

sub slot {
  my $self = shift;
  if (@_) { $self->{SLOT} = shift; }
  return $self->{SLOT};
}

sub id {
  my $self = shift;
  if (@_) { $self->{ID} = shift; }
  return $self->{ID};
}

sub team {
  my $self = shift;
  if (@_) { $self->{TEAM} = shift; }
  return $self->{TEAM};
}

sub games {
  my $self = shift;
  if (@_) {$spielstring = shift;}
  @{ $self->{SPIEL} } = split(/&/,$spielstring);
  $self->{PP} = 0;
  $self->{PT} = 0;
  $self->{MT} = 0;
  foreach my $a_game ( @ {$self->{SPIEL} }) {
    ($a,$b) = split(/:/,$a_game);
    if ($a ne "-" && $b ne "-") {
      if (p2t($a) > p2t($b)) {
	$self->{PP}+=3;
      } elsif (p2t($a) == p2t($b)) {
	$self->{PP}++;
      }
      $self->{PT} += p2t($a);
      $self->{MT} += p2t($b);
    }
  }
  return @{ $self->{SPIEL} };
}

sub exportstring {
  my $self = shift;
  return join("&",(@ {$self->{SPIEL}} ));
}
    
sub insertGame {
  my $self = shift;
  my $gameToAdd = shift;
  my $gameString = shift;
  #print "Now changing Game No $gameToAdd to $gameString\n";
  $ {$self->{SPIEL} }[$gameToAdd-1] = $gameString;
  #print "The String is now : ",$self->exportstring,"\n";
}

sub showerg {
  my $self = shift;
  my $lfd = shift;
  my $game =  $ {$self->{SPIEL} }[$lfd-1];
  ($a,$b) = split(/:/,$game);
  if ($a == -1) {$a = 0;}
  if ($b == -1) {$b = 0;}
  return p2t($a)." : ".p2t($b)."&nbsp;&nbsp;&nbsp;[".$a."-".$b."]";
}

sub showgames {
  my $self = shift;
  foreach my $a_game (@ {$self->{SPIEL} }) {
    print $a_game,"\n";
  }
}
	
sub p2t {
    my $punkte = shift;
    if ($punkte<15) {return 0};
    if ($punkte<40) {return 1};
    if ($punkte<60) {return 2};
    if ($punkte<80) {return 3};
    if ($punkte<105) {return 4};
    if ($punkte<130) {return 5};
    if ($punkte<155) {return 6};
    return 7;
}


    
1;

