use <dovetail.scad>
use <lib/dovetail.scad>
use <../dovetail.scad>
use <../lib/dovetail.scad>

$fn = 32;

Wall_Plate       = 5;     // Size of wall plate. Single decimal means
                          // thickness (z) of plate only, other measurents
                          // (x & y) are taken from size of the dovetail.
Wall_Hole        = 4;     // Diameter of mounting holes in wall plate
Wall_Hole_Sunken = yes(); // If mounting holes are sunken.

function wallPlate()      = Wall_Plate;
function wallHole()       = Wall_Hole;
function wallHoleSunken() = Wall_Hole_Sunken;
function inchToMm(i)      = (i * 25.4);

/*
 * for demo only
 */
module screw(h = 10, m = wallHole(), s = wallHoleSunken())
{
  difference() {
    union() {
      cylinder(h, r = m / 2);
      if (s) {
        cylinder(m, m, 0);
      } else {
        translate([0, 0, m / -2])
          cylinder(m / 2, r = m);
      }
    }
    if (s) {
      translate([m / -4, -m - 0.5, m / -4])
        cube([m / 2, (2 * m) + 1, m / 2]);
    } else {
      translate([m / -4, -m -0.5, (m * 3) / -4])
        cube([m / 2, (2 * m) + 1, m / 2]);
    }
  }
}
//screw();

module dovetailWallPlate(gender = dovetailGender(),
                         size   = dovetailSize(),
                         margin = dovetailMargin(),
                         plate  = wallPlate(),
                         hole   = wallHole(),
                         sunken = wallHoleSunken())
{
  p = (plate[2] == undef) ? [max(size[0], (hole * 2) + 2),
                             size[1] + (hole * 4) + 4,
                             max(plate, (sunken ? hole : 0) + 1)]
                          : [max(size[0], plate[0], (hole * 2) + 2),
                             max(size[1] + (hole * 4) + 4, plate[1]),
                             max(plate[2], (sunken ? hole : 0) + 1)];

  difference() {
    dovetailPlate(gender, size, margin, p, no());
    for (x = (p[0] < 20) ? [p[0] / 2] : [5, p[0] - 5], y = [5, p[1] - 5]) {
      translate([x, y, 0]) {
        translate([0, 0, -1]) cylinder(p[2] + 2, r = hole / 2);
        if (sunken)
          translate([0, 0, p[2] - hole]) cylinder(hole + .1, 0, hole + .1);
        //translate([0, 0, p[2]]) rotate([180]) %screw(10, hole, sunken);
      }
    }
  }
}
translate([-dovetailSize()[0] - 10, 10, 0])
  dovetailWallPlate(male(), sunken = no());
translate([10, 10, 0])
  dovetailWallPlate(male(), sunken = yes());
translate([-10, -10, 0]) rotate([0, 0, 180])
  dovetailWallPlate(female(), sunken = no());
translate([dovetailSize()[0] + 10, -10, 0]) rotate([0, 0, 180])
  dovetailWallPlate(female(), sunken = yes());
