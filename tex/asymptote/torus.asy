settings.render=16;
size(10cm);
import graph3;
 
currentprojection = perspective(30*dir(75,0));  
   
real r1=5, r0=1;
int nu = 36, nv = 36;  
 
path3 crossSection = Circle(r=r0, c=(r1,0,0), normal=Y, n= nu);
surface torus = surface(crossSection, c=(0,0,0), axis=Z, n=nv); 
 
draw(torus, lightgray);  
