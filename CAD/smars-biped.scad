// SMARS Biped Mod 
// creator:
// feet, legs, body design by RobotFreak https://www.thingiverse.com/RobotFreak
// credits: 
// SMARS modular robot https://www.thingiverse.com/thing:2662828
// servo case by tristomietitoredeituit SMARS QUAD MOD https://www.thingiverse.com/thing:2755973
// matrix ultrasound case by s4snow SMARS meets OTTO DIY https://www.thingiverse.com/thing:2818380
// 9g servo by TheCase https://www.thingiverse.com/thing:29734
// roundedCube by sembiance https://www.thingiverse.com/thing:2015341
include <roundedCube.scad> 

part = "all"; // [leg:Leg,feet:Feet,servo:Servo Cover,servo_m:Servo M Cover,all:All parts]

mode = "assembled"; // [assembled:Fully Assembled view, exploded:Explosion view,parts:Parts view]

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
module servo_case()
{
  translate([-12.5,-17,-6.3]) {   
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
}

module servo_case_m()
{
    mirror([0,1,0]) servo_case();
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
    translate([-30,-23,-11]) {
        roundedCube([60,46,height], r=8);    
        translate([30,2.4,height]) conn_diamant();
        translate([30,43.6,height]) conn_diamant();
    }
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
    translate([-7.4,6,24.3]) {
        difference() {
            rotate([90,0,0]) servo_arm();
            translate([-24,-12,4.5]) cube([50,12,15]);
            translate([-9,-12,-2]) cube([15,14,12]);
        }

        difference() {
            translate([-17,0,21.8]) rotate([0,-90,90]) servo_arm();
            translate([-37,-12,-1]) cube([15,14,50]);
        }
    }
}

module body()
{
    translate([-50,-20,-10]) {
        difference() {
            translate([0,0,0]) roundedCube([100,40,35], r=2);
            translate([2,2,2]) roundedCube([96,36,35], r=1.5);
        }
        translate([4,0,10]) rotate([0,-90,90]) conn_diamant();
        translate([45.2,0,10]) rotate([0,-90,90]) conn_diamant();
        translate([54.8,0,10]) rotate([0,-90,90]) conn_diamant();
        translate([96,0,10]) rotate([0,-90,90]) conn_diamant();
    }
}

module assembled() 
{
     // right 
    translate([0,25.5,0]) feet();
    translate([0,20,0]) rotate([0,180,-90]) servo_case_m();
    translate([7.4,20,0]) leg();
    translate([7.4,20,46]) rotate([90,0,90]) servo_case_m();
    
    // left
    translate([0,-25.5,0]) feet();
    translate([0,-20,0]) rotate([0,180,90]) servo_case();
    translate([7.4,-20,0]) leg();
    translate([7.4,-20,46]) rotate([-90,0,-90]) servo_case();
    
    // body
    translate([35,0,46]) rotate([0,0,-90]) body();
    translate([0,0,70]) matrix_ultrasound();
}

module exploded() 
{
    // right 
    translate([0,34,0]) feet();
    translate([46,39,30]) rotate([0,0,90]) servo_case();
    translate([28,57,80]) leg();
    translate([65,21,120]) rotate([90,180,90]) servo_case();
    
    // left
    translate([0,-50,0]) feet();
    translate([46,-9,30]) rotate([0,0,-90]) servo_case_m();
    translate([28,-16,80]) leg();
    translate([65,6,120]) rotate([-90,180,90]) servo_case_m();

    translate([-10,0,90])  matrix_ultrasound();
}

//biped();
//servo_case();
//servo_case_m();
//feet();
//conn_diamant();
//9g_servo();
//body();

print_part();


module print_part() {
    if (mode == "parts") {
        if (part == "leg") {
            leg();
        } else if (part == "feet") {
            feet();
        } else if (part == "servo") {
            servo_case();
        } else if (part == "servo_m") {
            servo_case_m();
        } else if (part == "all") {
            translate([0,5.5,0]) feet();
            translate([7.4,0,0]) leg();
            rotate([0,0,90]) servo_case();
            translate([7.4,0,46]) rotate([90,0,0]) servo_case_m();
        }
    }
    else if (mode == "assembled") {
		    assembled();
        }
    else if (mode == "exploded") {
            exploded();
        }
} 
