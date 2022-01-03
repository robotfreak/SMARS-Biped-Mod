include <roundedCube.scad>

module servo_mount()
{
    difference() {
        union() {
            roundedCube([36,34,13.6], r=3);
            translate([-1,17,6.3]) rotate([0,90,0]) rotate([0,0,0]) cylinder(d=6.3, h=1, $fn=4);
            translate([36,17,6.3]) rotate([0,90,0]) rotate([0,0,0]) cylinder(d=6.3, h=1, $fn=4);
        }
        translate([6.2,3.2,1.6]) cube([23.5,24,12]);
        translate([6.2,0,1.6]) cube([15.5,3.5,12]);
        translate([0.7,8.0,1.6]) cube([34.6,3.2,12]);
        translate([0,25.4,11.8]) cube([13.5,8.6,2]);
        translate([2.4,29,1.6]) roundedCube([31.5,2.3,12], r=1);
        translate([31.7,23,1.6]) roundedCube([2.3,8.3,12], r=1);
        translate([31.7,23,1.6]) roundedCube([5.5,2.3,12], r=1);
        translate([2.4,19.6,1.6]) roundedCube([2.3,11.3,12], r=1);
        translate([2.4,19.6,1.6]) roundedCube([5.5,2.3,12], r=1);
        translate([11.5,34,7.4]) rotate([90,0,0]) cylinder(d=6.5, h=10, $fn=30);
    }
}

module servo_mount_m()
{
    mirror([0,1,0]) servo_mount();
}

module conn_diamant() 
{
    rotate([90,0,0]) 
    difference() { 
        union() {
            translate([0,4,0]) cube([11.5,8,4.8], center=true);
            translate([0,8,-2.4]) cylinder(h=4.8, d=11.5, $fn=30);
        }
        translate([0,8,-2.4]) cylinder(d=6.5, h=4.8, $fn=4);
    }
}

module feet(height=3)
{
    roundedCube([60,46,height], r=8);    
    translate([30,2.4,height]) conn_diamant();
    translate([30,43.6,height]) conn_diamant();
}

//servo_mount();
//servo_mount_m();
feet();
//conn_diamant();
//translate([60,17,0]) rotate([0,0,-90]) import("servo-case.stl");