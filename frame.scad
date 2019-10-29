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

r=16.29;
tr=25.00;

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
        sector(radius, angles, fn);
        // If sector, it would flicker.
        circle(r=radius-width, $fn=fn);
    }
}

// Sivukaari
translate([tr, 0, 0])
    arc(r, [0, 66], 2, $fn);


// Yläpyöristys
hull()
{
translate([innerr+rround, h-rround])
difference()
{
    circle(r=rround);
    translate([-rround-pad, -rround-pad])
        square([rround*2+pad*2, rround]);
}
//Pyöristys: saumaton jatkumo kaaren kanssa.
translate([tr, 0, 1])
    arc(r, [62, 66], 2, $fn);
}

// Sisänosto
translate([0, 0, 0])
    translate([innerr, h-sink, 0])
        square([ct, sink-rround]);

translate([0, 0, 1])
    square([lowerr, ct]);
