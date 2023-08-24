#!/usr/bin/gnuplot

set loadpath '~/.gpl'
load 'viridis.pal'

set term pdfcairo enhanced color solid
set out 'surface.pdf'

set pm3d depthorder hidden3d interpolate 0,0 noborder
set style fill transparent solid 0.8
nsamp=50
set samples nsamp
set isosamples nsamp

#set view 80,240,1,1
set xrange[-2:2]
set yrange[-2:2]
unset colorbox
set xtics offset 0,-0.25
set ytics offset 1.25,0
set ztics 0.2

splot 0.5 w pm3d lc rgb 'grey' not, exp(-x**2)*exp(-y**2) w pm3d not
