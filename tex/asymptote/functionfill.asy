// Settings
settings.outformat="pdf";
unitsize(1cm);
import graph;

// Axis ranges and paths
real xmax=2pi;
real ymax=1.0;
real mrgn=0.2;
real xmaxd=xmax+mrgn;
real ymaxd=ymax+mrgn;
 
path xaxis = ((0.0,0.0) -- (xmaxd,0.0));
path yaxis = ((0.0,0.0) -- (0.0,ymaxd));

// Create path to be drawn and filled
// --- old ---
// path data;
// int ni=20;
// for(int i=0; i<=ni; ++i)
//    data=data..(xmax*(i/ni), sin(xmax*(i/ni)));
// --- new (using graph module) ---
path data=graph(sin,0,xmax,n=20, operator ..);

// Draw and fill
fill(data -- cycle,lightblue+opacity(0.5));
 
draw(xaxis, arrow=Arrow(TeXHead), L=Label("$x$",position=EndPoint),align=S);
draw(yaxis, arrow=Arrow(TeXHead), L=Label("$y$",position=EndPoint),align=W);

dot(data);
draw(data);

// --------------------------------------------------
// 2nd plot

// Parametric function (more reasonable line segmenting)  
pair f(real t) {
   return (t^2, t);
}
path data=graph(f,0,sqrt(xmax),n=20,operator ..);
 
fill(data -- (xmax,0) -- cycle,lightred+opacity(0.5));
 
dot(data);
draw(data);
