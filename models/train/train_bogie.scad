use <dc_motor.scad>
use <dc_motor_mount.scad>
use <Gears.scad>

$fn=50;

buggy_width=50;
buggy_length=100;
buggy_height=50;
wall_width=10;

difference() {
  minkowski() {
    cube(size=[buggy_width, buggy_length, buggy_height], center=true);
    sphere(r=1);
  }
    // Chop off top
    translate([0, 0, buggy_height]) cube(size=[buggy_width + 10, buggy_length + 10, buggy_height+10], center=true);


  // Hollow inside
  minkowski() {
    cube(size=[buggy_width-wall_width, buggy_length-wall_width, buggy_height-wall_width+10], center=true);
    //sphere(r=1);
  }

  translate([0,0,20]) {
    cube(size=[buggy_width-wall_width+5, buggy_length-wall_width+5, 10], center=true);

    // linear_extrude(height=20) {
    //   square(size=[buggy_width-wall_width+5, buggy_length-wall_width+5], center=true);
    // }
  }

  translate([0, 30, -5]) {
    drive_axle();
  }

  translate([0, -30, -5]) {
    drive_axle();
  }
}

// Motor mount
translate([-20, 10, 15]) {
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
    cube(size=[buggy_width, 20, 15], center=true);
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

module drive_axle() {
  rotate([0, 90, 0]) {
    cylinder(r=9.5, h=70, center=true);
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