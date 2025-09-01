// This bundled .scad file is distributed under the GNU Lesser General Public License v3.0.
//   SPDX-License-Identifier: LGPL-3.0-or-later
//
// Although my original code is licensed under MIT, it uses portions of
// libraries that are licensed under LGPL-3. Due to limitations of certain
// platforms that only allow one .scad file per entry, I must thus
// distribute it as a bundled file that includes portions from these
// libraries, and the bundle must then be licensed under LGPL-3 as well.
//
// You must preserve all original copyright and license notices, which are
// included below in the sections for each library.
// You should have received a copy of the following licenses with this file,
// or you can view them at:
//   - MIT License:      https://opensource.org/licenses/MIT
//   - GPL v3.0 License:   https://www.gnu.org/licenses/gpl-3.0.html
//   - LGPL v3.0 License:  https://www.gnu.org/licenses/lgpl-3.0.html
//
// CODE ORIGINS & ATTRIBUTION:
//
//   - The main clamp design and structure (My Original Code):
//     Copyright (c) 2025 9600bauds
//     Licensed under the MIT License.
//
//   - Portions from the "round-anything" library:
//     Copyright (c) 2020 IrevDev
//     https://github.com/Irev-Dev/Round-Anything/
//     Licensed under the MIT License.
//
//   - Portions from the "scad-lib-FDMscrews" library:
//     Copyright (c) 2016-2017 Lukas M. Süss aka mechadense
//     https://github.com/mechadense/scad-lib-FDMscrews
//     Licensed under the GNU LGPL v3.0.

// =============================================================================
//  Parameters - Adjust these values to customize your clamp
// =============================================================================

/* [Preview Toggle] */
// Preview either the full clamp, or the denser infill region (you will get both anyways!)
part = "all"; // [all:Full Preview,dense:Denser Region,sidescrew:Side Screw,deskscrew:Desk Screw]

/* [Main Dimensions] */
//[mm]
Max_Desk_Thickness = 42; // [10:100]
// [mm] The outer diameter of the spigot for your lamp/mic/whatever.
Spigot_Diameter = 12.5; // [5:0.1:40]
// [mm] Clearance (extra empty space) for the spigot socket. Increase for looser fit. Recommended: 0.2-0-4.
Spigot_Clearance = 0.2; // [0:0.1:1]
// [mm] How deep your spigot fits into the spigot socket, from the top.
Spigot_Socket_Height = 25.25; // [10:100]
// [mm] How far into the top of the desk the top arm goes.
Top_Arm_Length = 30; // [10:100]
// [mm] How far into the underside of the desk the bottom arm goes. The sides of your desk might have reduced space on the underside.
Bottom_Arm_Length = 20; // [10:100] 

/* [Printable Desk Screw] */
// [mm] The major diameter (max, thread-end-to-thread-end) of the desk screw.
Printable_Desk_Screw_Diameter = 12; // [4:0.1:15]
// [mm] The length of the desk screw's thread. If 0, will auto-calculate.
Printable_Desk_Screw_Thread_Length = 0; // [0:90]

/* [Metal Desk Screw Override] */
// Enable to override the printable desk screw with sockets for you to provide your own metal screw and hexnut.
Enable_Metal_Desk_Screw_Override = "false"; // [false,true]
// [mm] The major diameter (max, thread-end-to-thread-end) of the desk screw.
Metal_Desk_Screw_Diameter = 12; // [4:0.1:15]
// [mm] The flat-to-flat distance of the desk hex nut.
Desk_Hex_Nut_Size = 12.5; // [5:0.1:25]
// [mm] The thickness of the desk hex nut.
Desk_Hex_Nut_Thickness = 6.75; // [2:0.1:15] 
// [mm] The thickness of the inner wall that holds the desk hex nut. Todo better name
Desk_Hex_Nut_Support_Wall_Thickness = 1.2;

/* [Printable Side Screw] */
// [mm] How far down into the spigot socket the center of the side screw will be. If 0, will automatically center to half of the spigot socket.
Printable_Side_Screw_Offset = 0; // [0:50]
// [mm] The major diameter (max, thread-end-to-thread-end) of the side screw.
Printable_Side_Screw_Diameter = 8; // [3:0.1:10]
// [mm] The length of the side screw's thread. If 0, will auto-calculate.
Printable_Side_Screw_Thread_Length = 0; // [0:35]

/* [Metal Side Screw Override] */
// Enable to override the printable side screw with sockets for you to provide your own metal screw and hexnut.
Enable_Metal_Side_Screw_Override = "false"; // [false,true]
// [mm] How far down into the spigot socket the center of the side screw will be. If 0, will automatically center to half of the spigot socket.
Metal_Side_Screw_Offset = 0; // [0:50]
// [mm] The major diameter (max, thread-end-to-thread-end) of the side screw.
Metal_Side_Screw_Diameter = 8; // [3:0.1:10]
// [mm] The flat-to-flat distance of the side hex nut.
Side_Hex_Nut_Size = 7.9; // [2:0.1:15]
// [mm] The thickness of the side hex nut.
Side_Hex_Nut_Thickness = 3.25; // [1:0.1:10]

/* [Cosmetics] */
//[deg] Angle of the side taper.
Taper_Angle = 15; // [0:45]
//[mm] The fillet radius of the top arm corners.
Top_Fillet_Radius = 6; // [0:0.5:20]
//Todo
Top_Chamfer_Radius = 1; // [0:0.5:3]
//[mm] The fillet radius of the bottom arm corners.
Bottom_Fillet_Radius = 6; // [0:0.5:20] 
//Todo
Bottom_Chamfer_Radius = 1; // [0:0.5:3]
Desk_Screw_Cap_Diameter = 16; // [5:0.1:30] [mm] The diameter of the screw cap.
Desk_Screw_Cap_Thickness = 4; // [2:0.1:10] [mm] The thickness of the screw cap.

/* [Support And Thickness] */
// [mm] Wall thickness of the shell around the lamp spigot (thicker = sturdier but bigger).
Spigot_Shell_Thickness = 5; // [2:0.5:15]
// [mm] Thickness of the interior infill shell around some parts.
Extra_Interior_Infill_Thickness = 3;
// [mm] Thickness of the side wall connecting the top and bottom arms.
Middle_Wall_Thickness = 9; // [2:0.5:15]
// [mm] Extra thickness on the top arm. Probably unnecessary.
Extra_Top_Arm_Thickness = 0;
// [mm] Extra thickness on the bottom arm. Might be desirable if you're using a thick metal nut.
Extra_Bottom_Arm_Thickness = 0;

/* [Clearances And Quality] */
Hex_Nut_Clearance = 0.4; // [0:0.1:2] [mm] Clearance (extra empty space) for hex nuts. Might be hard to fit the nut if set too low.
Epsilon = 0.1; // [0.01:0.01:1] [mm] Extra margin for cut-throughs.
$fn = 16; // [16:128] Number of facets for curves. Higher is smoother.
fnBeam = 8; // [8:64] Number of facets for the interior reinforcement beam.
screwFm = 16;

/* [Rendering options] */
Debug_Mode = true; // Checkbox

/* [Hidden] */
Printable_Screw_Pitch = 3.6;
Printable_Screw_Profile_Depth = 1.5;
// =============================================================================
//  Derived Variables
// =============================================================================
function value_or_default(value_to_check, default_value) =
  value_to_check != 0 ? value_to_check : default_value;

middle_wall_height = Max_Desk_Thickness + Desk_Screw_Cap_Thickness;
top_thickness = Middle_Wall_Thickness + Extra_Top_Arm_Thickness;
bottom_thickness = Middle_Wall_Thickness + Extra_Bottom_Arm_Thickness;
total_height = top_thickness + middle_wall_height + bottom_thickness;
spigot_socket_diameter = Spigot_Diameter + Spigot_Clearance;
back_cylinder_diameter = spigot_socket_diameter + Spigot_Shell_Thickness * 2;
extra_inner_offset = Middle_Wall_Thickness - Spigot_Shell_Thickness;

real_desk_screw_diameter =
  Enable_Metal_Desk_Screw_Override == "true" ?
    Metal_Desk_Screw_Diameter :
    Printable_Desk_Screw_Diameter;
real_desk_screw_thread_length =
  value_or_default(
    Printable_Desk_Screw_Thread_Length,
    bottom_thickness + middle_wall_height / 1.5 - Desk_Screw_Cap_Thickness / 2
  );

real_side_screw_offset =
  Enable_Metal_Side_Screw_Override == "true" ?
    value_or_default(Printable_Side_Screw_Offset, Spigot_Socket_Height / 2) :
    value_or_default(Printable_Side_Screw_Offset, Spigot_Socket_Height / 2);
real_side_screw_diameter =
  Enable_Metal_Side_Screw_Override == "true" ?
    Metal_Side_Screw_Diameter :
    Printable_Side_Screw_Diameter;
real_side_screw_thread_length =
  value_or_default(
    Printable_Side_Screw_Thread_Length,
    Spigot_Shell_Thickness + spigot_socket_diameter / 2
  );

// =============================================================================
//  Sanity Checks & Warnings
// =============================================================================

/*// Check if the side screw is logically placed
assert(
  real_side_screw_offset + Side_Screw_Diameter / 2 <= Spigot_Socket_Height,
  str("ERROR: Side screw offset (", Side_Screw_Offset, ") is too low for the spigot socket (length: ", Spigot_Socket_Height, "). The screw will not engage with the spigot. Increase Spigot_Socket_Height or decrease Side_Screw_Offset.")
);
assert(
  real_side_screw_offset >= (Side_Screw_Diameter / 2) + 1.5,
  str("WARNING: Side screw offset (", real_side_screw_offset, ") is very close to the top surface. There may not be enough material above the nut for strength.")
);
if(Desk_Screw_Type == "Metal") assert(
  real_side_screw_offset >= (Side_Hex_Nut_Size / 2) + 1.2,
  str("WARNING: Side screw offset (", real_side_screw_offset, ") is too close to the top surface. There may not be enough material above the nut for strength.")
);*/

