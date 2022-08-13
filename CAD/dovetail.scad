/*
 * Dovetail connectors
 */
Dovetail_Gender   = male();        // Gender of the connector.
Dovetail_Margin   = 0.2;           // Margin that male connector is smaller than female.
Dovetail_Size     = [46, 40, 10];  // Size of the cube the connectors are 'carved' out.
Dovetail_Plate    = 5;             // Size of a plate attached to dovetail.

// convenience functions so above constants can be used when USE-ing this file.
function female()         = true;
function male()           = false;
function yes()            = true;
function no()             = false;
function dovetailGender() = Dovetail_Gender;
function dovetailMargin() = Dovetail_Margin;
function dovetailSize()   = Dovetail_Size;
function dovetailPlate()  = Dovetail_Plate;

module dovetail(gender = dovetailGender(),
                size   = dovetailSize(),
                margin = dovetailMargin(),
                center = no())
{
  H      = (margin < 0) ? 1.999 : 2;
  M      = abs(margin) / 2;
  Xm     = size[0] / -H;
  XM     = size[0] /  H;
  Ym     = size[1] / -H;
  YM     = size[1] /  H;
  Zm     = size[2] / (gender ?  H : -H);
  ZM     = size[2] / (gender ? -H :  H);
  Y1     = (size[1] / 8) + (gender ? -M : M);
  Y2     = (size[1] / 4) + (gender ? -M : M);
  Y3     = ((size[1] * 3) / 8) + (gender ? -M : M);
  points = [[XM, YM - Y1, ZM], [XM, Ym + Y1, ZM], [XM, Ym + Y2, Zm], [XM, YM - Y2, Zm],
            [Xm, YM - Y2, ZM], [Xm, Ym + Y2, ZM], [Xm, Ym + Y3, Zm], [Xm, YM - Y3, Zm],
            [XM, YM,      ZM], [XM, YM,      Zm], [Xm, YM,      ZM], [Xm, YM,      Zm],
            [XM, Ym,      ZM], [XM, Ym,      Zm], [Xm, Ym,      ZM], [Xm, Ym,      Zm]];

  translate(center ? [0, 0, 0] : size / 2)
    if (gender) {
      // female
      polyhedron(points = points, faces  = [[0,  8,  9,  3], [ 4,  7, 11, 10],
                                            [0,  4, 10,  8], [ 3,  9, 11,  7],
                                            [0,  3,  7,  4], [ 8, 10, 11,  9]]);
      polyhedron(points = points, faces  = [[1,  2, 13, 12], [ 5, 14, 15,  6],
                                            [1, 12, 14,  5], [ 2,  6, 15, 13],
                                            [1,  5,  6,  2], [12, 13, 15, 14]]);
    } else {
      // male
      polyhedron(points = points, faces  = [[0,  3,  2,  1], [ 4,  5,  6,  7],
                                            [0,  1,  5,  4], [ 2,  3,  7,  6],
                                            [0,  4,  7,  3], [ 1,  2,  6,  5]]);
    }
}
translate([10,  10, 0])
  dovetail(male());
translate([10, -50, 0])
  dovetail(female());

module dovetailPlate(gender = dovetailGender(),
                     size   = dovetailSize(),
                     margin = dovetailMargin(),
                     plate  = dovetailPlate(),
                     center = no())
{
  if (len(plate) == undef) {
    translate(center ? [0, 0, 0] : [size[0] / 2,
                                    size[1] / 2,
                                   (size[2] + plate) / 2])
    {
      translate([0, 0, size[2] / -2])
        cube([size[0], size[1], plate], yes());
      translate([0, 0, plate / 2])
        dovetail(gender, size, margin, yes(), no());
    }
  } else {
    translate(center ? [0, 0, 0] : [max(size[0], plate[0]) / 2,
                                    max(size[1], plate[1]) / 2,
                                    (size[2] + plate[2]) / 2])
    {
      translate([0, 0, size[2] / -2])
        cube(plate, true);
      translate([0, 0, plate[2] / 2])
        dovetail(gender, size, margin, yes(), no());
    }
  }
}
translate([-56,  10, 0])
  dovetailPlate(male());
translate([-56, -50, 0])
  dovetailPlate(female());
