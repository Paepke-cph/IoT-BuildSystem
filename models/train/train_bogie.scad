use <dc_motor.scad>

$fn=50;

buggy_width=50;
buggy_length=100;
buggy_height=40;
wall_width=10;

difference() {
  minkowski() {
    cube(size=[buggy_width, buggy_length, 50], center=true);
    // sphere(r=1);
  }
    // Chop off top
    translate([0, 0, buggy_height]) cube(size=[buggy_width + 10, buggy_length + 10, buggy_height+10], center=true);


  // Hollow inside
  minkowski() {
    cube(size=[buggy_width-wall_width, buggy_length-wall_width, buggy_height-wall_width], center=true);
    //sphere(r=1);
  }

  translate([0,0,10]) {
    linear_extrude(height=50) {
      square(size=[buggy_width-wall_width+5, buggy_length-wall_width+5], center=true);
    }
  }
}

translate([0, 10, -10]) {
  dc_enginge_mount();
}

module dc_enginge_mount() {
  difference() {
    cube(size=[buggy_width, 20, 15], center=true);
    translate([0, -15, 5]) {
      rotate([0, 0, 90]) {
        hobby_dc_motor();
      }
    }
  }
  translate([0, -15, 5]) {
      rotate([0, 0, 90]) {
        hobby_dc_motor();
      }
    }
}