use Crypt::PBKDF2;

my $user = $ARGV[0] . ' ' . $ARGV[1];

#my $user = 'Jens Wörner';
#my $user = "Wally Dresel";
my $pass = "Donnerstag";

print generatePassword( $pass, $user );
print "\n\n";

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
