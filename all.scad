// GENERAL
$fn = 64;
MAX_LENGTH = 180;
MAX_WIDTH = 180;
MAX_HEIGHT = 300;
AT_CENTER = true;
x_rot = [1,0,0];
y_rot = [0,1,0];
z_rot = [0,0,1];

// Stepper Motor
sm_width = 40;
sm_length = 43;
sm_height = sm_length;
sm_axle_length = 24;
sm_mount_hole_d = 3;
sm_mount_rails_dis = 15;

// Motor mount
mm_length = sm_length;
mm_height = sm_height;
mm_width = 5;
mm_axle_base_dim = 25;
mm_axle_base_depth = mm_width;

// Motor mount rails
mmr_length = 75;
mmr_height = 4;
mmr_top_offset = 5;

// core
core_length = MAX_LENGTH;
core_width = 12;
core_height = 60;

// Ball Baring
bb_inner_d = 6;
bb_outer_d = 19;
bb_width = 6;

module core() {
    cube([core_length,core_width,core_height], center=AT_CENTER);
}

// Parts to remove from core and mount.
module ball_baring() {
    color("red") {
        rotate(90,x_rot) {
            cylinder(d=bb_outer_d, h=bb_width,center=AT_CENTER);
        }
    }
}
module motor_mount_rail(scale) {
    color("blue") {
        rotate(90,x_rot) {
            cube([mmr_length,mmr_height*scale,core_width],center=AT_CENTER);
        }
    }
}


module ball_barings() {
    translate([-core_length/2+bb_outer_d,0,0]) {
        translate([0,bb_width/2,0])
            ball_baring();
        translate([0,-bb_width/2,0])
            ball_baring();
    }
    translate([core_length/2-bb_outer_d,0,0]){
        translate([0,bb_width/2,0])
            ball_baring();
        translate([0,-bb_width/2,0])
            ball_baring();
    }
}

module motor_mount_rails() {
    translate([((core_length/2)-(bb_outer_d*2)-(mmr_length/2))-mmr_top_offset,0,0]) {
        motor_mount_rail(2.2);
        translate([0,0,sm_mount_rails_dis]) {
            motor_mount_rail(1.0);
        }
        translate([0,0,-sm_mount_rails_dis]) {
            motor_mount_rail(1.0);
        }
    }
}

module motor_mount_holes() {
    color("blue") {
        rotate(90, x_rot) {
        translate([0,0,-mm_width/2]) {
            translate([-(mm_length/2)+6,0,0]) {
                translate([0,(mm_height/2)-6,0])
                    cylinder(d=sm_mount_hole_d, h=mm_width);
                translate([0,-(mm_height/2)+6,0])
                    cylinder(d=sm_mount_hole_d, h=mm_width);
            }
            translate([(mm_length/2)-6,0,0]) {
                translate([0,(mm_height/2)-6,0])
                    cylinder(d=sm_mount_hole_d, h=mm_width);
                translate([0,-(mm_height/2)+6,0])
                    cylinder(d=sm_mount_hole_d, h=mm_width);
                }
            }
        }
    }
}

// Final version of mount.
module core_drilled_out() {
    difference() {
        core();
        ball_barings();
        motor_mount_rails();
    }
}

// Final version of core.
module motor_mount_drill_out() {
    color("green") {
        translate([0,core_width,0]) {
            difference() {
                cube([mm_length,mm_width,mm_height], center=AT_CENTER);
                motor_mount_holes();
                rotate(90,x_rot)
                    translate([0,0,-mm_width/2])
                        cylinder(d=mm_axle_base_dim, h=mm_axle_base_depth);
            }
        }
    }
}

// Render all
core_drilled_out();
motor_mount_drill_out(); 
