#!/usr/bin/perl -w

$b = $ARGV[0];
shift @ARGV;

@out = ();
while (<>) {
    if (substr($_,5,10) eq 'CAL    CAL') {
        ($x, $y, $z) = split(' ', substr($_, 20, 24));
        s/CAL    CAL/CAM     D0/;
        push @out, $_;

        for $i (1..6) {
            $line = $_;
            substr($line, 14, 1) = $i;
            if ($i == 1) {
                ($xs, $ys, $zs) = map { $_*$b } (1, 0, 0);
            } elsif ($i == 2) {
                ($xs, $ys, $zs) = map { $_*$b } (-1, 0, 0);
            } elsif ($i == 3) {
                ($xs, $ys, $zs) = map { $_*$b } (0, 1, 0);
            } elsif ($i == 4) {
                ($xs, $ys, $zs) = map { $_*$b } (0, -1, 0);
            } elsif ($i == 5) {
                ($xs, $ys, $zs) = map { $_*$b } (0, 0, 1);
            } elsif ($i == 6) {
                ($xs, $ys, $zs) = map { $_*$b } (0, 0, -1);
            }
            substr($line, 20, 8) = sprintf "%8.3f", $x + $xs;
            substr($line, 28, 8) = sprintf "%8.3f", $y + $ys;
            substr($line, 36, 8) = sprintf "%8.3f", $z + $zs;
            push @out, $line;
        }
        next;
    }
    push @out, $_;
}
print $out[0];
print @out-3, "\n";
print @out[2..$#out];