// Check if the bottom arm is long enough for the screw/screw nut
/*assert(
  Bottom_Arm_Length > Desk_Screw_Diameter,
  str("ERROR: Bottom arm length (", Bottom_Arm_Length, ") is not enough to fit the desk screw (diameter: ", Desk_Screw_Diameter, "). Increase Bottom_Arm_Length, or decrease Desk_Screw_Diameter (not recommended).")
);
if(Desk_Screw_Type == "Metal") assert(
  Bottom_Arm_Length > Desk_Hex_Nut_Size,
  str("ERROR: Bottom arm length (", Bottom_Arm_Length, ") is not enough to fit the desk hex nut (diameter: ", Desk_Hex_Nut_Size, "). Increase Bottom_Arm_Length, or decrease Desk_Hex_Nut_Size (not recommended).")
);*/

/*// Check if the screw cap fits
assert(
  Bottom_Arm_Length >= Desk_Screw_Cap_Diameter,
  str("ERROR: Bottom arm length (", Bottom_Arm_Length, ") is not enough to fit the screw cap (diameter: ", Desk_Screw_Cap_Diameter, "). Increase Bottom_Arm_Length, or decrease Desk_Screw_Cap_Diameter.")
);
assert(
  Desk_Screw_Cap_Diameter > Desk_Screw_Diameter + 0.4,
  str("ERROR: Screw cap (diameter: ", Desk_Screw_Cap_Diameter, ") is not wide enough for the actual screw (diameter: ", Desk_Screw_Diameter, "). Increase Desk_Screw_Cap_Diameter, or decrease Desk_Screw_Diameter (not recommended).")
);*/

// Check if the printable screws are of a sensical diameter
if(Enable_Metal_Desk_Screw_Override == "false"){
  sensical_desk_screw_diameter = Printable_Screw_Profile_Depth * 2 + 5;
  assert(
    Printable_Desk_Screw_Diameter >= sensical_desk_screw_diameter,
    str("ERROR: Desk screw (diameter: ", Printable_Desk_Screw_Diameter, ") is too small for a printable screw. A minimum of ", sensical_desk_screw_diameter, " is necessary. Please increase the desired diameter.")
  );
}
if(Enable_Metal_Side_Screw_Override == "false"){
  sensical_side_screw_diameter = Printable_Screw_Profile_Depth * 2 + 2.5;
  assert(
    Printable_Side_Screw_Diameter >= sensical_side_screw_diameter,
    str("ERROR: Side screw (diameter: ", Printable_Side_Screw_Diameter, ") is too small for a printable screw. A minimum of ", sensical_side_screw_diameter, " is necessary. Please increase the desired diameter.")
  );
}


// =============================================================================
//  Helper Modules
// =============================================================================

module rounded_triangle(big_diameter, small_diameter, Taper_Angle, flat_face_dist) {
  R = big_diameter / 2;
  r = small_diameter / 2;

  // The geometry is a large circle at the origin and two smaller circles
  // tangent to a vertical line and the two sides of the taper.

  // Slope of the tapered sides
  m = tan(Taper_Angle / 2);
  // Secant of the half-angle, used to find the y-intercept of the tangent line
  S = sqrt(1 + m * m);

  // The front flat face is a vertical line at x = R + flat_dist
  x_flat = R + flat_face_dist;
  // Center of the small rounding circle, which is tangent to the front face
  cx = x_flat - r;

  // Derived from the condition that the sloped line y = m*x + c must be
  // tangent to both the large circle (at origin) and the small circle (at [cx, cy]).
  cy = m * cx + (R - r) * S;

  hull() {
    translate([0, 0]) circle(r=R);
    translate([cx, cy]) circle(r=r);
    translate([cx, -cy]) circle(r=r);
  }
}

module crop_sides(){
    difference(){
      children();
      rotate([0, 0, 90 + Taper_Angle / 2])
        translate([back_cylinder_diameter / 2 - 0.1, -999/2, -999/2])
            cube(999);
      rotate([0, 0, 90 - Taper_Angle / 2])
        translate([-999 -back_cylinder_diameter / 2 + 0.1, -999/2, -999/2])
            cube(999);
    };
}

module chamfered_extrude(height, bottom_radius, top_radius) {
    hull() {
      translate([0,0,0]) // pointless but kept for legibility
        linear_extrude(height=bottom_radius)
          offset(r=-bottom_radius)  // shrink profile to "loft" the round
            children();

      translate([0,0,bottom_radius])
        linear_extrude(height=height - bottom_radius - top_radius)
          children();

      translate([0,0,height-top_radius])
        linear_extrude(height=top_radius)
          offset(r=-top_radius)  // shrink profile to "loft" the round
            children();
    }
}

module hex_pocket(size, thickness, tol = Hex_Nut_Clearance) {
  r = (size / 2) / cos(30); // Apothecary to radius conversion for hexagon
  translate([0, 0, -Epsilon])
    cylinder(h=thickness + 2 * Epsilon, r=r + tol, $fn=6);
}
module smooth_hole(d, h, clearance = Epsilon) {
  translate([0, 0, -clearance])
    cylinder(h=h + 2 * clearance, d=d);
}
module metal_screw_hole(d, h, clearance = Epsilon) {
  translate([0, 0, -clearance])
    cylinder(h=h + 2 * clearance, d=d);
}
module fdm_screw_hole(d, h, clearance = Epsilon) {
  translate([0, 0, -clearance])
    screwByPitch(pitch=Printable_Screw_Pitch, length=h + 2 * clearance, d0=d, 
    dr=Printable_Screw_Profile_Depth, chamfer1=false, chamfer2=false, circum_resol=screwFm, axial_resol=screwFm);
}

module flatScrewWithHandle(l = 32, d = 12)
{
  c = 1.0; // chamfersize
  lthreadless = 5;
  lhandle = 6;
  whandle = 20;

  intersection()
  {
    union()
    {
      screwByPitch(pitch=Printable_Screw_Pitch, length=l, d0=d, dr=1.5, chamfer1=false, chamfer2=true, circum_resol=screwFm, axial_resol=screwFm);
      scale([1,1,-1]) cylinder(r=d/2,h=lthreadless+lhandle/2,center=false);
    }
    cube([d*0.6,999,999],center=true);
  }
  translate([0,0,-lhandle/2-lthreadless])
    b3cube(d*0.6,whandle,lhandle,c,c,c);
}

// =============================================================================
//  Offsets (all of these start from 0, 0)
// =============================================================================
module go_to_spigot_center() {
  translate([0, 0, total_height])
    rotate([0, 180, 0])
      children();
}
module go_to_bottom_arm_center() {
  bottom_arm_center = (spigot_socket_diameter / 2) + Middle_Wall_Thickness + Bottom_Arm_Length / 2;
  translate([bottom_arm_center, 0, 0])
    children();
}
module go_to_side_screw_center() {
  translate([(back_cylinder_diameter / -2), 0, total_height - real_side_screw_offset])
    rotate([0, 90, 0])
      children();
}
module align_clamp_to_print_bed() {
  translate([0, 0, (back_cylinder_diameter / 2) * cos(Taper_Angle / 2)])
    rotate([-(90), -Taper_Angle / 2, 0])
      children();
}

// =============================================================================
//  Clamp Solid Body Components
// =============================================================================

module middle_outline() rounded_triangle(back_cylinder_diameter, Epsilon, Taper_Angle, 0);
module bottom_outline() hull(){rounded_triangle(back_cylinder_diameter, Bottom_Fillet_Radius, Taper_Angle, Bottom_Arm_Length + extra_inner_offset); middle_outline();};
module top_arm_outline() hull(){rounded_triangle(back_cylinder_diameter, Top_Fillet_Radius, Taper_Angle, Top_Arm_Length + extra_inner_offset); middle_outline();}

module top_arm_solid() {
    translate([0, 0, total_height - top_thickness])
      linear_extrude(height = top_thickness)
        top_arm_outline();
}

module bottom_arm_solid() {
    linear_extrude(height = bottom_thickness)
      bottom_outline();
}

module middle_section_solid() {
    union(){
        chamfered_extrude(height=total_height, bottom_radius = Bottom_Chamfer_Radius, top_radius = Top_Chamfer_Radius)
          middle_outline();
        ibeam(999);
    }
}

module clamp_body() {
  crop_sides()
  union() {
    top_arm_solid();
    bottom_arm_solid();
    middle_section_solid();
  }
}


// =============================================================================
//  Screws
// =============================================================================

module printable_side_screw(){
  flatScrewWithHandle(l=real_side_screw_thread_length, d=real_side_screw_diameter);
}

module printable_desk_screw(){
  flatScrewWithHandle(l=real_desk_screw_thread_length, d=real_desk_screw_diameter);
}

module desk_screw_cap() {
  cylinder(d=Desk_Screw_Cap_Diameter, h=Desk_Screw_Cap_Thickness);
}

// =============================================================================
//  Clamp Cutout Components
// =============================================================================
module cutouts(offset = 0) {
  // Hole for the spigot
  go_to_spigot_center()
    smooth_hole(d=spigot_socket_diameter + offset, h=Spigot_Socket_Height + offset);
  // Desk screw + hex socket in the bottom arm
  go_to_bottom_arm_center() { 
    if(Enable_Metal_Desk_Screw_Override == "true") {
      metal_screw_hole(d=real_desk_screw_diameter + offset, h=bottom_thickness + offset);
      translate([0, 0, Desk_Hex_Nut_Support_Wall_Thickness - offset])
      hex_pocket(size=Desk_Hex_Nut_Size + offset, thickness=Desk_Hex_Nut_Thickness + offset);
    }
    else {
      fdm_screw_hole(d=real_desk_screw_diameter + offset, h=bottom_thickness + offset);
    }
  }
  // Side screw + hex socket at the back
  go_to_side_screw_center() {
    if(Enable_Metal_Side_Screw_Override == "true") {
      metal_screw_hole(d=real_side_screw_diameter + offset, h=back_cylinder_diameter / 2 + offset);
      hex_pocket(size=Side_Hex_Nut_Size + offset, thickness=Side_Hex_Nut_Thickness + offset);
    }
    else { 
      fdm_screw_hole(d=real_side_screw_diameter + offset, h=back_cylinder_diameter / 2 + offset);
    }
  }
}

