// TODO: Details when ct=1.5

$fn=180; // For fine result, use 180.
ct=1.5; // Wall thickness. Could try 2.0, too.

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

module retroFrame()
{
    rotate_extrude()
    {
        union()
        {
            inner2d();
            outer2d();
        }
    }
}

module inner2d()
{
    h=15; // Height of item
    sink=11; // Sink of "cup"
    rround=1.5; // Upper rounding radius
    lowerr=82.5/2; // Lower radius
    innerr=59.1/2; // Inner radius
    pad=0.1; // Used to maintain manifold
    lipr=1; // Radius of lip rounding
    lipt=1.5; // Lip thickness
    lipw=1.5; // Lip width

    //rotate_extrude()
    difference()
    {
        union()
        {
            // Upper rounding #2
            translate([innerr+rround, h-rround])
               sector(rround, [89,181], $fn);
            
            // Inner lift
            translate([innerr, h-sink-lipt+lipr, 0])
                square([ct, sink-rround+lipt-lipr]);

            // Inner lip
            translate([innerr-lipw, h-sink-lipt, 0])
                    square([ct+lipw-lipr, lipt]);

            // Inner lip rounding
            translate([innerr+ct-lipr, h-sink-lipt+lipr, 0])
                sector(lipr, [270, 360], $fn);
        }
        // Inner cut
        translate([lowerr-ct-0.5-pad, -pad, 0])
            square([1+pad, 1.5+pad]);
    }
}


module outer2d()
{
    h=15; // Height of item
    rround=1.5; // Upper rounding radius
    lowerr=82.5/2; // Lower radius
    innerr=59.1/2; // Inner radius
    pad=0.1; // Used to maintain manifold
    r=16.29; // Radius of side
    tr=lowerr-16.25; // Offset for side arc

    //rotate_extrude()
    difference()
    {
        union()
        {
            // Side arc
            translate([tr, 0, 0])
                arc(r, [2, 63], ct, $fn);

            // Lower block
            translate([lowerr-ct, 0, 0])
                square([ct+pad, 1]);

            // Upper rounding #1
            hull()
            {
                union()
                {
                    // Rounding
                    translate([innerr+rround, h-rround])
                       sector(rround, [40,91], $fn);
                    // Seamless with arc part
                    translate([tr, 0, 0])
                        arc(r, [62, 66], ct, $fn);
                }
            }
            // Outer cut
            translate([lowerr, -pad, 0])
                square([ct, 2+pad]);
        }
    }
}

retroFrame();