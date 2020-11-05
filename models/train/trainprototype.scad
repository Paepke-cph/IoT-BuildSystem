 
buggy_width=50;
buggy_length=100;
buggy_height=40;
wall_width=10;
square_height = 5;
lid_height = 2.4;
tut_height = 10;
tut_radius = 4;
hole_depth = 15;
$fn = 64;

trainLength = 250;
trainWidth = 120;
trainHeight = 120;
wallThickness = 10;
buttomThickness = wallThickness*2;
adjust = wallThickness / 2;

module train() {
  difference() {
  cube(size=[trainLength,trainWidth,buttomThickness], center=true);
      translate([(trainLength/2)-(buggy_length/2+0.5),0,0])
        cylinder(h=buttomThickness+1, r1=tut_radius+1, r2=tut_radius+1, center=true);
      translate([(-trainLength/2)-(-buggy_length/2+0.5),0,0])
        cylinder(h=buttomThickness+1, r1=tut_radius+1, r2=tut_radius+1, center=true);
      }     
      
 translate([0, ((trainWidth/2)-adjust), trainHeight/2])
 rotate([90,0,0]) cube([trainLength,trainWidth,wallThickness], center=true);
   
 translate([ 0,(-trainWidth/2)+adjust,trainHeight/2])
 rotate([90,0,0]) cube([trainLength,trainWidth,wallThickness], center=true);
 
 translate([(-trainLength*0.5)+adjust,0,trainHeight/2])  
 rotate([0, 0, 90]) cube([trainWidth,wallThickness,trainHeight], center=true);
  
 difference() {   
   translate([(trainLength/2)-adjust, 0, trainHeight/2])
        rotate([0, 0, 90]) cube([trainWidth,wallThickness,trainHeight], center=true);
      translate([(trainLength/2-6)-adjust, 15, trainHeight/2-40])
         cube([20,20,15]);
        translate([(trainLength/2-6)-adjust, -35, trainHeight/2-40])
         cube([20,20,15]);
}

}

train();