#!/usr/bin/perl

=head1 NAME
	BTM MLib.pl

=head1 SYNOPSIS
	TBD
	


=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management


	Created 2015-06-09

=cut


use DBI;

# open DB connection
sub openDB {
    $db = shift; 
    $host = "localhost"; 
    $user = $ENV{DB_USER};
    $password = $ENV{DB_PASSWORD};
    $dbh = DBI->connect("DBI:mysql:database=$db;host=$host",
			$user, $password, {RaiseError => 1, PrintError => 1}) || die "Database connection not made";
    
}

# close DB connection
sub closeDB {
    $dbh->disconnect();
}


sub getValue {
$t=shift;
$what=shift;
$db = shift;
$query="";
      $sql = "SELECT $what FROM $db where trainer='$t'";
      $sth = $dbh->prepare($sql);
      $sth->execute();
       while (@data = $sth->fetchrow_array){$query=$data[0]}
      $sth->finish();
      return $query;
    }

sub getNew {
$t=shift;
$what=shift;

$query="";
      $sql = "SELECT $what FROM trainer where trainer='$t'";
      $sth = $dbh->prepare($sql);
      $sth->execute();
       while (@data = $sth->fetchrow_array){$query=$data[0]}
      $sth->finish();

$bba=length($query);
$bbc=$query;
$bbc=~s/&1#/&#/g;
$bbb=$bba - length($bbc);
$mail_new=$bbb;
return $mail_new;
    }

1;
