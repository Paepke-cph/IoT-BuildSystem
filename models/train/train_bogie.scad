use <dc_motor.scad>
use <dc_motor_mount.scad>
use <Gears.scad>
/*
bogie_width,
bogie_length,
bogie_height,
bogie_wall_width,
at_center
*/
module motor_bogie(bogie_width,bogie_length,bogie_height,bogie_wall_width,axel_diameter_outer,at_center, wheel_axel_distance) {
  difference() {
    minkowski() {
      cube([bogie_width, bogie_length, bogie_height], center=at_center);
      sphere(r=1);
    }
      // Chop off top
      translate([0, 0, bogie_height]) cube([bogie_width + 10, bogie_length + 10, bogie_height+10], center=at_center);

      // Hollow
      cube([bogie_width-bogie_wall_width, bogie_length-bogie_wall_width, bogie_height-bogie_wall_width+10], center=at_center);

      translate([0,0,20]) {
        cube([bogie_width-bogie_wall_width+6, bogie_length-bogie_wall_width+6, 15], center=at_center);
      }

      translate([0, wheel_axel_distance, -5]) {
        drive_axle(axel_diameter_outer);
      }

      translate([0, -wheel_axel_distance, -5]) {
        drive_axle(axel_diameter_outer);
    }
  }
}

// Motor mount
translate([-20, 10, 10]) {
  rotate([90, 90, 0]) {
    motor_mount();
  }
  //dc_enginge_mount();
}

translate([-100, 0, 0]) {
  gear_axle();
}

module dc_enginge_mount() {
  difference() {
    cube(size=[bogie_width, 20, 15], center=true);
    translate([0, -15, 5]) {
      rotate([0, 0, 90]) {
        hobby_dc_motor();
      }
    }
    translate([15, 0, 0]) {
      cylinder(r=3, h=20, center=true);
    }
    translate([-15, 0, 0]) {
      cylinder(r=3, h=20, center=true);
    }
  }

  translate([0, -15, 5]) {
      rotate([0, 0, 90]) {
        hobby_dc_motor();
      }
    }
}

module drive_axle(axel_diameter_outer) {
  rotate([0, 90, 0]) {
    cylinder(d=axel_diameter_outer, h=70, center=true);
  }

}

module screw_pole() {
  difference() {
    cube(size=[5, 5, 30], center=true);
    cylinder(r=1.5, h=45, center=true);
  }
}

module gr_1(n=0,thk=0){
    r = n*1.5;

module tooth(){
    sz = 5;
    sx = 3;
    th = thk;
    of = 5;

    hull(){
    translate([0,0,th/2])
    cube([sz,sz,th],center=true);
    translate([of,0,th/2])
    cube([sx,sx,th],center=true);}}

    for(i=[0:n]) //n is number of teeth
    rotate([0,0,i*360/n])
    translate([r,0,0])
    tooth();

    cylinder(r=r,h=thk);}

module gear(n=0,thk=0,sc=0){
    sc = sc*0.0204;
    scale(sc)
    gr_1(n=n,thk=thk);}

module gear_axle() {
  difference() {
    gear(24,15,10);
    rotate([0, 90, 0]) {
      drive_axle();
    }
  }
}