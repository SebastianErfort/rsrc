settings.outformat = "pdf";
settings.render = 0;
import three;
size(3.5cm, 0);
draw(surface(box((-1,-1),(1,1))),
surfacepen=emissive(white));
draw(unitsphere, surfacepen=white);
