settings.outformat = "pdf";
import graph3;

path3 cs = circle(r=1.0, c=(0,0,0), normal=Y, n=20);
surface nitrogen = surface(cs, c=(0,0,0), axis=Y, n=20);
draw(nitrogen, lightblue);
