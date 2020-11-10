 
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
   // Creating bottom of train, and 2 x "lady-parts" ;-)
  difference() {
  cube(size=[trainLength,trainWidth,buttomThickness], center=true);
      translate([(trainLength/2)-(buggy_length/2+0.5),0,0]){
        cylinder(h=buttomThickness+1, r1=tut_radius+1, r2=tut_radius+1, center=true);
      }
      translate([(-trainLength/2)-(-buggy_length/2+0.5),0,0]){
        cylinder(h=buttomThickness+1, r1=tut_radius+1, r2=tut_radius+1, center=true);
      }
      translate([(trainLength/2)-(buggy_length/2+0.5),0,-9]){
       rotate([180,0,0]) cylinder(h=1.2, r1=9.5, r2=9.5);
      }
       translate([(-trainLength/2)-(-buggy_length/2+0.5),0,-9]){
           rotate([180,0,0]) cylinder(h=1.2, r1=9.5, r2=9.5);
       }
      }    

   // train side 1
 translate([0, ((trainWidth/2)-adjust), trainHeight/2])
 rotate([90,0,0]) cube([trainLength,trainWidth,wallThickness], center=true);
  // train side 2
 translate([ 0,(-trainWidth/2)+adjust,trainHeight/2])
 rotate([90,0,0]) cube([trainLength,trainWidth,wallThickness], center=true);
 
  // train front
 translate([(-trainLength*0.5)+adjust,0,trainHeight/2])  
 rotate([0, 0, 90]) cube([trainWidth,wallThickness,trainHeight], center=true);
  
   // train back including holes for usb and power
   // holes are currently not correctly placed or sized
   // need arduino dimensions
 difference() {   
   translate([(trainLength/2)-adjust, 0, trainHeight/2])
        rotate([0, 0, 90]) cube([trainWidth,wallThickness,trainHeight], center=true);
      translate([(trainLength/2-6)-adjust, -2, trainHeight/2-40])
         cube([12,12,12]);
        translate([(trainLength/2-6)-adjust, -35, trainHeight/2-40])
         cube([13,13,13]);
}

}

train();