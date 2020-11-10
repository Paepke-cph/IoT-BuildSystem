include <Gears.scad>

bevel_gear_pair(modul=1, gear_teeth=30, pinion_teeth=11, axis_angle=100, tooth_width=5, gear_bore=4, pinion_bore=2, pressure_angle = 20, helix_angle=20, together_built=false);

translate([-30, 0, 40]) {
   rotate([0, 90, 0]) {
        Axel3Print(8.4, 80, 0.2);
   }
}

/*  Bevel Gear Pair with any axis_angle; uses the Module "bevel_gear"
    modul = Height of the Tooth Tip over the Partial Cone; Specification for the Outside of the Cone
    gear_teeth = Number of Gear Teeth on the Gear
    pinion_teeth = Number of Gear Teeth on the Pinion
    axis_angle = Angle between the Axles of the Gear and Pinion
    tooth_width = Width of the Teeth from the Outside toward the apex of the Cone
    gear_bore = Diameter of the Center Hole of the Gear
    pinion_bore = Diameter of the Center Bore of the Gear
    pressure_angle = Pressure Angle, Standard = 20° according to DIN 867. Should not exceed 45°.
    helix_angle = Helix Angle, Standard = 0°
    together_built = Components assembled for Construction or separated for 3D-Printing */
module bevel_gear_pair(modul, gear_teeth, pinion_teeth, axis_angle=90, tooth_width, gear_bore, pinion_bore, pressure_angle=20, helix_angle=0, together_built=true){

    // Dimension Calculations
    r_gear = modul*gear_teeth/2;                           // Cone Radius of the Gear
    delta_gear = atan(sin(axis_angle)/(pinion_teeth/gear_teeth+cos(axis_angle)));   // Cone Angle of the Gear
    delta_pinion = atan(sin(axis_angle)/(gear_teeth/pinion_teeth+cos(axis_angle)));// Cone Angle of the Pinion
    rg = r_gear/sin(delta_gear);                              // Radius of the Large Sphere
    c = modul / 6;                                          // Tip Clearance
    df_pinion = pi*rg*delta_pinion/90 - 2 * (modul + c);    // Bevel Diameter on the Large Sphere
    rf_pinion = df_pinion / 2;                              // Root Cone Radius on the Large Sphere
    delta_f_pinion = rf_pinion/(pi*rg) * 180;               // Tip Cone Angle
    rkf_pinion = rg*sin(delta_f_pinion);                    // Radius of the Cone Foot
    height_f_pinion = rg*cos(delta_f_pinion);                // Height of the Cone from the Root Cone

    echo("Cone Angle Gear = ", delta_gear);
    echo("Cone Angle Pinion = ", delta_pinion);

    df_gear = pi*rg*delta_gear/90 - 2 * (modul + c);          // Bevel Diameter on the Large Sphere
    rf_gear = df_gear / 2;                                    // Root Cone Radius on the Large Sphere
    delta_f_gear = rf_gear/(pi*rg) * 180;                     // Tip Cone Angle
    rkf_gear = rg*sin(delta_f_gear);                          // Radius of the Cone Foot
    height_f_gear = rg*cos(delta_f_gear);                      // Height of the Cone from the Root Cone

    echo("Gear Height = ", height_f_gear);
    echo("Pinion Height = ", height_f_pinion);

    rotate = is_even(pinion_teeth);

    // Drawing
    // Rad
    rotate([0,0,180*(1-clearance)/gear_teeth*rotate])
    difference() {
        bevel_gear(modul, gear_teeth, delta_gear, tooth_width, gear_bore, pressure_angle, helix_angle);
        rotate([0, 90, 0]) {
            translate([0, 0, -4]) {
                Axel3Print(9.4, 20, 0.2);
            }
        }

    }

    // Ritzel
    if (together_built)
        translate([-height_f_pinion*cos(90-axis_angle),0,height_f_gear-height_f_pinion*sin(90-axis_angle)])
            rotate([0,axis_angle,0])
                bevel_gear(modul, pinion_teeth, delta_pinion, tooth_width, pinion_bore, pressure_angle, -helix_angle);
    else
        translate([rkf_pinion*2+modul+rkf_gear,0,0])
            bevel_gear(modul, pinion_teeth, delta_pinion, tooth_width, pinion_bore, pressure_angle, -helix_angle);
 }

module Axel3Print(diameter, length, fitting)
{
    translate([0,0,(diameter*0.85-2*fitting)*0.5])
    rotate([0,90,0])
    #Axel3(diameter, length, fitting);
}

module Axel3(diameter, length, fitting)
{
    difference()
    {
        intersection()
        {
            cube([diameter*0.85-2*fitting,diameter*0.85-2*fitting,length], center=true);
            cylinder(d=diameter-2*fitting,h=length, $fn=128, center=true);
        }
        for(i=[0:3])
        {
            rotate([0,0,i*90])
            translate([0,(diameter-0.5*fitting)*0.50,0])
            cylinder(d=diameter*0.35+0.5*fitting, h=length+1, $fn=32, center=true);
        }
    }
}