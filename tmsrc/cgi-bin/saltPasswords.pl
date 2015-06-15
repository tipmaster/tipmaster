#!/usr/bin/perl

use Crypt::PBKDF2;

my $pbkdf2 = Crypt::PBKDF2->new(
	hash_class => 'HMACSHA1',
	iterations => 100,          # so is this
	output_len => 20,           # and this
	salt_len   => 4,            # and this.
);

`iconv -f iso-8859-1 -t utf-8 /tmdata/pass.txt > /tmdata/pass.txt.utf8`;
my $inputFilePath = "/tmdata/pass.txt.utf8";
my @lines         = ();
my $inputFile     = IO::File->new( $inputFilePath, "r" );
binmode( $inputFile, ":encoding(UTF-8)" );
@lines = $inputFile->getlines();
$inputFile->close();

open( A, ">/tmdata/hashedPasswords.txt" );

binmode( A, ":encoding(UTF-8)" );
foreach (@lines) {
	my @data = split( /&/, $_ );

	print $data[2], $data[1] . "\n";

	print A $data[0] . "&" . $data[1] . "&" . $pbkdf2->generate( $data[2], $data[1] ) . "&" . $data[3] . "&" . "\n";
}
close(A);

print "\n\n";
