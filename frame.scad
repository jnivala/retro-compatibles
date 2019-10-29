// Object: Diameter 82.5
// h=15
// sink=11
// Inner diameter = 51.9
// According to circle diam=95, perhaps a bit elliptic
$fn=180;
ct=2;
lpad=1;
h=15;
sink=11;
rround=1.5;

lowerr=82.5/2;

innerr=59.1/2;
pad=0.1;

r=14.3;
tr=25.1;

drop=r-h;

module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 24) {
    //smallpad=0.01;
    
    difference() {
        sector(radius + width, angles, fn);
        // If sector, it would flicker.
        circle(r=radius, $fn=fn);
    }
}

translate([tr, 0, 0])
    arc(r, [0, 66], 2, $fn);

//translate([tr, -drop+0.85, 0])
//difference()
//{
//        circle(r=r);
//        circle(r=r-ct);
////        mirror([1, 0, 0])
////            square(r+lpad);
//        mirror([0, 1, 0])
//            square(r+lpad);
//        mirror([1, 1, 0])
//            square(r+lpad);
//        translate([-tr, 0])
//            square([innerr+ct, 20]);
//
//}
translate([innerr+rround, h-rround, 0])
    circle(r=rround);
//difference()
//{
//    translate([innerr, h-sink, 0])
//        square([ct, sink-rround]);
////    translate([innerr-pad, h-rround])
////       square(rround+pad);
//}

translate([0, 0, 1])
    translate([innerr, h-sink, 0])
        square([ct, sink]);


//translate([0, 0, 1])
//    translate([innerr-pad, h])
//       square(rround+pad);


translate([0, 0, 1])
    square([lowerr, ct]);

//arc(r, [0, 90], 2, $fn);