// =============================================================================
//  Support Beam
// =============================================================================
beam_thickness = Middle_Wall_Thickness;
beam_width = spigot_socket_diameter;     
flange_thickness = beam_thickness / 3;
top_bend_radius = beam_thickness / 3;
bottom_end_radius = beam_thickness / 3;

hb = beam_thickness / 2;
support_minx = spigot_socket_diameter / 2 + beam_thickness;
support_maxx = support_minx + Bottom_Arm_Length;;
support_miny = bottom_thickness;
support_maxy = total_height - beam_thickness;

tbonePath = [    
    [support_maxx, support_maxy, 0],
    [support_minx - top_bend_radius, support_maxy, top_bend_radius],
    [support_minx - top_bend_radius, support_maxy - top_bend_radius, top_bend_radius],
    [support_minx, support_maxy - top_bend_radius, top_bend_radius],
    [support_minx, support_miny + bottom_end_radius, bottom_end_radius],
    [support_minx - bottom_end_radius, support_miny + bottom_end_radius, bottom_end_radius],
    [support_minx - bottom_end_radius, support_miny, bottom_end_radius],
    [support_maxx, support_miny, 0]  
];
cPath = [
    [support_maxx, support_maxy, 0],
    [support_minx, support_maxy, top_bend_radius],
    [support_minx, support_miny, bottom_end_radius],
    [support_maxx, support_miny, 0]  
];
pathUsed = tbonePath;

//inner_flange_path = polyRound(beamChain(tbonePath, 0, -flange_thickness), fnBeam);

module full_beam_outline() polygon(polyRound(beamChain(pathUsed, 0, -beam_thickness), fnBeam)); 
module outer_flange_outline() polygon(polyRound(beamChain(pathUsed, - beam_thickness + flange_thickness, -beam_thickness), fnBeam));
module inner_flange_outline() polygon(polyRound(beamChain(pathUsed, 0, -flange_thickness), fnBeam));
    
module fullbeam(width) linear_extrude(width) full_beam_outline();
module outerFlange(width) linear_extrude(width) outer_flange_outline();
module innerFlange(width) linear_extrude(width) inner_flange_outline();
module middleWeb(width) translate([0, 0, width/3]) linear_extrude(width/3) full_beam_outline();

module gussets(width){
    module topGussetClippingArea(){
        translate([support_minx + beam_thickness + top_bend_radius / 4, support_maxy - beam_thickness - top_bend_radius / 4, -999/2])
            rotate([0,0,90])
                cube([999, 999, 999]);
    }
    module bottomGussetClippingArea(){
        translate([support_minx + beam_thickness + bottom_end_radius / 4, support_miny + beam_thickness + bottom_end_radius / 4, -999/2])
            rotate([0,0,180])
                cube([999, 999, 999]);
    }
    intersection(){
        fullbeam(width);
        union(){
            topGussetClippingArea();
            bottomGussetClippingArea();
        }
    }
}
    
module ibeam(width){
    rotate([(90), 0, 0])
        translate([0, 0, -width/2])
            union(){
                color("grey") middleWeb(width);
                color("green") outerFlange(width);
                color("pink") innerFlange(width);
                color("black") gussets(width);

                if (Debug_Mode) {
                  // --- DEBUG: Draw the centerline path in cyan ---
                  centerline = beamChain(tbonePath, offset1=0, offset2=-1);
                  color("cyan") polygon(polyRound(centerline, fnBeam));
                  // --- DEBUG: Draw the abstract path in magenta ---
                  for(p = tbonePath) {
                    translate([p[0], p[1], 0]) color("magenta") circle(r=0.5);
                  }
                }
            }
}

// =============================================================================
//  Main Assembly
// =============================================================================
module denseGeometry(){
    intersection(){
        fullGeometry();
        union(){
            cutouts(Extra_Interior_Infill_Thickness);
            ibeam(beam_width);
        }
    }
    
}
module fullGeometry(){
    if (Debug_Mode) {
      // Render the main body with the '%' modifier.
      // This makes it transparent in the preview, like an x-ray.
      %difference() {
        %clamp_body();
        %cutouts();
      }
      // Render the cutouts in solid red.
      //color("red") cutouts();
      // Render the support in solid black.
      ibeam(beam_width);
      // Render the conceptual screw cap in solid blue.
      //translate([bottom_arm_center, 0, real_desk_screw_thread_length])
      //  color("blue") desk_screw_cap();
      /*if(Enable_Metal_Side_Screw_Override == "false") { 
        go_to_side_screw_center() translate([0, 0, -Epsilon])
          color("purple") printable_side_screw();
      }
      if(Enable_Metal_Desk_Screw_Override == "false") {
        go_to_bottom_arm_center() translate([0, 0, -Epsilon])
          color("purple") printable_desk_screw();
      }*/
    } else {
          difference() {
            clamp_body();
            cutouts();
          }
    }
}
    if (part == "all") {
      align_clamp_to_print_bed()
          fullGeometry();
    } else if (part == "dense") {
      align_clamp_to_print_bed()
          denseGeometry();
    } else if (part == "sidescrew") {
      rotate([0, 90, 0])
        translate([-Side_Screw_Diameter * 0.3, 0, 0])
          printable_side_screw();
    } else if (part == "deskscrew") {
      rotate([0, 90, 0])
        translate([-Desk_Screw_Diameter * 0.3, 0, 0])
          printable_desk_screw();
    }

// =============================================================================
//  The rest of this file is external libraries.
//  They must be included in this .scad file rather than imported externally,
//  due to limitations of certain platforms that only allow one .scad file per entry.
// =============================================================================

// Library: round-anything
// Version: 1.0
// Author: IrevDev
// Contributors: TLC123
// Copyright: 2020
// License: MIT

function addZcoord(points,displacement)=[for(i=[0:len(points)-1])[points[i].x,points[i].y, displacement]];
function translate3Dcoords(points,tran=[0,0,0],mult=[1,1,1])=[for(i=[0:len(points)-1])[
  (points[i].x*mult.x)+tran.x,
  (points[i].y*mult.y)+tran.y,
  (points[i].z*mult.z)+tran.z
]];
function offsetPolygonPoints(points, offset=0)=
// Work sthe same as the offset does, except for the fact that instead of a 2d shape
// It works directly on polygon points
// It returns the same number of points just offset into or, away from the original shape.
// points= a series of x,y points[[x1,y1],[x2,y2],...]
// offset= amount to offset by, negative numbers go inwards into the shape, positive numbers go out
// return= a series of x,y points[[x1,y1],[x2,y2],...]
let(
  isCWorCCW=sign(offset)*CWorCCW(points)*-1,
  lp=len(points)
)
[for(i=[0:lp-1]) parallelFollow([
  points[listWrap(i-1,lp)],
  points[i],
  points[listWrap(i+1,lp)],
],thick=offset,mode=isCWorCCW)];

function reverseList(list) = [ for(i=[len(list) - 1:-1:0]) list[i] ];

// Apply `reverseList` to the array of vertex indices for an array of faces
function invertFaces(faces) = [ for(f=faces) reverseList(f) ];

function makeCurvedPartOfPolyHedron(radiiPoints,r,fn,minR=0.01)=
// this is a private function that I'm not expecting library users to use directly
// radiiPoints= serise of x, y, r points
// r= radius of curve that will be put on the end of the extrusion
// fn= amount of subdivisions
// minR= if one of the points in radiiPoints is less than r, it's likely to converge and form a sharp edge,
//     the min radius on these converged edges can be controled with minR, though because of legacy reasons it can't be 0, but can be a very small number.
// return= array of [polyhedronPoints, Polyhedronfaces, theLength of a singe layer in the curve]
let(
  lp=len(radiiPoints),
  radii=[for(i=[0:lp-1])radiiPoints[i].z],
  isCWorCCWOverall=CWorCCW(radiiPoints),
  dir=sign(r),
  absR=abs(r),
  fractionOffLp=1-1/fn,
  allPoints=[for(fraction=[0:1/fn:1])
    let(
      iterationOffset=dir*sqrt(sq(absR)-sq(fraction*absR))-dir*absR,
      theOffsetPoints=offsetPolygonPoints(radiiPoints,iterationOffset),
      polyRoundOffsetPoints=[for(i=[0:lp-1])
        let(
          pointsAboutCurrent=[
            theOffsetPoints[listWrap(i-1,lp)],
            theOffsetPoints[i],
            theOffsetPoints[listWrap(i+1,lp)]
          ],
          isCWorCCWLocal=CWorCCW(pointsAboutCurrent),
          isInternalRadius=(isCWorCCWLocal*isCWorCCWOverall)==-1,
          // the radius names are only true for positive r,
          // when are r is negative increasingRadius is actually decreasing and vice-vs
          // increasingRadiusWithPositiveR is just to verbose of a variable name for my liking
          increasingRadius=max(radii[i]-iterationOffset, minR),
          decreasingRadius=max(radii[i]+iterationOffset, minR)
        )
        [theOffsetPoints[i].x, theOffsetPoints[i].y, isInternalRadius? increasingRadius: decreasingRadius]
      ],
      pointsForThisLayer=polyRound(polyRoundOffsetPoints,fn)
    )
    addZcoord(pointsForThisLayer,fraction*absR)
  ],
  polyhedronPoints=flatternArray(allPoints),
  allLp=len(allPoints),
  layerLength=len(allPoints[0]),
  loopToSecondLastLayer=allLp-2,
  sideFaces=[for(layerIndex=[0:loopToSecondLastLayer])let(
    currentLayeroffset=layerIndex*layerLength,
    nextLayeroffset=(layerIndex+1)*layerLength,
    layerFaces=[for(subLayerIndex=[0:layerLength-1])
      [
        currentLayeroffset+subLayerIndex, currentLayeroffset + listWrap(subLayerIndex+1,layerLength), nextLayeroffset+listWrap(subLayerIndex+1,layerLength), nextLayeroffset+subLayerIndex]
    ]
  )layerFaces],
  polyhedronFaces=flatternArray(sideFaces)
)
[polyhedronPoints, polyhedronFaces, layerLength];

