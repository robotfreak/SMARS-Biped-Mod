//////////
// This is a simple plate as back cover for Raspberry Pi Zero, dimensions of plate adjustable
// This (also first) version completley written
// on 18.03.2017, Germany
// by: mabowat @ Thingiverse
// License: Creative Commons CC-BY-SA 4.0

//////////
// Version 1 minor 02: Only rearranged comments for better Thingivers customizer usage
// This version comment usage looks uglier than first upload, but should better work in customizer :-/

/* [Hidden] */
//////////
// Dimensions of Pi Zero according to https://www.raspberrypi.org/help/faqs/#generalDimensions
zero_length = 65.0;       // length 65 mm 
zero_width  = 30.0;       // width 30 mm; see above
zero_hole_dist = 3.5;     // edge distance of mounting holes of Pi Zero
zero_corner_radius = 3.0; // radius of Pi Zero's rounded edges // not used any more in this customizer version
// End of Pi Zero's Dimensions
//////////

/* [Set parameters of back cover plate] */
//////////
// Set dimensions of back cover plate here
// thinkness of back cover plate
plate_thickness = 1.5;
// additional length added at "left" side; set (e.g) to 1.0 for camera connector overhang
add_length_left = 0.0;
// additional length added at "right" side
add_length_right = 0.0;
// additional width added "above" (additional positive y-dimension)
add_width_above = 0.0;
// additional width added "below" (additional negative y-dimension)
add_width_below = 0.0;
// set to radius to 3 to match radius of rounded edges of Zero's board
corner_radius = 3.0;      

/* [Set parameters of mounts and holes] */
//////////
// Set dimensions of mounts here
// additional height of screw mounts
mount_height = 4.0;
// radius of mounts
mount_radius = 3.0;
// radius of screw holes (REDUCE, if too big for your self cutting screws!)
screw_hole_radius = 1.5;
// depth of "drilled" hole, "special options": 1. set to > mount_height to drill into plate 2. to plate_thickness + mount_height to drill through plate :-)
screw_hole_drill_depth = 5.0;
// End off seting dimensions of wanted plate and mounts
//////////

/* [Set precision / number of faces of used cylinder and rounded edges] */
//////////
// Setting precicion of cylinders; set number of faces per full cylinder;
$fn = 32;

//////////
// Calculating outer cover plate dimesions
length = zero_length + add_length_left + add_length_right;
width  = zero_width  + add_width_below + add_width_above;

//////////
// Calculating absolute positions of 4 outer mounts
// and Dimensions of mounts
mount_xa = zero_length/2 - zero_hole_dist; // Absolute x-value of mount position
mount_ya = zero_width/2 - zero_hole_dist; //          y-value
mount_h = plate_thickness + mount_height;
screw_hole_base_height = mount_h - screw_hole_drill_depth;

//////////
// Calculating dimensions of inner cube, minkowski adds 2*corner_radius
cube_length = length - 2*corner_radius; 
cube_width  = width  - 2*corner_radius;

module raspi_zero_cover() {
//////////
// Differnce of baseplate and mounts with screwholes
// This is the outer assembly of all parts
difference() {

//////////
// Union of baseplate and mounts 
// This is the assembly of all "non negative" parts
// (Difference with screw holes is done outside, to allow holes "drill" through mounts into plate)
union() {

//////////
// baseplate with rounded edges
translate([-zero_length/2+corner_radius-add_length_left,-zero_width/2+corner_radius-add_width_below,0])
minkowski()
//union()
{   // height of minkowski summed objects is added also, thus both set to half height
    cube([cube_length,cube_width,plate_thickness/2]);
    cylinder(r=corner_radius,h=plate_thickness/2);
};

//////////
// Mounts

//////////
// Set mounts
translate([        0,         0, 0]) cylinder(r=mount_radius,h=mount_h);  // Center mount
translate([-mount_xa, -mount_ya, 0]) cylinder(r=mount_radius,h=mount_h);  // 4 mounts on Zero's edges
translate([-mount_xa, +mount_ya, 0]) cylinder(r=mount_radius,h=mount_h); 
translate([+mount_xa, -mount_ya, 0]) cylinder(r=mount_radius,h=mount_h);
translate([+mount_xa, +mount_ya, 0]) cylinder(r=mount_radius,h=mount_h); 

}
// End of -> Union of baseplate and mounts 
//////////

//////////
// Generate drill holes

translate([0,0,screw_hole_base_height]) {
    // Zylinders for screw holes on Zero's edges
    translate([-mount_xa,-mount_ya,0]) cylinder(r=screw_hole_radius,h=screw_hole_drill_depth);
    translate([-mount_xa,+mount_ya,0]) cylinder(r=screw_hole_radius,h=screw_hole_drill_depth);
    translate([+mount_xa,-mount_ya,0]) cylinder(r=screw_hole_radius,h=screw_hole_drill_depth);
    translate([+mount_xa,+mount_ya,0]) cylinder(r=screw_hole_radius,h=screw_hole_drill_depth); 
};

};
};
// End of -> Union of baseplate and mounts 
//////////

