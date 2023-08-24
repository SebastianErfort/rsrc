settings.outformat = 'pdf';
import graph3;
settings.render = 0; //for 0...N: no labels, too.

size(10cm,0);

real minx=-2, maxx = 2;
real miny=-2, maxy = 2;
real minz=-1, maxz = 2;

dot((1,1,1));
label("test",(1,1,1));

axes3("$x$", "$y$", "$z$", min=(minx,miny,minz), max=(maxx,maxy,maxz), arrow=Arrow3);