function flatternRecursion(array, init=[], currentIndex=0)=
// this is a private function, init and currentIndex are for the function's use 
// only for when it's calling itself, which is why there is a simplified version flatternArray that just calls this one
// array= array to flattern by one level of nesting
// init= the array used to cancat with the next call, only for when the function calls itself
// currentIndex= so the function can keep track of how far it's progressed through the array, only for when it's calling itself
// returns= flatterned array, by one level of nesting
let(
  shouldKickOffRecursion=currentIndex==undef?1:0,
  isLastIndex=currentIndex+1==len(array)?1:0,
  flatArray=shouldKickOffRecursion?flatternRecursion(array,[],0):
    isLastIndex?concat(init,array[currentIndex]):
    flatternRecursion(array,concat(init,array[currentIndex]),currentIndex+1)
)
flatArray;

function flatternArray(array)=
// public version of flatternRecursion, has simplified params to avoid confusion
// array= array to be flatterned
// return= array that been flatterend by one level of nesting
flatternRecursion(array);

function offsetAllFacesBy(array,offset)=[
  // polyhedron faces are simply a list of indices to points, if your concat points together than you probably need to offset
  // your faces array to points to the right place in the new list
  // array= array of point indicies
  // offset= number to offset all indecies by
  // return= array of point indices (i.e. faces) with offset applied
  for(faceIndex=[0:len(array)-1])[
    for(pointIndex=[0:len(array[faceIndex])-1])array[faceIndex][pointIndex]+offset
  ]
];

function extrudePolygonWithRadius(radiiPoints,h=5,r1=1,r2=1,fn=4)=
// this basically calls makeCurvedPartOfPolyHedron twice to get the curved section of the final polyhedron
// and then goes about assmbling them, as the side faces and the top and bottom face caps are missing
// radiiPoints= series of [x,y,r] points,
// h= height of the extrude (total including radius sections)
// r1,r2= define the radius at the top and bottom of the extrud respectively, negative number flange out the extrude
// fn= number of subdivisions
// returns= [polyhedronPoints, polyhedronFaces]
let(
  // top is the top curved part of the extrude
  top=makeCurvedPartOfPolyHedron(radiiPoints,r1,fn),
  topRadiusPoints=translate3Dcoords(top[0],[0,0,h-abs(r1)]),
  singeLayerLength=top[2],
  topRadiusFaces=top[1],
  radiusPointsLength=len(topRadiusPoints), // is the same length as bottomRadiusPoints
  // bottom is the bottom curved part of the extrude
  bottom=makeCurvedPartOfPolyHedron(radiiPoints,r2,fn),
  // Z axis needs to be multiplied by -1 to flip it so the radius is going in the right direction [1,1,-1]
  bottomRadiusPoints=translate3Dcoords(bottom[0],[0,0,abs(r2)],[1,1,-1]),
  // becaues the points will be all concatenated into the same array, and the bottom points come second, than
  // the original indices the faces are points towards are wrong and need to have an offset applied to them
  bottomRadiusFaces=offsetAllFacesBy(bottom[1],radiusPointsLength),
  // all of the side panel of the extrusion, connecting points from the inner layers of each
  // of the curved sections
  sideFaces=[for(i=[0:singeLayerLength-1])[
    i,
    listWrap(i+1,singeLayerLength),
    radiusPointsLength + listWrap(i+1,singeLayerLength),
    radiusPointsLength + i
  ]],
  // both of these caps are simple every point from the last layer of the radius points
  topCapFace=[for(i=[0:singeLayerLength-1])radiusPointsLength-singeLayerLength+i],
  bottomCapFace=[for(i=[0:singeLayerLength-1])radiusPointsLength*2-singeLayerLength+i],
  finalPolyhedronPoints=concat(topRadiusPoints,bottomRadiusPoints),
  finalPolyhedronFaces=concat(topRadiusFaces,invertFaces(bottomRadiusFaces),invertFaces(sideFaces),[topCapFace],invertFaces([bottomCapFace]))
)
[
  finalPolyhedronPoints,
  finalPolyhedronFaces
];

module polyRoundExtrude(radiiPoints,length=5,r1=1,r2=1,fn=10,convexity=10) {
  assert(len(radiiPoints) > 2, str("There must be at least 3 radii points for polyRoundExtrude. ", radiiPoints, " is not long enough, you need ", 3 - len(radiiPoints), " more point/s. Example: polyRoundExtrude([[11,0,1],[20,20,1.1],[8,7,0.5]],2,0.5,-0.8,fn=8);"));
  if(len(radiiPoints) > 2) {
    orderedRadiiPoints = CWorCCW(radiiPoints) == 1
      ? reverseList(radiiPoints)
      : radiiPoints;

    polyhedronPointsNFaces=extrudePolygonWithRadius(orderedRadiiPoints,length,r1,r2,fn);
    polyhedron(points=polyhedronPointsNFaces[0], faces=polyhedronPointsNFaces[1], convexity=convexity);
  }
}


// testingInternals();
module testingInternals(){
  //example of rounding random points, this has no current use but is a good demonstration
  random=[for(i=[0:20])[rnd(0,50),rnd(0,50),/*rnd(0,30)*/1000]];
  R =polyRound(random,7);
  translate([-25,25,0]){
    polyline(R);
  }
  
  //example of different modes of the CentreN2PointsArc() function 0=shortest arc, 1=longest arc, 2=CW, 3=CCW
  p1=[0,5];p2=[10,5];centre=[5,0];
  translate([60,0,0]){
    color("green"){
      polygon(CentreN2PointsArc(p1,p2,centre,0,20));//draws the shortest arc
    }
    color("cyan"){
      polygon(CentreN2PointsArc(p1,p2,centre,1,20));//draws the longest arc
    }
  }
  translate([75,0,0]){
    color("purple"){
      polygon(CentreN2PointsArc(p1,p2,centre,2,20));//draws the arc CW (which happens to be the short arc)
    }
    color("red"){
      polygon(CentreN2PointsArc(p2,p1,centre,2,20));//draws the arc CW but p1 and p2 swapped order resulting in the long arc being drawn
    }
  }
  
  radius=6;
  radiipoints=[[0,0,0],[10,20,radius],[20,0,0]];
  tangentsNcen=round3points(radiipoints);
  translate([10,0,0]){
    for(i=[0:2]){
      color("red")translate(getpoints(radiipoints)[i])circle(1);//plots the 3 input points
      color("cyan")translate(tangentsNcen[i])circle(1);//plots the two tangent poins and the circle centre
    }
    translate([tangentsNcen[2][0],tangentsNcen[2][1],-0.2])circle(r=radius,$fn=25);//draws the cirle
    %polygon(getpoints(radiipoints));//draws a polygon
  }
}

function polyRound(radiipoints,fn=5,mode=0)=
  /*Takes a list of radii points of the format [x,y,radius] and rounds each point
    with fn resolution
    mode=0 - automatic radius limiting - DEFAULT
    mode=1 - Debug, output radius reduction for automatic radius limiting
    mode=2 - No radius limiting*/
  let(
    p=getpoints(radiipoints), //make list of coordinates without radii
    Lp=len(p),
    //remove the middle point of any three colinear points, otherwise adding a radius to the middle of a straigh line causes problems
    radiiPointsWithoutTrippleColinear=[
      for(i=[0:len(p)-1]) if(
        // keep point if it isn't colinear or if the radius is 0
        !isColinear(
          p[listWrap(i-1,Lp)],
          p[listWrap(i+0,Lp)],
          p[listWrap(i+1,Lp)]
        )||
        p[listWrap(i+0,Lp)].z!=0
      ) radiipoints[listWrap(i+0,Lp)] 
    ],
    newrp2=processRadiiPoints(radiiPointsWithoutTrippleColinear),
    plusMinusPointRange=mode==2?1:2,
    temp=[
      for(i=[0:len(newrp2)-1]) //for each point in the radii array
      let(
        thepoints=[for(j=[-plusMinusPointRange:plusMinusPointRange])newrp2[listWrap(i+j,len(newrp2))]],//collect 5 radii points
        temp2=mode==2?round3points(thepoints,fn):round5points(thepoints,fn,mode)
      )
      mode==1?temp2:newrp2[i][2]==0?
        [[newrp2[i][0],newrp2[i][1]]]: //return the original point if the radius is 0
        CentreN2PointsArc(temp2[0],temp2[1],temp2[2],0,fn) //return the arc if everything is normal
    ]
  )
  [for (a = temp) for (b = a) b];//flattern and return the array

function round5points(rp,fn,debug=0)=
	rp[2][2]==0&&debug==0?[[rp[2][0],rp[2][1]]]://return the middle point if the radius is 0
	rp[2][2]==0&&debug==1?0://if debug is enabled and the radius is 0 return 0
	let(
    p=getpoints(rp), //get list of points
    r=[for(i=[1:3]) abs(rp[i][2])],//get the centre 3 radii
    //start by determining what the radius should be at point 3
    //find angles at points 2 , 3 and 4
    a2=cosineRuleAngle(p[0],p[1],p[2]),
    a3=cosineRuleAngle(p[1],p[2],p[3]),
    a4=cosineRuleAngle(p[2],p[3],p[4]),
    //find the distance between points 2&3 and between points 3&4
    d23=pointDist(p[1],p[2]),
    d34=pointDist(p[2],p[3]),
    //find the radius factors
    F23=(d23*tan(a2/2)*tan(a3/2))/(r[0]*tan(a3/2)+r[1]*tan(a2/2)),
    F34=(d34*tan(a3/2)*tan(a4/2))/(r[1]*tan(a4/2)+r[2]*tan(a3/2)),
    newR=min(r[1],F23*r[1],F34*r[1]),//use the smallest radius
    //now that the radius has been determined, find tangent points and circle centre
    tangD=newR/tan(a3/2),//distance to the tangent point from p3
      circD=newR/sin(a3/2),//distance to the circle centre from p3
    //find the angle from the p3
    an23=getAngle(p[1],p[2]),//angle from point 3 to 2
    an34=getAngle(p[3],p[2]),//angle from point 3 to 4
    //find tangent points
    t23=[p[2][0]-cos(an23)*tangD,p[2][1]-sin(an23)*tangD],//tangent point between points 2&3
    t34=[p[2][0]-cos(an34)*tangD,p[2][1]-sin(an34)*tangD],//tangent point between points 3&4
    //find circle centre
    tmid=getMidpoint(t23,t34),//midpoint between the two tangent points
    anCen=getAngle(tmid,p[2]),//angle from point 3 to circle centre
    cen=[p[2][0]-cos(anCen)*circD,p[2][1]-sin(anCen)*circD]
  )
    //circle center by offseting from point 3
    //determine the direction of rotation
	debug==1?//if debug in disabled return arc (default)
    (newR-r[1]):
	[t23,t34,cen];

