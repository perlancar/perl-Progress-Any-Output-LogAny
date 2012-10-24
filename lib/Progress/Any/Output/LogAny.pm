package Progress::Any::Output::LogAny;

use 5.010;
use strict;
use warnings;

use Log::Any '$log';

# VERSION

sub new {
    my ($class, %args) = @_;
    bless \%args, $class;
}

sub update {
    my ($self, %args) = @_;

    my $meth = "debugf";
    my $level = $args{level} // "normal";
    if ($level eq 'low') {
        $meth = "tracef";
    } elsif ($level eq 'high') {
        $meth = "infof";
    }

    $log->$meth("(%s/%s) %s", $args{pos}, $args{target}//"?",
                $args{message} // "Progress");
}

1;
# ABSTRACT: Output progress to Log::Any

=head1 SYNOPSIS

 use Progress::Any '$progress';
 use Progress::Any::Output::LogAny;

 Progress::Any->set_output(
     output => Progress::Any::Output::LogAny->new(
         # options
     ),
 );

 $progress->init(target=>4);
 $progress->update(message=>"Test") for 1..4;

Will output in log:

 (1/4) Test
 (2/4) Test
 (3/4) Test
 (4/4) Test

=cut
