// Parametric stompbox expander (gasket)
// Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
// You can read the full licence here:
// https://creativecommons.org/licenses/by-sa/4.0/legalcode
// Churuata3D www.churuata3d.com
// Churuata3D <info@churuata3d.com>
// https://www.instagram.com/churuata3d/
// https://www.facebook.com/churuata3d

//how much space do you need?
height=5;
//screws to enclouse distance
//from 0 to 3
dist=0;
//size of your enclousure
width=119;
lenght=93.8;
//wall size's enclousure
//MUST greater than 1
wall=2;
//screws size m3, m4, etc.
sc=3;
smooth=100;
bevel=5;

module mainFrame(){
    minkowski(){
        cube([width-bevel,lenght-bevel,height],true);
        cylinder(h=height,d=bevel,$fn=smooth,center=true);
    }
}

//hole
module mainHole(){
    minkowski(){
        cube([width-wall-bevel,lenght-wall-bevel,height],true);
        cylinder(h=height,d=bevel,$fn=smooth,center=true);
    }
}

//real height hack
module mainFrameHeight(){
    //main frame
    intersection(){
        mainFrame();
        cube([width,lenght,height],true);
    }    
}

module corner(){

    difference(){

        intersection(){
            mainFrameHeight();
            translate([(width/2)-(sc-wall),lenght/2-(sc-wall),-height/2])
            cylinder(h=height,d=(sc*4)+1,$fn=smooth);
        }
            //screws hole
            translate([(width/2+0.5)-(sc)-1,lenght/2-(sc)-0.5,(-height/2)-1])
            cylinder(h=height*2,d=sc,$fn=smooth);
    }

}

//the 4 screw places
module corners(){
    corner();
    mirror([1,0,0]) corner();
    mirror([0,1,0]) corner();
    mirror([1,0,0]) mirror([0,1,0]) corner();
    
    }
    
//contru
//frame with hole
module completeFrame(){
    difference(){
        
        mainFrameHeight();
        mainHole();

    }
}

module toEnclousure(){
    difference(){
        translate([0,0,dist])
        corners();
        translate([0,0,height])
        completeFrame();

    }
}

completeFrame();
//screws place
corners();
toEnclousure();