function round3points(rp,fn)=
  rp[1][2]==0?[[rp[1][0],rp[1][1]]]://return the middle point if the radius is 0
	let(
    p=getpoints(rp), //get list of points
	  r=rp[1][2],//get the centre 3 radii
    ang=cosineRuleAngle(p[0],p[1],p[2]),//angle between the lines
    //now that the radius has been determined, find tangent points and circle centre
	  tangD=r/tan(ang/2),//distance to the tangent point from p2
    circD=r/sin(ang/2),//distance to the circle centre from p2
    //find the angles from the p2 with respect to the postitive x axis
    angleFromPoint1ToPoint2=getAngle(p[0],p[1]),
    angleFromPoint2ToPoint3=getAngle(p[2],p[1]),
    //find tangent points
    t12=[p[1][0]-cos(angleFromPoint1ToPoint2)*tangD,p[1][1]-sin(angleFromPoint1ToPoint2)*tangD],//tangent point between points 1&2
    t23=[p[1][0]-cos(angleFromPoint2ToPoint3)*tangD,p[1][1]-sin(angleFromPoint2ToPoint3)*tangD],//tangent point between points 2&3
    //find circle centre
    tmid=getMidpoint(t12,t23),//midpoint between the two tangent points
    angCen=getAngle(tmid,p[1]),//angle from point 2 to circle centre
    cen=[p[1][0]-cos(angCen)*circD,p[1][1]-sin(angCen)*circD] //circle center by offseting from point 2 
  )
	[t12,t23,cen];

function parallelFollow(rp,thick=4,minR=1,mode=1)=
    //rp[1][2]==0?[rp[1][0],rp[1][1],0]://return the middle point if the radius is 0
    thick==0?[rp[1][0],rp[1][1],0]://return the middle point if the radius is 0
	let(
    p=getpoints(rp), //get list of points
	  r=thick,//get the centre 3 radii
    ang=cosineRuleAngle(p[0],p[1],p[2]),//angle between the lines
    //now that the radius has been determined, find tangent points and circle centre
    tangD=r/tan(ang/2),//distance to the tangent point from p2
  	sgn=CWorCCW(rp),//rotation of the three points cw or ccw?let(sgn=mode==0?1:-1)
    circD=mode*sgn*r/sin(ang/2),//distance to the circle centre from p2
    //find the angles from the p2 with respect to the postitive x axis
    angleFromPoint1ToPoint2=getAngle(p[0],p[1]),
    angleFromPoint2ToPoint3=getAngle(p[2],p[1]),
    //find tangent points
    t12=[p[1][0]-cos(angleFromPoint1ToPoint2)*tangD,p[1][1]-sin(angleFromPoint1ToPoint2)*tangD],//tangent point between points 1&2
	  t23=[p[1][0]-cos(angleFromPoint2ToPoint3)*tangD,p[1][1]-sin(angleFromPoint2ToPoint3)*tangD],//tangent point between points 2&3
    //find circle centre
    tmid=getMidpoint(t12,t23),//midpoint between the two tangent points
    angCen=getAngle(tmid,p[1]),//angle from point 2 to circle centre
    cen=[p[1][0]-cos(angCen)*circD,p[1][1]-sin(angCen)*circD],//circle center by offseting from point 2 
    outR=max(minR,rp[1][2]-thick*sgn*mode) //ensures radii are never too small.
  )
	concat(cen,outR);

function is90or270(ang)=ang==90?1:ang==270?1:0;

function findPoint(ang1,refpoint1,ang2,refpoint2,r=0)=
// finds the intersection of two lines given two angles and points on those lines
  let(
    overrideX=is90or270(ang1)?
      refpoint1.x:
      is90or270(ang2)?
      refpoint2.x:
      0,
    m1=tan(ang1),
    c1=refpoint1.y-m1*refpoint1.x,
	  m2=tan(ang2),
    c2=refpoint2.y-m2*refpoint2.x,
    outputX=overrideX?overrideX:(c2-c1)/(m1-m2),
    outputY=is90or270(ang1)?m2*outputX+c2:m1*outputX+c1
  )
	[outputX,outputY,r];

function beamChain(radiiPoints,offset1=0,offset2,mode=0,minR=0,startAngle,endAngle)= 
  /*This function takes a series of radii points and plots points to run along side at a consistant distance, think of it as offset but for line instead of a polygon
  radiiPoints=radii points,
  offset1 & offset2= The two offsets that give the beam it's thickness. When using with mode=2 only offset1 is needed as there is no return path for the polygon
  minR=min radius, if all of your radii are set properly within the radii points this value can be ignored
  startAngle & endAngle= Angle at each end of the beam, different mode determine if this angle is relative to the ending legs of the beam or absolute.
  mode=1 - include endpoints startAngle&2 are relative to the angle of the last two points and equal 90deg if not defined
  mode=2 - Only the forward path is defined, useful for combining the beam with other radii points, see examples for a use-case.
  mode=3 - include endpoints startAngle&2 are absolute from the x axis and are 0 if not defined
  negative radiuses only allowed for the first and last radii points
  
  As it stands this function could probably be tidied a lot, but it works, I'll tidy later*/
  let(
    offset2undef=offset2==undef?1:0,
    offset2=offset2undef==1?0:offset2,
    CWorCCW1=sign(offset1)*CWorCCW(radiiPoints),
    CWorCCW2=sign(offset2)*CWorCCW(radiiPoints),
    offset1=abs(offset1),
    offset2b=abs(offset2),
    Lrp3=len(radiiPoints)-3,
    Lrp=len(radiiPoints),
    startAngle=mode==0&&startAngle==undef?
      getAngle(radiiPoints[0],radiiPoints[1])+90:
      mode==2&&startAngle==undef?
      0:
      mode==0?
      getAngle(radiiPoints[0],radiiPoints[1])+startAngle:
      startAngle,
    endAngle=mode==0&&endAngle==undef?
            getAngle(radiiPoints[Lrp-1],radiiPoints[Lrp-2])+90:
        mode==2&&endAngle==undef?
            0:
        mode==0?
            getAngle(radiiPoints[Lrp-1],radiiPoints[Lrp-2])+endAngle:
            endAngle,
    OffLn1=[for(i=[0:Lrp3]) offset1==0?radiiPoints[i+1]:parallelFollow([radiiPoints[i],radiiPoints[i+1],radiiPoints[i+2]],offset1,minR,mode=CWorCCW1)],
    OffLn2=[for(i=[0:Lrp3]) offset2==0?radiiPoints[i+1]:parallelFollow([radiiPoints[i],radiiPoints[i+1],radiiPoints[i+2]],offset2b,minR,mode=CWorCCW2)],

    Rp1=abs(radiiPoints[0].z),
    Rp2=abs(radiiPoints[Lrp-1].z),
    
    endP1aAngle = getAngle(radiiPoints[0],radiiPoints[1]),
    endP1a=findPoint(endP1aAngle,         OffLn1[0],              startAngle,radiiPoints[0],     Rp1),

    endP1bAngle = getAngle(radiiPoints[Lrp-1],radiiPoints[Lrp-2]),
    endP1b=findPoint(endP1bAngle, OffLn1[len(OffLn1)-1],  endAngle,radiiPoints[Lrp-1], Rp2),

    endP2aAngle = getAngle(radiiPoints[0],radiiPoints[1]),
    endP2a=findPoint(endP2aAngle,         OffLn2[0],              startAngle,radiiPoints[0],     Rp1),

    endP2bAngle = getAngle(radiiPoints[Lrp-1],radiiPoints[Lrp-2]),
    endP2b=findPoint(endP2bAngle, OffLn2[len(OffLn1)-1],  endAngle,radiiPoints[Lrp-1], Rp2),

    absEnda=getAngle(endP1a,endP2a),
    absEndb=getAngle(endP1b,endP2b),
    negRP1a=[cos(absEnda)*radiiPoints[0].z*10+endP1a.x,        sin(absEnda)*radiiPoints[0].z*10+endP1a.y,       0.0],
    negRP2a=[cos(absEnda)*-radiiPoints[0].z*10+endP2a.x,       sin(absEnda)*-radiiPoints[0].z*10+endP2a.y,      0.0],
    negRP1b=[cos(absEndb)*radiiPoints[Lrp-1].z*10+endP1b.x,    sin(absEndb)*radiiPoints[Lrp-1].z*10+endP1b.y,   0.0],
    negRP2b=[cos(absEndb)*-radiiPoints[Lrp-1].z*10+endP2b.x,   sin(absEndb)*-radiiPoints[Lrp-1].z*10+endP2b.y,  0.0],
    OffLn1b=(mode==0||mode==2)&&radiiPoints[0].z<0&&radiiPoints[Lrp-1].z<0?
        concat([negRP1a],[endP1a],OffLn1,[endP1b],[negRP1b])
      :(mode==0||mode==2)&&radiiPoints[0].z<0?
        concat([negRP1a],[endP1a],OffLn1,[endP1b])
      :(mode==0||mode==2)&&radiiPoints[Lrp-1].z<0?
        concat([endP1a],OffLn1,[endP1b],[negRP1b])
      :mode==0||mode==2?
        concat([endP1a],OffLn1,[endP1b])
      :
        OffLn1,
    OffLn2b=(mode==0||mode==2)&&radiiPoints[0].z<0&&radiiPoints[Lrp-1].z<0?
        concat([negRP2a],[endP2a],OffLn2,[endP2b],[negRP2b])
      :(mode==0||mode==2)&&radiiPoints[0].z<0?
        concat([negRP2a],[endP2a],OffLn2,[endP2b])
      :(mode==0||mode==2)&&radiiPoints[Lrp-1].z<0?
        concat([endP2a],OffLn2,[endP2b],[negRP2b])
      :mode==0||mode==2?
        concat([endP2a],OffLn2,[endP2b])
      :
        OffLn2
    )//end of let()
  offset2undef==1?OffLn1b:concat(OffLn2b,revList(OffLn1b));
    
