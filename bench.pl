#!/usr/bin/perl
use strict;
use warnings;

use Math::Project3D;

use Benchmark;

my $proj1 = Math::Project3D->new(
   plane_basis_vector => [ 0, 0, 0 ],
   plane_direction1   => [ .4, 1, 0 ],
   plane_direction2   => [ .4, 0, 1 ],
);

my $proj2 = Math::Project3D->new(
   plane_basis_vector => [ 0, 0, 0 ],
   plane_direction1   => [ .4, 1, 0 ],
   plane_direction2   => [ .4, 0, 1 ],
);

my $proj3 = Math::Project3D->new(
   plane_basis_vector => [ 0, 0, 0 ],
   plane_direction1   => [ .4, 1, 0 ],
   plane_direction2   => [ .4, 0, 1 ],
);

my $proj4 = Math::Project3D->new(
   plane_basis_vector => [ 0, 0, 0 ],
   plane_direction1   => [ .4, 1, 0 ],
   plane_direction2   => [ .4, 0, 1 ],
);

$proj1->new_function(
  'a,b,c', '$a', '$a*$b', '$a*$b*$c*sqrt($a)'
);

$proj2->new_function(
  sub { $_[0] }, 
  sub { $_[0]*$_[1] },
  sub { $_[0]*$_[1]*$_[2]*sqrt($_[0]) },
);

$proj3->new_function(
  sub { my $a = shift; $a }, 
  sub { my $a = shift; my $b = shift; $a*$b }, 
  sub { my $a = shift; my $b = shift; my $c = shift; $a*$b*sqrt($c) }, 
);

$proj4->new_function(
  'a,b,c',
  sub { my $a = shift; $a }, 
  sub { my $a = shift; my $b = shift; $a*$b }, 
  sub { my $a = shift; my $b = shift; my $c = shift; $a*$b*sqrt($c) }, 
);

timethese(-60, {
  string => sub{ $proj1->project_range_callback(sub{}, [1,4,1],[1,4,1],[1,4,1]); },
  subs_direct => sub{ $proj2->project_range_callback(sub{}, [1,4,1],[1,4,1],[1,4,1]); },
  subs_alias => sub{ $proj3->project_range_callback(sub{}, [1,4,1],[1,4,1],[1,4,1]); },
  mixed_alias => sub{ $proj4->project_range_callback(sub{}, [1,4,1],[1,4,1],[1,4,1]); },
});

