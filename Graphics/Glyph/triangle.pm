package Bio::Graphics::Glyph::triangle;
# DAS-compatible package to use for drawing a triangle

use strict;
use vars '@ISA';
@ISA = 'Bio::Graphics::Glyph::generic';

sub draw {
  my $self = shift;
  my $gd = shift;
  my $fg = $self->fgcolor;
  my $orient = $self->option('orient') || 'S';

  # find the center and vertices
  my ($x1,$y1,$x2,$y2) = $self->calculate_boundaries(@_);
  my $xmid = ($x1+$x2)/2;
  my $ymid = ($y1+$y2)/2;

  my ($vx1,$vy1,$vx2,$vy2,$vx3,$vy3) = undef;

  #make an equilateral
  my ($p,$q) = ($self->option('height'),($x2-$x1)/2);
  if (defined $self->option('point')){
#    $p = $self->option('height');
    $q = $p/sqrt(3); #2;
    $x1 = $xmid - $q; $x2 = $xmid + $q;
    $y1 = $ymid - $q; $y2 = $ymid + $q;
  }

  if   ($orient eq 'N'){$vx1=$xmid-$q;$vy1=$y1;$vx2=$xmid+$q;$vy2=$y1;$vx3=$xmid;$vy3=$y2;}
  elsif($orient eq 'S'){$vx1=$xmid-$q;$vy1=$y2;$vx2=$xmid+$q;$vy2=$y2;$vx3=$xmid;$vy3=$y1;}
  elsif($orient eq 'E'){$vx1=$x2;$vy1=$y1;$vx2=$x2;$vy2=$y2;$vx3=$x2-$p;$vy3=$ymid;}
  elsif($orient eq 'W'){$vx1=$x1;$vy1=$y1;$vx2=$x1;$vy2=$y2;$vx3=$x1+$p;$vy3=$ymid;}

  # now draw the triangle
  $gd->line($vx1,$vy1,$vx2,$vy2,$fg);
  $gd->line($vx2,$vy2,$vx3,$vy3,$fg);
  $gd->line($vx3,$vy3,$vx1,$vy1,$fg);

  if ($self->option('fillcolor')){
    my $c = $self->color('fillcolor');
    $gd->fill($xmid,$ymid,$c);
  }

  $self->draw_label($gd,@_) if $self->option('label');
}

1;

__END__

=head1 NAME

Bio::Graphics::Glyph::ex - The "triangle" glyph

=head1 SYNOPSIS

  See L<Bio::Graphics::Panel> and L<Bio::Graphics::Glyph>.

=head1 DESCRIPTION

This glyph draws an equilateral triangle when -point is defined.
It draws an isoceles triangle otherwise.  It is possible to draw
the triangle with the base on the N, S, E, or W side.

=head2 OPTIONS

In addition to the common options, the following glyph-specific
options are recognized:
  Option      Description                  Default
  ------      -----------                  -------

  -point      Whether to draw a triangle   feature width
              with base the scaled width
              of the feature or length
              point.

  -orient     On which side shall the      S
              base be? (NSEW)

=head1 BUGS

Please report them.

=head1 SEE ALSO

L<Ace::Sequence>, L<Ace::Sequence::Feature>, L<Bio::Graphics::Panel>,
L<Bio::Graphics::Track>, L<Bio::Graphics::Glyph::anchored_arrow>,
L<Bio::Graphics::Glyph::arrow>,
L<Bio::Graphics::Glyph::box>,
L<Bio::Graphics::Glyph::primers>,
L<Bio::Graphics::Glyph::segments>,
L<Bio::Graphics::Glyph::toomany>,
L<Bio::Graphics::Glyph::transcript>,

=head1 AUTHOR

Allen Day <day@cshl.org>.

Copyright (c) 2001 Cold Spring Harbor Laboratory

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  See DISCLAIMER.txt for
disclaimers of warranty.

=cut