function revList(list)=//reverse list
  let(Llist=len(list)-1)
  [for(i=[0:Llist]) list[Llist-i]];

function CWorCCW(p)=
	let(
    Lp=len(p),
	  e=[for(i=[0:Lp-1]) 
      (p[listWrap(i+0,Lp)].x-p[listWrap(i+1,Lp)].x)*(p[listWrap(i+0,Lp)].y+p[listWrap(i+1,Lp)].y)
    ]
  )  
  sign(polySum(e));

function CentreN2PointsArc(p1,p2,cen,mode=0,fn)=
  /* This function plots an arc from p1 to p2 with fn increments using the cen as the centre of the arc.
  the mode determines how the arc is plotted
  mode==0, shortest arc possible 
  mode==1, longest arc possible
  mode==2, plotted clockwise
  mode==3, plotted counter clockwise
  */
	let(
    isCWorCCW=CWorCCW([cen,p1,p2]),//determine the direction of rotation
    //determine the arc angle depending on the mode
    p1p2Angle=cosineRuleAngle(p2,cen,p1),
    arcAngle=
      mode==0?p1p2Angle:
      mode==1?p1p2Angle-360:
      mode==2&&isCWorCCW==-1?p1p2Angle:
      mode==2&&isCWorCCW== 1?p1p2Angle-360:
      mode==3&&isCWorCCW== 1?p1p2Angle:
      mode==3&&isCWorCCW==-1?p1p2Angle-360:
      cosineRuleAngle(p2,cen,p1),
    r=pointDist(p1,cen),//determine the radius
	  p1Angle=getAngle(cen,p1) //angle of line 1
  )
  [for(i=[0:fn])
  let(angleIncrement=(arcAngle/fn)*i*isCWorCCW)
  [cos(p1Angle+angleIncrement)*r+cen.x,sin(p1Angle+angleIncrement)*r+cen.y]];

function translateRadiiPoints(radiiPoints,tran=[0,0],rot=0)=
	[for(i=radiiPoints) 
		let(
      a=getAngle([0,0],[i.x,i.y]),//get the angle of the this point
		  h=pointDist([0,0],[i.x,i.y]) //get the hypotenuse/radius
    )
		[h*cos(a+rot)+tran.x,h*sin(a+rot)+tran.y,i.z]//calculate the point's new position
	];

module round2d(OR=3,IR=1){
  offset(OR,$fn=100){
    offset(-IR-OR,$fn=100){
      offset(IR,$fn=100){
        children();
      }
    }
  }
}

module shell2d(offset1,offset2=0,minOR=0,minIR=0){
	difference(){
		round2d(minOR,minIR){
      offset(max(offset1,offset2)){
        children(0);//original 1st child forms the outside of the shell
      }
    }
		round2d(minIR,minOR){
      difference(){//round the inside cutout
        offset(min(offset1,offset2)){
          children(0);//shrink the 1st child to form the inside of the shell 
        }
        if($children>1){
          for(i=[1:$children-1]){
            children(i);//second child and onwards is used to add material to inside of the shell
          }
        }
      }
		}
	}
}

module internalSq(size,r,center=0){
    tran=center==1?[0,0]:size/2;
    translate(tran){
      square(size,true);
      offs=sin(45)*r;
      for(i=[-1,1],j=[-1,1]){
        translate([(size.x/2-offs)*i,(size.y/2-offs)*j])circle(r);
      }
    }
}

module extrudeWithRadius(length,r1=0,r2=0,fn=30){
  n1=sign(r1);n2=sign(r2);
  r1=abs(r1);r2=abs(r2);
  translate([0,0,r1]){
    linear_extrude(length-r1-r2){
      children();
    }
  }
  for(i=[0:fn-1]){
    translate([0,0,i/fn*r1]){
      linear_extrude(r1/fn+0.01){
        offset(n1*sqrt(sq(r1)-sq(r1-i/fn*r1))-n1*r1){
          children();
        }
      }
    }
    translate([0,0,length-r2+i/fn*r2]){
      linear_extrude(r2/fn+0.01){
        offset(n2*sqrt(sq(r2)-sq(i/fn*r2))-n2*r2){
          children();
        }
      }
    }
  }
}

function mirrorPoints(radiiPoints,rot=0,endAttenuation=[0,0])= //mirrors a list of points about Y, ignoring the first and last points and returning them in reverse order for use with polygon or polyRound
  let(
    a=translateRadiiPoints(radiiPoints,[0,0],-rot),
    temp3=[for(i=[0+endAttenuation[0]:len(a)-1-endAttenuation[1]])
      [a[i][0],-a[i][1],a[i][2]]
    ],
    temp=translateRadiiPoints(temp3,[0,0],rot),
    temp2=revList(temp3)
  )    
  concat(radiiPoints,temp2);

function processRadiiPoints(rp)=
  [for(i=[0:len(rp)-1])
    processRadiiPoints2(rp,i)
  ];

function processRadiiPoints2(list,end=0,idx=0,result=0)=
  idx>=end+1?result:
  processRadiiPoints2(list,end,idx+1,relationalRadiiPoints(result,list[idx]));

function cosineRuleBside(a,c,C)=c*cos(C)-sqrt(sq(a)+sq(c)+sq(cos(C))-sq(c));

function absArelR(po,pn)=
  let(
    th2=atan(po[1]/po[0]),
    r2=sqrt(sq(po[0])+sq(po[1])),
    r3=cosineRuleBside(r2,pn[1],th2-pn[0])
  )
  [cos(pn[0])*r3,sin(pn[0])*r3,pn[2]];

function relationalRadiiPoints(po,pi)=
  let(
    p0=pi[0],
    p1=pi[1],
    p2=pi[2],
    pv0=pi[3][0],
    pv1=pi[3][1],
    pt0=pi[3][2],
    pt1=pi[3][3],
    pn=
      (pv0=="y"&&pv1=="x")||(pv0=="r"&&pv1=="a")||(pv0=="y"&&pv1=="a")||(pv0=="x"&&pv1=="a")||(pv0=="y"&&pv1=="r")||(pv0=="x"&&pv1=="r")?
        [p1,p0,p2,concat(pv1,pv0,pt1,pt0)]:
        [p0,p1,p2,concat(pv0,pv1,pt0,pt1)],
    n0=pn[0],
    n1=pn[1],
    n2=pn[2],
    nv0=pn[3][0],
    nv1=pn[3][1],
    nt0=pn[3][2],
    nt1=pn[3][3],
    temp=
      pn[0]=="l"?
        [po[0],pn[1],pn[2]]
      :pn[1]=="l"?
        [pn[0],po[1],pn[2]]
      :nv0==undef?
        [pn[0],pn[1],pn[2]]//abs x, abs y as default when undefined
      :nv0=="a"?
        nv1=="r"?
          nt0=="a"?
            nt1=="a"||nt1==undef?
              [cos(n0)*n1,sin(n0)*n1,n2]//abs angle, abs radius
            :absArelR(po,pn)//abs angle rel radius
          :nt1=="r"||nt1==undef?
            [po[0]+cos(pn[0])*pn[1],po[1]+sin(pn[0])*pn[1],pn[2]]//rel angle, rel radius 
          :[pn[0],pn[1],pn[2]]//rel angle, abs radius
        :nv1=="x"?
          nt0=="a"?
            nt1=="a"||nt1==undef?
              [pn[1],pn[1]*tan(pn[0]),pn[2]]//abs angle, abs x
            :[po[0]+pn[1],(po[0]+pn[1])*tan(pn[0]),pn[2]]//abs angle rel x
            :nt1=="r"||nt1==undef?
              [po[0]+pn[1],po[1]+pn[1]*tan(pn[0]),pn[2]]//rel angle, rel x 
            :[pn[1],po[1]+(pn[1]-po[0])*tan(pn[0]),pn[2]]//rel angle, abs x
          :nt0=="a"?
            nt1=="a"||nt1==undef?
              [pn[1]/tan(pn[0]),pn[1],pn[2]]//abs angle, abs y
            :[(po[1]+pn[1])/tan(pn[0]),po[1]+pn[1],pn[2]]//abs angle rel y
          :nt1=="r"||nt1==undef?
            [po[0]+(pn[1]-po[0])/tan(90-pn[0]),po[1]+pn[1],pn[2]]//rel angle, rel y 
          :[po[0]+(pn[1]-po[1])/tan(pn[0]),pn[1],pn[2]]//rel angle, abs y
      :nv0=="r"?
        nv1=="x"?
          nt0=="a"?
            nt1=="a"||nt1==undef?
              [pn[1],sign(pn[0])*sqrt(sq(pn[0])-sq(pn[1])),pn[2]]//abs radius, abs x
            :[po[0]+pn[1],sign(pn[0])*sqrt(sq(pn[0])-sq(po[0]+pn[1])),pn[2]]//abs radius rel x
          :nt1=="r"||nt1==undef?
            [po[0]+pn[1],po[1]+sign(pn[0])*sqrt(sq(pn[0])-sq(pn[1])),pn[2]]//rel radius, rel x 
          :[pn[1],po[1]+sign(pn[0])*sqrt(sq(pn[0])-sq(pn[1]-po[0])),pn[2]]//rel radius, abs x
        :nt0=="a"?
          nt1=="a"||nt1==undef?
            [sign(pn[0])*sqrt(sq(pn[0])-sq(pn[1])),pn[1],pn[2]]//abs radius, abs y
          :[sign(pn[0])*sqrt(sq(pn[0])-sq(po[1]+pn[1])),po[1]+pn[1],pn[2]]//abs radius rel y
        :nt1=="r"||nt1==undef?
          [po[0]+sign(pn[0])*sqrt(sq(pn[0])-sq(pn[1])),po[1]+pn[1],pn[2]]//rel radius, rel y 
        :[po[0]+sign(pn[0])*sqrt(sq(pn[0])-sq(pn[1]-po[1])),pn[1],pn[2]]//rel radius, abs y
      :nt0=="a"?
        nt1=="a"||nt1==undef?
          [pn[0],pn[1],pn[2]]//abs x, abs y
        :[pn[0],po[1]+pn[1],pn[2]]//abs x rel y
      :nt1=="r"||nt1==undef?
        [po[0]+pn[0],po[1]+pn[1],pn[2]]//rel x, rel y 
      :[po[0]+pn[0],pn[1],pn[2]]//rel x, abs y
  )
  temp;

