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
motor_gear_together_built=false;

// WHEELS
train_wheel_teeth = 40;
train_wheel_width = 5;
train_wheel_bore = -40;
train_wheel_pressure_angle = 20;
train_wheel_helix_angle = 0;
train_wheel_axel_width = 70;
train_wheel_optimized = true;

// AXELS
axel_diameter = 6;
axel_length = 80;
axel_fitting = 0.2;

axel_diameter_outer = 19; // ball barings has an outer diameter of 19 -> 6x19x6

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
track_data_rail_mount_holes = 5;


$fn = 64;

//* ============================================
//* RENDERING TOGGLE
//* ============================================
draw_axel = false;
axel_translation = [0,0,0];

draw_motor_gear = true;
motor_gear_translation = [0,0,0];

draw_motor_mount = false;
motor_mount_translation = [0,0,0];

draw_motor_bogie = false;
motor_bogie_translation = [0,0,0];

draw_bogie_lid = false;
bogie_lid_translation = [0,0,0];

draw_train = false;
train_translation = [0,0,0];

draw_train_lid = false;
train_lid_translation = [0,0,0];

draw_train_wheel = false;
train_wheel_translation = [0,0,0];

draw_tracks = false;
track_translation = [0,0,0];

if(draw_axel)
{
    translate(axel_translation){
        Axel3Print(
            axel_diameter,
            axel_length,
            axel_fitting
            );
    }
    echo("Axel rendered");
}

if(draw_motor_gear)
{
    translate(motor_gear_translation) {
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
            motor_gear_together_built,
            axel_diameter,
            axel_length,
            axel_fitting
            );
    }
    echo("Bevel Gear Pair with Axel cutout rendered");
}

if(draw_motor_mount)
{
    translate(motor_mount_translation) {
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
    echo("Motor Mount rendered");
}

if(draw_motor_bogie)
{
    translate(motor_bogie_translation) {
        motor_bogie(
            bogie_width,
            bogie_length,
            bogie_height,
            bogie_wall_width,
            axel_diameter_outer,
            true
            );
    }
    echo("Motor Bogie rendered");
}

if(draw_bogie_lid) 
{
    translate(bogie_lid_translation) {
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
    echo("Bogie Lid rendered");
}

if(draw_train)
{
    enable_sides = false;
    translate(train_translation) {
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
    echo("Train rendered");
}

if(draw_train_lid)
{
    translate(train_lid_translation) {
        train_lid(
            train_width,
            train_length,
            train_height,
            train_wall_thickness,
            true
        );
    }
    echo("Train lid rendered");
}

if(draw_train_wheel) 
{
    translate(train_wheel_translation) {
        train_wheel(
            wheels_and_tracks_modul,
            train_wheel_teeth, 
            train_wheel_width, 
            train_wheel_bore, 
            train_wheel_pressure_angle, 
            train_wheel_helix_angle, 
            train_wheel_optimized,
            axel_diameter,
            axel_length,
            axel_fitting
        );
    }
    echo("Wheel rendered");
}

if(draw_tracks)
{   
    translate(track_translation) {
        track(
            track_width,
            track_length,
            track_height,
            train_wheel_axel_width,
            wheels_and_tracks_modul,
            track_rail_helix_angle,
            track_rail_pressure_angle,
            track_rail_height,
            track_rail_width,
            track_data_rail_mount_holes,
            true
        );
    }
    echo("Track rendered");
}