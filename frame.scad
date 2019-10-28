// Object: Diameter 82.5
// h=15
// sink=11
// Inner diameter = 51.9
// According to circle diam=95, perhaps a bit elliptic
$fn=60;
r=13.26;
ct=2;
lpad=1;
h=15;
sink=11;
rround=1.5;

lowerr=82.5/2;
drop=r-h;
innerr=59.1/2;
pad=0.1;

translate([28, -drop, 0])
difference()
{
        circle(r=r);
        circle(r=r-ct);
        mirror([1, 0, 0])
            square(r+lpad);
        mirror([0, 1, 0])
            square(r+lpad);
        mirror([1, 1, 0])
            square(r+lpad);
}
translate([innerr-ct+rround, h-rround, 0])
    circle(r=rround);
difference()
{
    translate([innerr-ct, h-sink, 0])
        square([ct, sink]);
    translate([innerr-ct-pad, h-rround])
        square(rround+pad);
}
square([lowerr, ct]);