function invtan(run,rise)=
  let(a=abs(atan(rise/run)))
  rise==0&&run>0?
    0:rise>0&&run>0?
    a:rise>0&&run==0?
    90:rise>0&&run<0?
    180-a:rise==0&&run<0?
    180:rise<0&&run<0?
    a+180:rise<0&&run==0?
    270:rise<0&&run>0?
    360-a:"error";

function cosineRuleAngle(p1,p2,p3)=
  let(
    p12=abs(pointDist(p1,p2)),
    p13=abs(pointDist(p1,p3)),
    p23=abs(pointDist(p2,p3))
  )
  acos((sq(p23)+sq(p12)-sq(p13))/(2*p23*p12));

function polySum(list, idx = 0, result = 0) = 
	idx >= len(list) ? result : polySum(list, idx + 1, result + list[idx]);

function sq(x)=x*x;
function getGradient(p1,p2)=(p2.y-p1.y)/(p2.x-p1.x);
function getAngle(p1,p2)=p1==p2?0:invtan(p2[0]-p1[0],p2[1]-p1[1]);
function getMidpoint(p1,p2)=[(p1[0]+p2[0])/2,(p1[1]+p2[1])/2]; //returns the midpoint of two points
function pointDist(p1,p2)=sqrt(abs(sq(p1[0]-p2[0])+sq(p1[1]-p2[1]))); //returns the distance between two points
function isColinear(p1,p2,p3)=getGradient(p1,p2)==getGradient(p2,p3)?1:0;//return 1 if 3 points are colinear
module polyline(p, width=0.3) {
  for(i=[0:max(0,len(p)-1)]){
    color([i*1/len(p),1-i*1/len(p),0,0.5])line(p[i],p[listWrap(i+1,len(p) )],width);
  }
} // polyline plotter
module line(p1, p2 ,width=0.3) { // single line plotter
  hull() {
    translate(p1){
      circle(width);
    }
    translate(p2){
      circle(width);
    }
  }
}

