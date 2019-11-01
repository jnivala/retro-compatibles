# retro-compatibles

Attempts to produce some Renova compatible electrical installation items.

## Faceplates

OpenSCAD file retro-faceplates.scad exposes the following modules.

### retroKeystonePlate

2 x RJ45 faceplate with screw holes on sides.

Object pictured represents a print from earlier version. The following issues have been addressed since but printing hasn't been tested:
- Keystones are placed too close to each other. Perhaps 0.5..1 mm more distance would suffice.
- There is a thin edge in the "upper part" of the keystone hole.
- There is a gap around leftmost keystone hole. Perhaps keystone cut hole was too large or misplaced.

Object shown in images was printed with 0.15 mm layer thickness due to time constraints, infill was 60 %. 

![2 x RJ45 faceplate 2](img/retro2rj45Plate2-1.jpg?raw=true "2 x RJ45 faceplate 2, module face up")

![2 x RJ45 faceplate 2](img/retro2rj45Plate2-2.jpg?raw=true "2 x RJ45 faceplate 2, module face down")

![2 x RJ45 faceplate 2](img/retro2rj45Plate2-3.jpg?raw=true "2 x RJ45 faceplate 2, module with keystones inserted, attached to box")


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
