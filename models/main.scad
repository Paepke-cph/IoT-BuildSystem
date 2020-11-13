//* ============================================
//* IMPORTS
//* ============================================
use <IoT_E2020\BuildingSystem\WorkInProgress\Part_Generation\Gears\Gears.scad>
use <Gears.scad>
use <train\dc_motor_mount.scad>
use <train\train_bogie.scad>
use <train\train_bogie_lid.scad>
use <train\trainprototype.scad>
use <train\train_lid.scad>
use <tracks\tracks.scad>

//* ============================================
//* VARIABLEs
//* ============================================
// MODUL - MUST BE THE SAME FOR MATCHING GEARS
motor_gear_modul = 1;
wheels_and_tracks_modul = 1;

// GEARS
motor_gear_gear_teeth = 30;
motor_gear_pinion_teeth = 11;
motor_gear_axis_angle = 90;
motor_gear_tooth_width = 5;
motor_gear_gear_bore = 0;
motor_gear_pinion_bore = 2;
motor_gear_pressure_angle = 20;
motor_gear_helix_angle = 0;
motor_gear_together_built=true;

// WHEELS
wheel_modul = 1;
wheel_gear_teeth = 30;
wheel_pinion_teeth = 11;
wheel_axis_angle = 90;
wheel_tooth_width = 5;
wheel_gear_bore = 0;
wheel_pinion_bore = 2;
wheel_pressure_angle = 20;
wheel_helix_angle = 0;

// AXELS
axel_diameter = 8.4;
axel_length = 80;
axel_fitting = 0.2;

// MOTOR
motor_diameter = 25;
motor_height = 30.8;
motor_shaft_d = 7;
motor_shaft_length = 12;
motor_mount_thickness=motor_height/2;

// BOGIE
bogie_width = 50; // 60
bogie_length = 100;
bogie_height = 45; // 50
bogie_wall_width = 10;

// LID
lid_square_height = 5;
lid_height = 2.4;
lid_connector_height = 15;
lid_connector_radius_outer = 4;
lid_connector_radius_inner = 2;
lid_connector_depth = 15;

// TRAIN
train_length = 210;
train_width = 120;
train_height = 120;
train_wall_thickness = 10;
train_bottom_thickness = train_wall_thickness;


// TRACK
track_rail_helix_angle = 0.0;
track_rail_pressure_angle = 20;
track_length = 149;
track_width = 75;
track_height = 5;
track_rail_width = 5;
track_rail_height = 10;
wheel_axle_width = 70;

$fn = 64;

//* ============================================
//* RENDERING TOGGLE
//* ============================================
draw_axel = true;
draw_motor_gear = false;
draw_motor_mount = false;
draw_motor_bogie = false;
draw_bogie_lid = false;
draw_train = false;
draw_train_lid = false;
draw_tracks = false;

if(draw_axel)
{
    Axel3Print(
        axel_diameter,
        axel_length,
        axel_fitting
        );
}

if(draw_motor_gear)
{
    axel_bevel_gear_pair(
        motor_gear_modul,
        motor_gear_gear_teeth,
        motor_gear_pinion_teeth,
        motor_gear_axis_angle,
        motor_gear_tooth_width,
        motor_gear_gear_bore,
        motor_gear_pinion_bore,
        motor_gear_pressure_angle,
        motor_gear_helix_angle,
        motor_gear_together_built
        );
}

if(draw_motor_mount)
{
    motor_mount(
        motor_diameter,
        motor_height,
        motor_shaft_d,
        motor_shaft_length,
        bogie_width-10,
        bogie_height-10,
        motor_mount_thickness,
        false
        );
}

if(draw_motor_bogie)
{
    motor_bogie(
        bogie_width,
        bogie_length,
        bogie_height,
        bogie_wall_width,
        true
        );
}

if(draw_bogie_lid) 
{
    bogie_lid(
        bogie_width,
        bogie_length,
        bogie_height,
        bogie_wall_width,
        lid_square_height,
        lid_height,
        lid_connector_height,
        lid_connector_radius_outer,
        lid_connector_radius_inner,
        true
        );
    }

if(draw_train)
{
    enable_sides = false;
    train(
        bogie_width,
        bogie_length,
        bogie_height,
        bogie_wall_width,
        lid_square_height,
        lid_height,
        lid_connector_height,
        lid_connector_radius_outer,
        lid_connector_depth,
        train_width,
        train_length,
        train_height,
        train_wall_thickness,
        train_bottom_thickness,
        true,
        enable_sides
    );
}

if(draw_train_lid)
{
    train_lid(
        train_width,
        train_length,
        train_height,
        train_wall_thickness,
        true
    );
}

if(draw_tracks)
{    
    track(
        track_width,
        track_length,
        track_height,
        wheel_axle_width,
        wheels_and_tracks_modul,
        track_rail_helix_angle,
        track_rail_pressure_angle,
        track_rail_height,
        track_rail_width,
        true
    );
}