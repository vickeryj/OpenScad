include <./yapp/YAPPgenerator_v3.scad> // https://github.com/mrWheel/YAPP_Box

pcbLength      = 51.5;
pcbWidth       = 28.5;
pcbThickness   =  1.5;

lidWallHeight  = 7;
baseWallHeight = 9;

paddingFront        = 2;
paddingBack         = 2;
paddingRight        = 2;
paddingLeft         = 2;

standoffDiameter = 4.5;
standoffPinDiameter = 3;

roundRadius = 1;
wallThickness = 1.5;

snapJoins   =   
[
    [pcbLength/2, 4, yappLeft, yappRight]
    //[pcbLength -6, 5, yappLeft, yappRight]
];

standoffHeight = 9;

pcbStands = 
[
    [2.5, 2.5, yappAllCorners],
    
];

cutoutsFront =  
[
    [pcbWidth/2, 2, 12, 6, 0, yappRectangle, yappCenter]
];

cutoutsLid =  
[ 
    [pcbLength/4, pcbWidth/2, pcbLength/2, pcbWidth/2, 0, yappRectangle, yappCenter, maskHoneycomb]    
];

cutoutsBase =  
[ 
    [pcbLength/2, pcbWidth/2, pcbLength/4, pcbWidth/2, 0, yappRectangle, yappCenter, maskHoneycomb]    
];

YAPPgenerate();