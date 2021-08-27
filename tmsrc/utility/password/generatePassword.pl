use Crypt::PBKDF2;

my $user = "Martin Fischer";
my $pass = "Donnerstag";

print generatePassword($pass,$user);

sub generatePassword {
	my $clearPassword = shift;
	my $user          = shift;

	my $pbkdf2 = Crypt::PBKDF2->new(
		hash_class => 'HMACSHA1',
		iterations => 100,          # so is this
		output_len => 20,           # and this
		salt_len   => 4,            # and this.
	);

	my $hashedPassword = $pbkdf2->generate( $clearPassword, $user );
	return $hashedPassword;
}