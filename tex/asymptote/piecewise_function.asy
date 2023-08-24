settings.outformat="pdf";
import graph;
unitsize(1cm);

real xw=0.5;
int seg=5;

pair f(real t) {
   if (t < 1.0/seg) {
      real at=t*seg;
      return (xw-at,2.0);
   } else if ((1.0/seg <= t) && (t < 2.0/seg)) {
      real at=t*seg-1.0;
      return (-xw+sin(-pi*at),1.0+cos(pi*at));
   } else if ((2.0/seg <= t) && (t < 3.0/seg)) {
      real at=t*seg-2.0;
      return (-xw+at,0.0);
   } else if ((3.0/seg <= t) && (t < 4.0/seg)) {
      real at=t*seg-3.0;
      return (xw+sin(pi*at),-1+cos(pi*at));
   } else if ((4.0/seg <= t) && (t <= 5.0/seg)) {
      real at=t*seg-4.0;
      return (xw-at,-2.0);
   } else {
      return (0,0);
   }
}

path p = graph(f,0,1,n=20,operator ..);

draw(p);
