# retro-compatibles

Attempts to produce some Renova compatible electrical installation items.

## Faceplates

OpenSCAD file retro-faceplates.scad exposes the following modules.

### retroKeystonePlate

2 x RJ45 faceplate with screw holes on sides.

Object shown in images was printed with 0.10 mm layer thickness, adaptive layers enabled. Infill was 60 %. 

![2 x RJ45 faceplate](img/retro2rj45Plate.jpg?raw=true "2 x RJ45 faceplate")

### retroAntennaPlate

IEC antenna faceplate. This version has a lowered plate so that connectors reach the bottom. Also includes "R" and "TV" labels like in commercial products. Issues found: Center pin is short, does not reach antenna module. Haven't compared to a commercial product.

Object shown in images was printed with 0.10 mm layer thickness, infill was 60 %. It represents an older version before clean-up. New version should be equivalent.

![Antenna faceplate 2](img/retroAntennaPlate2-1.jpg?raw=true "Antenna faceplate 2, bare module")

![Antenna faceplate 2](img/retroAntennaPlate2-2.jpg?raw=true "Antenna faceplate 2, module inserted to frame")

## Frames

OpenSCAD file retro-frames.scad exposes the following module.

### retroFrame

A round frame. Printing is not tested.

![Frame](img/frame1.png?raw=true "Round frame")

## Notes

Keystone module is implemented by https://raw.githubusercontent.com/glennswest/switchfector/master/keystone.scad. It is placed  in resources subdirectory.
