package Bio::Graphics::Glyph::bdgp_gene;

use strict;
use Bio::Graphics::Glyph::generic;
use Bio::Graphics::Glyph::segmented_keyglyph;
use vars '@ISA';
@ISA = qw( Bio::Graphics::Glyph::segmented_keyglyph
	   Bio::Graphics::Glyph::generic
	 );

# group sets connector to 'solid'
sub connector {
  my $self = shift;
  return $self->SUPER::connector(@_) if $self->all_callbacks;
  return $self->SUPER::connector(@_) || 'solid';
}
# never allow our components to bump
sub bump {
  my $self = shift;
  return $self->SUPER::bump(@_) if $self->all_callbacks;
  return 0;
}
sub label {
  my $self = shift;
  return $self->SUPER::label(@_) if $self->all_callbacks;
  return unless $self->{level} == 0;
  return $self->SUPER::label(@_);
}
sub description {
  my $self = shift;
  return $self->SUPER::description(@_) if $self->all_callbacks;
  return unless $self->{level} == 0;
  return $self->SUPER::description(@_);
}

## yack, this _subseq screws up BDGP thumbnail drawing--no callback
## as feature turned into this Simple obj thingy!!!
## So we make a new glyph without it!!!

## Override _subseq() method to make it appear that a top-level feature that
## has no subfeatures appears as a feature that has a single subfeature.
## Otherwise at high mags gaps will be drawn as components rather than
## as connectors.  Because of differing representations of split features
## in Bio::DB::GFF::Feature and Bio::SeqFeature::Generic, there is
## some breakage of encapsulation here.
#sub _subseq {
#  my $self    = shift;
#  my $feature = shift;
#  my @subseq  = $self->SUPER::_subseq($feature);
#  return @subseq if @subseq;
#  if ($self->level == 0 && !@subseq && !eval{$feature->compound}) {
#    return Bio::Location::Simple->new(-start=>$feature->start,-end=>$feature->end);
#  } else {
#    return;
#  }
#}

1;

__END__

=head1 NAME

Bio::Graphics::Glyph::bdgp_gene - The "bdgp_gene" glyph

=head1 SYNOPSIS

  See L<Bio::Graphics::Panel> and L<Bio::Graphics::Glyph>.

=head1 DESCRIPTION

This glyph is used for drawing features of BioModel::Gene (Gadfly).
Unlike "graded_segments" or "alignment", the segments are a
uniform color and not dependent on the score of the segment.

=head2 OPTIONS

The following options are standard among all Glyphs.  See
L<Bio::Graphics::Glyph> for a full explanation.

  Option      Description                      Default
  ------      -----------                      -------

  -fgcolor      Foreground color	       black

  -outlinecolor	Synonym for -fgcolor

  -bgcolor      Background color               turquoise

  -fillcolor    Synonym for -bgcolor

  -linewidth    Line width                     1

  -height       Height of glyph		       10

  -font         Glyph font		       gdSmallFont

  -connector    Connector type                 0 (false)

  -connector_color
                Connector color                black

  -label        Whether to draw a label	       0 (false)

  -description  Whether to draw a description  0 (false)

  -strand_arrow Whether to indicate            0 (false)
                 strandedness

In addition, the alignment glyph recognizes the following
glyph-specific options:

  Option      Description                  Default
  ------      -----------                  -------

  -max_score  Maximum value of the	   Calculated
              feature's "score" attribute

  -min_score  Minimum value of the         Calculated
              feature's "score" attribute

If max_score and min_score are not specified, then the glyph will
calculate the local maximum and minimum scores at run time.


=head1 BUGS

Please report them.

=head1 SEE ALSO

L<Bio::Graphics::Panel>,
L<Bio::Graphics::Track>,
L<Bio::Graphics::Glyph::anchored_arrow>,
L<Bio::Graphics::Glyph::arrow>,
L<Bio::Graphics::Glyph::box>,
L<Bio::Graphics::Glyph::primers>,
L<Bio::Graphics::Glyph::segments>,
L<Bio::Graphics::Glyph::graded_segments>,
L<Bio::Graphics::Glyph::toomany>,
L<Bio::Graphics::Glyph::transcript>,
L<Bio::Graphics::Glyph::transcript2>,

=head1 AUTHOR

Shengqiang Shu E<lt>sshu@bdgp.lbl.govE<gt>

Copyright (c) 2002 BDGP

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  See DISCLAIMER.txt for
disclaimers of warranty.

=cut
