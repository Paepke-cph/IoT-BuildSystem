// change density on printer, as we do not care if roof if solid

/*
train_width
train_length
train_height
train_wall_thickness
at_center
*/
module train_lid(train_width,train_length,train_height,train_wall_thickness,at_center) {
  adjust = train_wall_thickness / 2;
  difference() {
    rotate([90,0,0])cylinder(r=65, h=250, center=at_center);
    translate([35,0,0]) cube([60,500,130], center=at_center);
  }

  translate([10,0,0]) rotate([0,90,0])cube([train_width, train_length-train_wall_thickness, 10], center=at_center);
}