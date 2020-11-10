trainLength = 250;
trainWidth = 120;
trainHeight = 120;
wallThickness = 10;
buttomThickness = wallThickness*2;
adjust = wallThickness / 2;

// change density on printer, as we do not care if roof if solid

 difference() {
  rotate([90,0,0])cylinder(r=65, h=250, center=true);
  translate([35,0,0]) cube(size=[60,500,130], center=true);
}

translate([10,0,0]) rotate([0,90,0])cube(size=[trainWidth, trainLength-wallThickness, 10], center=true);