function getpoints(p)=[for(i=[0:len(p)-1])[p[i].x,p[i].y]];// gets [x,y]list of[x,y,r]list
function listWrap(x,x_max=1,x_min=0) = (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min; // wraps numbers inside boundaries
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
    (rands(min(a, b), max(   a, b), 1)[0]):(rands(min(a, b), max(a, b), 1, s)[0]); // nice rands wrapper 

// =============================================================================
//  scad-lib-FDMscrews
// =============================================================================

/*
Date: 2016-07-23 ... 2017-12-13
Author: Lukas M. Süss aka mechadense
Name: basic-screw-profiles
License: Public Domain
*/


// ####################################
// ------------------------------------ PROFILE MODIFIERS
  
  // All profiles are supposed be properly defined in the bounding box: [[-1,-1],[+1,+1]] -- covering the whole range [[_,-1],[_,+1]]

  // These triangular and saw waveforms (of period length 1) are tools 
  // to make non-periodic functions periodic

  function trirepeater0(x) = abs(((x*2+1)%2)-1)*2-1; // 0:1(=maximum) periodlength:1
  // f(-1/2)=1 linear-down f(0)=-1 linear-up f(+1/2)=1

  function sawrepeater1(x) = x-floor(x); // (can be used as profile)
  // f(0)=0 linear-up f(1)=1 jump-down
  
  
  // ####### profile amplitudes must be between 0 and 1 reaching both ##### !!!
  // "crop01(x)" can be used to cull the profile function to these limits
  function crop01(x) = min(1,max(0,x));


// ####################################
// ------------------------------------ PROFILES
  // you may add more profiles here ... (plus corresponding entries at §§ locations)

  // simple sinusodial
  function profile_sinusodial(x) = (1-cos(x))/2; // thread profile

  // rectangular
  function profile_rectangular(x) = (sign(sin(x))+1)/2;

  // simple triangular (linear) (kinks make speed steps make acceleration spikes)
  function profile_triangular(x) = abs(((x/360*2+1)%2)-1);
    // triangular //abs(((x+1)%2)-1)

  // simple cubical:
  // squarewavejerk is designed such 
  // that when the printer nozzle is moved along its range [-1:+1]
  // the acting accelerations and forces make a triangle wave 
  // avoiding spikes in change rate of the acceleration (the "jerk")
  function squarewavejerk(x) = (1+pow(x,3)/2-3*x/2)/2;
  function profile_cubic(x) = squarewavejerk(trirepeater0(x/360));

  // simple quartical: TODO ... probably of no use thus not implemented 
  // function profile5(x) = "yet undefined";

  // triangular stretched and cropped to trapezoidal
  // TODO add some steeper versions
  // trapezoidal stretchable & shiftable
  t1 = 2; t2 = 0*0.25;
  //function profile_trapezoid(x,t1,t2) = crop01( (profile2(x)-1/2)*t1+1/2+t2 );
  function profile_trapezoid(x,t1,t2) = crop01( (profile_triangular(x)-1/2)*t1+1/2+t2 );
    // BUG: for some screw-lengths this leads to soem non-manifold results :S

  function profile_trapezoid0(x) = profile_trapezoid(x,2,0*1/4);
  function profile_trapezoid_steep(x) = profile_trapezoid(x,4,0*1/4); // yet unused

  function profile_saw_rising(x) = ( ceil(x/360) -(x/360) );
  function profile_saw_falling(x) = ( (x/360)-floor(x/360) );

  // sinusodial saw
  function profile7(x) = profile_sinusodial(sawrepeater1(x/360)*360/2); // pos & neg
  // TODO: barrel & pillow

  // first terms of fourier series of rectangular wave
  // sin(x)+1/3*sin(3*x)+1/5*sin(5*x)+ ... 
  function profile_fourier5_square(x) = 
    crop01( ( sin(x)+1/3*sin(3*x)+1/5*sin(5*x)*0 )/2+1/2 );
  function profile101(x) = (1  - cos( x+cos(x)*45 ))/2; 

  // circular (note the harsh 0° overhangs !)
  function circles(x) =
    1/2*(
    (x<=1/2) ? 0.99+sqrt(1-pow(4*x-1,2)) : 
    (x> 1/2) ? 1-sqrt(1-pow(4*x-3,2)) :1
    );
  function profile_circular(x) = sawrepeater1(circles(x/360));
  
  //echo( profile6(360.1)); // phi>360 PROBLEM
  // where did profile6 go ???

  // sinusodial convex braid
  function profile_sine_blobby(x) = abs(cos(x/2));
  // sinusodial concave spikes
  function profile_sine_spikey(x) = 1-abs(cos(x/2));
  // TODO: combination => curly brace shape .....

  // gap trouble trianglesaw4 / sinusodial trianglesaw4
  function slanttriangle(x,n) = ( (x<(1-1/n)) ? (n/(n-1))*x : 1 - (n)*x ); 
  function profile_triang_asym(x) = sawrepeater1( slanttriangle(x/(360+0.1),4) );
  // saw from stretched and squeezed sinusodial
  // => soft profile with overhangs mainly on one side in case of
  // NOT RECOMMENDET vertical orientation print
  function profile_sine_asym(x) = 
    1/2-1/2*cos( 180* sawrepeater1( slanttriangle(x/(360+0.1),4) )  );


// ##############################


// parameters r0 , dr
function polar_profile(phi, name="unitcircle", parameters = []) =
  (name == "unitcircle") ? 1 :
  (name == "testprofile1") ?  10*profile_sinusodial(phi) : 1;
  //(name == "testprofile1") ?  testprofile1(phi) : 1;
  // testprofile1 not defined
  
  
  
// ############## OLD STUFF
/*
// currently the format parameter is pretty undefined ... TODO change that
// todo ... radial clearingshift .... offset clearingshift ...
// The list of predefined profile - supposed to be hidden away in a seperate library

  // name == "syntaxtree" ? ... 
  // use the paramlist as a syntax tree for algebraic expressions 
  // STOP -- just a hypothetical possibility
  // would require serious language reimplementation in the 
  // unsuitable host language OpenSCAD
  // its easier for users to just extend the function list here instead
*/

// -------------------------------------------------------------------

// The following is an unmodified copy of lib-FDMscrews-HOF.scad
// from the scad-lib-FDMscrews library,
// taken from: https://github.com/mechadense/scad-lib-FDMscrews
// It is licensed under LGPL-3.

// lib-FDMscrews-HOF.scad
// High-performance drop-in replacement for lib-FDMscrews.scad
// Keeps identical API but with 10-100x performance improvement

// Default resolutions (same as original)
defresolcirc = 96; // 64, 96, 128
defresolax = 48; // 32, 48, 64

// =============================================================================
// FAST GEOMETRY GENERATION (replaces minimal_extrusion_core.scad)
// =============================================================================

function generate_screw_geometry_fast(
  screwtype,
  r0, dr, twist, z_max, 
  circum_resol, z_resol, 
  starts=1, offsetangle=0
) =
let (
  // Profile function selector - FIXED radius calculation
  profileradiusfunction = function(phi)
    let (
      // Normalize angle to [0, 360) to prevent profile function issues
      phi_norm = ((phi % 360) + 360) % 360,
      profile_val = 
        (screwtype == "cubic")     ? profile_cubic(phi_norm) :
        (screwtype == "sinusodial") ? profile_sinusodial(phi_norm) :
        (screwtype == "triangular") ? profile_triangular(phi_norm) :
        (screwtype == "circular")   ? profile_circular(phi_norm) :
        (screwtype == "trapezoid") ? profile_trapezoid0(phi_norm) :
        (screwtype == "triang_asym")? profile_triang_asym(phi_norm) :
        (screwtype == "sine_asym")  ? profile_sine_asym(phi_norm) :
        (screwtype == "rect")       ? profile_rectangular(phi_norm) :
        (screwtype == "saw_rising") ? profile_saw_rising(phi_norm) :
        (screwtype == "saw_falling")? profile_saw_rising(phi_norm) :
        (screwtype == "sine_spikey")? profile_sine_spikey(phi_norm) :
        (screwtype == "sine_blobby")? profile_sine_blobby(phi_norm) :
        (screwtype == "squarefourier5") ? profile_fourier5_square(phi_norm) :
        0.5, // default fallback to middle value
      // Clamp profile value to reasonable range
      profile_clamped = max(0, min(1, profile_val))
    )
    r0 + dr * (profile_clamped - 1), // FIXED: Back to original formula (profile-1)
  
  // DEBUGGED vertex generation - removed problematic phi_offset for now
  vertices = [
    [0, 0, 0],      // bottom center (index 0)
    [0, 0, z_max],  // top center (index 1)
    
    // Surface vertices - simplified for debugging
    for (i_z = [0:z_resol])
      for (i_phi = [0:circum_resol-1])
        let (
          z = i_z * z_max / z_resol,
          phi_base = i_phi * 360 / circum_resol,
          // Simplified: remove phi_offset temporarily to isolate issues
          phi_twist = (i_z/z_resol) * twist, // Fixed sign - positive twist
          phi_eval = starts * (phi_base + phi_twist) + offsetangle,
          direction = [cos(phi_base), sin(phi_base)], // Use base direction
          r = profileradiusfunction(phi_eval),
          // Clamp radius to prevent geometry explosion - REMOVED clamping
          r_safe = r
        )
        [r_safe * direction[0], r_safe * direction[1], z]
  ],
  
  // FIXED face generation with better error checking
  vertex_idx = function(layer, circ) 
    let (idx = 2 + layer * circum_resol + (circ % circum_resol))
    idx,
  
  faces = [
    // Bottom cap - FIXED to eliminate z-fighting
    for (j = [0:circum_resol-1])
      [0, vertex_idx(0, j), vertex_idx(0, (j+1) % circum_resol)],
    
    // Top cap - FIXED to eliminate z-fighting
    for (j = [0:circum_resol-1])
      [1, vertex_idx(z_resol, (j+1) % circum_resol), vertex_idx(z_resol, j)],
    
    // Side surface - FIXED normals (correct winding for outward faces)
    for (i = [0:z_resol-1])
      for (j = [0:circum_resol-1])
        let (
          v1 = vertex_idx(i, j),
          v2 = vertex_idx(i, (j+1) % circum_resol),
          v3 = vertex_idx(i+1, j), 
          v4 = vertex_idx(i+1, (j+1) % circum_resol)
        )
        // FIXED: Flipped winding order for proper outward normals
        each [[v1, v3, v2], [v2, v3, v4]]
  ]
) [vertices, faces];

// =============================================================================
// FAST SCREW GENERATION MODULE (replaces screw_internal)
// =============================================================================

module screw_internal_fast(
  screwtype = "circular",
  r0 = 5,
  dr = 1.5,
  twist = 360*4,
  z_max = 12,
  circum_resol = defresolcirc,
  z_resol = defresolax,
  starts = 1,
  offsetangle = 0
) {
  geometry = generate_screw_geometry_fast(
    screwtype, r0, dr, twist, z_max, 
    circum_resol, z_resol, starts, offsetangle
  );
  
  polyhedron(points = geometry[0], faces = geometry[1], convexity = 3);
}

// =============================================================================
// USER-FACING API - IDENTICAL TO ORIGINAL
// =============================================================================

module screwByPitch(
  pitch = 3,
  length = 12,
  d0 = 10,
  dr = 1.5,
  circum_resol = defresolcirc,
  axial_resol = defresolax,
  starts = 1,
  profile = "cubic",
  offsetangle = 0,
  flat = 1,
  chamfer1 = false,
  chamfer2 = false,
  widen1 = false,
  widen2 = false
) {
  r0 = d0/2;
  twist = length/(pitch*starts)*360;
  axial_resol2 = ceil(axial_resol*length/(2*r0));
  
  intersection() {
    screw_internal_fast(
      profile,
      r0, dr,
      twist,
      length,
      circum_resol,
      axial_resol2,
      starts,
      offsetangle
    );
    screwcropper(length,r0,dr,flat,chamfer1,chamfer2,circum_resol);
  }
  screwaugmenter(length,r0,dr,flat,widen1,widen2,circum_resol);
}

module screwByTwist(
  twist = 360*4,
  length = 12,
  d0 = 10,
  dr = 1.5,
  circum_resol = defresolcirc,
  axial_resol = defresolax,
  starts = 1,
  profile = "cubic",
  offsetangle = 0,
  flat = 1,
  chamfer1 = false,
  chamfer2 = false,
  widen1 = false,
  widen2 = false
) {
  r0 = d0/2;
  axial_resol2 = ceil(axial_resol*length/(2*r0));
  
  intersection() {
    screw_internal_fast(
      profile,
      r0, dr,
      twist,
      length,
      circum_resol,
      axial_resol2,
      starts,
      offsetangle
    );
    screwcropper(length,r0,dr,flat,chamfer1,chamfer2,circum_resol);
  }
  screwaugmenter(length,r0,dr,flat,widen1,widen2,circum_resol);
}

// =============================================================================
// SUPPORT MODULES (copied from original)
// =============================================================================

module screwaugmenter(
  length, r0, dr,
  flat = 0.6,
  widen1 = false,
  widen2 = false,
  circum_resol = defresolcirc
) {
  if(widen1) {
    intersection() {
      translate([0,0,0])
        cylinder(r1=r0,r2=r0-dr,h=dr,center=false,$fn=circum_resol);
      translate([0,0,dr/2])
        cube([2*r0*flat,r0*2+2,dr],center=true);
    }
  }
  if(widen2) {
    intersection() {
      translate([0,0,length-dr])
        cylinder(r2=r0,r1=r0-dr,h=dr,center=false,$fn=circum_resol);
      translate([0,0,length-dr/2])
        cube([2*r0*flat,r0*2+2,dr],center=true);
    }
  }
}

module screwcropper(
  length, r0, dr,
  flat = 0.6,
  chamfer1 = false,
  chamfer2 = false,
  circum_resol = defresolcirc
) {
  intersection() {
    union() {
      if(chamfer1) {
        translate([0,0,0])
          cylinder(r1=r0-dr,r2=r0,h=dr,center=false,$fn=circum_resol);
      }         
      if(chamfer2) {
        translate([0,0,length-dr])
          cylinder(r1=r0,r2=r0-dr,h=dr,center=false,$fn=circum_resol);
      }
      dl = 0 + (chamfer1 ? dr : 0) + (chamfer2 ? dr : 0);
      translate([0,0,chamfer1 ? dr : 0 ])
        cylinder(r=r0+dr,h=length-dl,center=false,$fn=circum_resol); // FIXED: r0+dr instead of r0
    }
    // The flat cut - this should work with your manual intersection
    translate([0,0,length/2])
      cube([2*r0*flat,2*(r0+dr),length+2*dr],center=true); // FIXED: wider cube
  }
}

// =============================================================================
// HOF EXTENSIONS (BONUS - New capabilities!)
// =============================================================================

// For users who want to use custom profile functions directly
module screwByPitch_HOF(
  profile_func,           // Function instead of string!
  pitch = 3,
  length = 12,
  d0 = 10,
  dr = 1.5,
  circum_resol = defresolcirc,
  axial_resol = defresolax,
  starts = 1,
  offsetangle = 0,
  flat = 1,
  chamfer1 = false,
  chamfer2 = false,
  widen1 = false,
  widen2 = false
) {
  r0 = d0/2;
  twist = length/(pitch*starts)*360;
  axial_resol2 = ceil(axial_resol*length/(2*r0));
  
  // Direct HOF geometry generation
  vertices = [
    [0, 0, 0], [0, 0, length],
    for (i_z = [0:axial_resol2])
      for (i_phi = [0:circum_resol-1])
        let (
          z = i_z * length / axial_resol2,
          phi_base = i_phi * 360 / circum_resol,
          phi_offset = (i_z) * (360/circum_resol) / 2,
          phi_twist = -(i_z/axial_resol2) * twist,
          phi_eval = starts * (phi_base + phi_offset + phi_twist) + offsetangle,
          direction = [cos(phi_base + phi_offset), sin(phi_base + phi_offset)],
          profile_value = profile_func(phi_eval),
          r = r0 + dr * (profile_value - 1)
        )
        [r * direction[0], r * direction[1], z]
  ];
  
  vertex_idx = function(layer, circ) 2 + layer * circum_resol + (circ % circum_resol);
  
  // FIXED HOF face generation
  faces = [
    for (j = [0:circum_resol-1])
      [0, vertex_idx(0, (j+1) % circum_resol), vertex_idx(0, j)],
    for (j = [0:circum_resol-1])
      [1, vertex_idx(axial_resol2, j), vertex_idx(axial_resol2, (j+1) % circum_resol)],
    for (i = [0:axial_resol2-1])
      for (j = [0:circum_resol-1])
        let (
          v1 = vertex_idx(i, j),
          v2 = vertex_idx(i, (j+1) % circum_resol),
          v3 = vertex_idx(i+1, j),
          v4 = vertex_idx(i+1, (j+1) % circum_resol)
        )
        each [[v1, v3, v2], [v2, v3, v4]]
  ];
  
  intersection() {
    polyhedron(vertices, faces, convexity=3);
    screwcropper(length,r0,dr,flat,chamfer1,chamfer2,circum_resol);
  }
  screwaugmenter(length,r0,dr,flat,widen1,widen2,circum_resol);
}

module b3cube(x,y,z,bx,by,bz)
{
  hull()
  {
    cube([x-2*bx,y-2*by,z-0*bz],center=true);
    cube([x-2*bx,y-0*by,z-2*bz],center=true);
    cube([x-0*bx,y-2*by,z-2*bz],center=true);
  }
}

// =============================================================================
// USAGE EXAMPLES
// =============================================================================

// IDENTICAL to old library:
// screwByPitch(pitch=3, length=12, d0=10, dr=1.5, profile="cubic");

// NEW HOF capability:
// my_profile = function(phi) 0.5 + 0.3*sin(phi) + 0.2*sin(3*phi);
// screwByPitch_HOF(my_profile, pitch=3, length=12, d0=10, dr=1.5);

// Use existing profiles as functions:
// screwByPitch_HOF(profile_cubic, pitch=3, length=12, d0=10, dr=1.5);