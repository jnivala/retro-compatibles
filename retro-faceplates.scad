use <resources/keystone.scad>

$fn=180; // 180 has been used for prints.
hei=8;
totalh=9.8;
rad=51.75/2;
ct=2;
r=0.5;
pad=0.1;
lowering=4;

module retroBasicPlate()
{
    union()
    {
        rotate_extrude()
        {
            union() {
                // Face
                translate([0, hei-ct, 0])
                    square([rad-r, ct]);
                // Side vertical
                translate([rad-ct, 0])
                    square([ct, hei-r]);
                // Side rounding
                translate([rad-r, hei-r, 0])
                    circle(r);
                // Inside rounding
                translate([rad-ct-r, hei-ct-r, 0]) {
                    difference() {
                        square(r+pad);
                        circle(r=r);
                    }
                }
            }
        }
        sideTabs();
    }
}           

module retroLoweredPlate()
{
    union()
    {
        rotate_extrude()
        {
            union() {
                // Face
                translate([0, hei-ct-lowering, 0])
                    square([rad-ct+pad, ct]);
                // Side vertical part
                translate([rad-ct, 0])
                    square([ct, hei-r]);
                // Top roundings
                hull() {
                    translate([rad-ct+r, hei-r])
                        circle(r);
                    translate([rad-r, hei-r])
                        circle(r);
                }
                // Inside rounding
                translate([rad-ct-r, hei-lowering])
                    difference() {
                        translate([0, 0-pad, 0])
                            square(r+pad);
                        translate([0, r, 0])
                            circle(r);
                    }
            }
        }
        sideTabs();
    }
}

module retroAntennaPlate()
{
    antholerad = (13+1)/2;
    antholeoffset = 15;
    font="Arial";
    fontsz = 5;
    fonth = 1;
    textpad=0.1;
    
    difference()
    {
        // Base plate
        union()
        {
            retroLoweredPlate();
            shortPin();
            // Labels
            a = [
                [antholeoffset,10,0,"TV"],
                [-antholeoffset,-10,180,"R"],
                [antholeoffset,-10,180,"TV"],
                [-antholeoffset,10,0,"R"],
                ];
            
            for(i = [0 : 3])
            {
              translate([a[i][0], a[i][1], lowering-2*textpad])
                rotate([0, 0, a[i][2]])
                    linear_extrude(fonth+pad)
                        text(a[i][3], 
                            size = fontsz,
                            halign = "center", valign = "center",
                            font=font);  
            }            
        }
        // Connector holes
        for (offset = [-antholeoffset, antholeoffset]){
            translate ([offset, 0, hei-lowering-ct-pad])
                cylinder(h = ct+(pad*2), r = antholerad,
                    center = false, $fn=45);
        }
        translate([0, 0, -lowering])
            screwHole();
    }
}

module keystoneReceiverFixed()
{
    // Ensure minimum thickness to avoid thin edge in stock
    // component.
    // 
    // Erase face and bottom holes so that there is no
    // overlapping surface that flickers.
    
    pad = 0.1;
    facethick = 0.7;

    difference ()
    {
        union ()
        {
            rj45Receiver();
            // Ensure minimum thickness for face:
            translate([0, 0, 9.9-facethick])
              cube([18, 25, 0.7]);        
        }
        // Ensure top cut hole
         translate([0, 0, 9.9-facethick])
            translate([(18-14.9)/2, 2.6, -pad])
                cube([14.9, 16.25, facethick+(2*pad)]);
         translate([1.55, 2.6, -pad])
             cube([14.9, 19.44, 2*pad]);
    }
}

module keystoneFaceHole() {
    translate([(-14.9/2), -16.25/2, hei-ct])
    	cube([14.9, 16.25, ct+2*pad]);
}

module keystoneReceiverNormalized() {
    translate([-18/2, (-(22.14+2.6)/2)+1.645, -ct+pad])
        keystoneReceiverFixed();    
}

module keystoneVolumeBlockNormalized() {
    translate([-18/2, (-(22.14+2.6)/2)+1.645, -ct+pad])
        translate([1.55, 1.43, 0])
            cube([14.9, 22.14, 9.9]);
}

module retroKeystonePlate()
{
    keystoneOff = 8.35;
    screwOff = 20.75;  // Screw offset from center.
    smallpad = 0.01;
    difference()
    {
        union()
        {
            difference()
            {
                retroBasicPlate();
                for (offset = [-keystoneOff, keystoneOff])
                    translate([offset, 0, -smallpad])
                        keystoneVolumeBlockNormalized();
            }
            
              for (offset = [-keystoneOff, keystoneOff])
                    translate([offset, 0, -smallpad])
                        keystoneReceiverNormalized();
            
            for (offset = [-screwOff, screwOff])
                translate([offset, 0, 0])
                    tallPin();
        }
        for (offset = [-screwOff, screwOff])
            translate([offset, 0, 0])
                screwHole();

        for (offset = [-keystoneOff, keystoneOff])
            translate([offset, 0, -smallpad])
                keystoneFaceHole();
    }
}

module screwHole() {
    
    screwholerad = (3.7)/2;
    screwconerad = (6.5)/2;
    screwconeh = 2;
    screwconecylh = 1;
    
    translate([0, 0, hei-totalh-pad])
    {
        union() {
            // Screw hole    
            cylinder(h = totalh-screwconecylh-screwconeh+pad*2,
                r = screwholerad, center = false, $fn=9);
                                 
            // Screw cone
           translate([0, 0, totalh-screwconecylh-screwconeh+pad])
               cylinder(h = screwconeh+pad, r1 = screwholerad,
               r2 = screwconerad, center = false, $fn=12);
           // Cone top     
           translate([0, 0, totalh-screwconecylh+pad])
               cylinder(h = screwconecylh+pad,
                        r = screwconerad,
                        center = false, $fn=20);
        }
    }
}

module tallPin() {
    pinrad1 = 3; // 6/2
    pinrad2 = 3.55; // 7.1/2
    screwPinSmooth = 12;
    translate ([0, 0, -ct+2*pad]) {
        cylinder(h = totalh-ct+pad, r1 = pinrad1, r2 = pinrad2,
            center = false, $fn=screwPinSmooth);
    }
}

function line_x_at_y(x1, y1, x2, y2, y3) =
    let(k=(y2-y1)/(x2-x1))
    x1 + (y3-y1)*(1/k);

/*
 * Short pin with same cone angle as in tallPin().
 */
module shortPin() {
    y1=0;
    x1=3; // 6/2
    y2=totalh-ct+pad; // 7.9
    x2=3.55; // 7.1/2
    y3=y2-lowering;
    x3 = line_x_at_y(x1, y1, x2, y2, y3);
    
    screwPinSmooth = 12;
    difference() {
        translate ([0, 0, -ct+2*pad]) {
            cylinder(h = y3, r1 = x1, r2 = x3,
                center = false, $fn=screwPinSmooth);
        }
    }
}

module sideTabs()
{
    for (offset = [0, 90, 180, 270])
    {
        rotate([0, 0, offset])
        {
            sz = 0.6;
            translate([sz/2, rad-pad, 0])
            rotate([0, -90, 0])
            linear_extrude(sz)
            polygon([[0,0],[4,0],[2, sz+pad],[0, sz+pad],[0,0]]);
        }
    }
}

//retroAntennaPlate();
//retroKeystonePlate();
