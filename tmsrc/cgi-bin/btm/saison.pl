#!/usr/bin/perl

=head1 NAME
	BTM saison.pl

=head1 SYNOPSIS
	TBD
	
=head1 AUTHOR
	admin@socapro.com

=head1 CHANGELOG
	2015-06-09 Thomas: Added Session Management

=head1 COPYRIGHT
	Copyright (c) 2015, SocaPro Inc.
	Created 2015-06-09

=cut

use lib '/tmapp/tmsrc/cgi-bin/';

open( D1, "</tmdata/btm/main_nr.txt" );
$main_nr = <D1>;
chomp $main_nr;
close(D1);

our @main_saison = (
	"leer",
	"Saison 1997'1",
	"Saison 1998'1", "Saison 1998'2", "Saison 1998'3", "Saison 1998'4",
	"Saison 1999'1", "Saison 1999'2", "Saison 1999'3", "Saison 1999'4", "Saison 1999'5",
	"Saison 2000'1", "Saison 2000'2", "Saison 2000'3", "Saison 2000'4",
	"Saison 2001'1", "Saison 2001'2", "Saison 2001'3", "Saison 2001'4", "Saison 2001'5",
	"Saison 2002'1", "Saison 2002'2", "Saison 2002'3", "Saison 2002'4", "Saison 2002'5", "Saison 2002'6",
	"Saison 2003'1", "Saison 2003'2", "Saison 2003'3", "Saison 2003'4", "Saison 2003'5",
	"Saison 2004'1", "Saison 2004'2", "Saison 2004'3", "Saison 2004'4", "Saison 2004'5", "Saison 2004'6",
	"Saison 2005'1", "Saison 2005'2", "Saison 2005'3", "Saison 2005'4", "Saison 2005'5", "Saison 2005'6",
	"Saison 2006'1", "Saison 2006'2", "Saison 2006'3", "Saison 2006'4", "Saison 2006'5",
	"Saison 2007'1", "Saison 2007'2", "Saison 2007'3", "Saison 2007'4", "Saison 2007'5", "Saison 2007'6",
	"Saison 2008'1", "Saison 2008'2", "Saison 2008'3", "Saison 2008'4", "Saison 2008'5",
	"Saison 2009'1", "Saison 2009'2", "Saison 2009'3", "Saison 2009'4", "Saison 2009'5", "Saison 2009'6",
	"Saison 2010'1", "Saison 2010'2", "Saison 2010'3", "Saison 2010'4", "Saison 2010'5",
	"Saison 2011'1", "Saison 2011'2", "Saison 2011'3", "Saison 2011'4", "Saison 2011'5", "Saison 2011'6",
	"Saison 2012'1", "Saison 2012'2", "Saison 2012'3", "Saison 2012'4", "Saison 2012'5", "Saison 2012'6",
	"Saison 2013'1", "Saison 2013'2", "Saison 2013'3", "Saison 2013'4", "Saison 2013'5",
	"Saison 2014'1", "Saison 2014'2", "Saison 2014'3", "Saison 2014'4", "Saison 2014'5", "Saison 2014'6",
	"Saison 2015'1", "Saison 2015'2", "Saison 2015'3", "Saison 2015'4", "Saison 2015'5"

);

our @main_kuerzel = (
	"leer",
	"",
	"", "982", "", "984",
	"991", "992", "993", "994", "995",
	"001", "002", "003", "004",
	"011", "012", "013", "014", "015",
	"021", "022", "023", "024", "025", "026",
	"031", "032", "033", "034", "035",
	"041", "042", "043", "044", "045", "046",
	"051", "052", "053", "054", "055", "056",
	"061", "062", "063", "064", "065",
	"071", "072", "073", "074", "075", "076",
	"081", "082", "083", "084", "085",
	"091", "092", "093", "094", "095", "096",
	"101", "102", "103", "104", "105",
	"111", "112", "113", "114", "115", "116",
	"121", "122", "123", "124", "125", "126",
	"131", "132", "133", "134", "135",
	"141", "142", "143", "144", "145", "146",
	"151", "152", "153", "154", "155"

);
