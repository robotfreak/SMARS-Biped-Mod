include <roundedCube.scad>

part = "all"; // [leg:Leg,feet:Feet,servo:Servo Cover,servo_m:Servo M Cover,all:Comlete Biped]

mode = "exploded"; // [assembled:Fully Assembled view, exploded:Explosion view,parts:Parts view]

show_servos = "true"; // [true:yes,false:no]

module 9g_servo(){
	difference(){			
		union(){
			cube([23,12.5,22], center=true);
			translate([0,0,5]) cube([32,12,2], center=true);
			translate([5.5,0,2.75]) cylinder(r=6, h=25.75, $fn=20, center=true);
			translate([-.5,0,2.75]) cylinder(r=1, h=25.75, $fn=20, center=true);
			translate([-1,0,2.75]) cube([5,5.6,24.5], center=true);		
			translate([5.5,0,3.65]) cylinder(r=2.35, h=29.25, $fn=20, center=true);				
		}
		for ( hole = [14,-14] ){
			translate([hole,0,5]) cylinder(r=2.2, h=4, $fn=20, center=true);
		}	
	}
}
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
    if (show_servos == "true") {
        if (mode == "exploded") {
            translate([18,14.5,20.5]) rotate([90,180,0]) #9g_servo();
        }
        else {
            translate([18,14.5,7.5]) rotate([90,180,0]) #9g_servo();
        }
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

module servo_arm()
{
    import("servo-arm.stl");
}

module matrix_ultrasound() 
{
    translate([180,100,0]) rotate([0,0,90]) import("Matrix_Ultra.stl");
}
   

module leg()
{
    difference() {
        rotate([90,0,0]) servo_arm();
        translate([-24,-12,4.5]) cube([50,12,15]);
        translate([-9,-12,-2]) cube([15,12,12]);
        translate([7,-6,-2]) cylinder(d=7.5,h=10, $fn=30);
    }

    difference() {
        translate([-17,-11.8,21.8]) rotate([0,90,90]) servo_arm();
        translate([-37,-11.8,-1]) cube([15,12,50]);
    }
}


module assembled() 
{
    translate([0,4,0]) feet();
    translate([46,9,3]) rotate([0,0,90]) servo_mount();
    translate([28,27,35]) leg();
    translate([25,9,40]) rotate([90,0,90]) servo_mount();
    
    translate([0,-50,0]) feet();
    translate([46,-9,3]) rotate([0,0,-90]) servo_mount_m();
    translate([28,-16,35]) leg();
    translate([25,-9,40]) rotate([-90,0,-90]) servo_mount_m();
    
    translate([-10,0,60])  matrix_ultrasound();
}

module exploded() 
{
    translate([0,4,0]) feet();
    translate([46,9,30]) rotate([0,0,90]) servo_mount();
    translate([28,27,80]) leg();
    translate([65,9,90]) rotate([90,0,90]) servo_mount();
    
    translate([0,-50,0]) feet();
    translate([46,-9,30]) rotate([0,0,-90]) servo_mount_m();
    translate([28,-16,80]) leg();
    translate([65,-9,90]) rotate([-90,0,-90]) servo_mount_m();
}

//biped();
//servo_mount();
//servo_mount_m();
//feet();
//conn_diamant();

print_part();

module print_part() {
	if (part == "leg") {
        leg();
    } else if (part == "feet") {
        feet();
	} else if (part == "servo") {
		servo_mount();
	} else if (part == "servo_m") {
		servo_mount_m();
	} else if (part == "all") {
        if (mode == "assembled") {
		    assembled();
        }
        else if (mode == "exploded") {
            exploded();
        }
	} else {
		assembled();
	}
}