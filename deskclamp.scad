// --- Lamp Spigot / Socket ---
spigot_diameter = 12.8; // [mm] The outer diameter of the lamp's spigot.
spigot_socket_length = 40; // [mm] How deep the spigot fits into the clamp.

// --- Main Screw ---
main_hex_nut_size = 13; // [mm] The flat-to-flat distance of the main hexagonal nut.
main_hex_nut_thickness = 6.5; // [mm] The thickness of the main nut.
main_screw_diameter = 8; // [mm] The diameter of the main screw.

// --- Locking Screw ---
side_hex_nut_size = 6.5; // [mm] The flat-to-flat distance of the side hexagonal nut.
side_hex_nut_thickness = 3.5; // [mm] The thickness of the side nut.
side_screw_diameter = 4; // [mm] The diameter of the side screw.
side_screw_offset = 20; // [mm] How low is the side screw?

// --- Main Clamp Dimensions ---
max_desk_height = 55; // [mm] 
side_thickness = 25; // [mm]
side_width = 25;
bottom_depth = 30; // [mm] 
bottom_width = 25; // [mm] 
bottom_thickness = 15; // [mm]
top_depth = 60; // [mm] 
top_width = 45; // [mm] 
top_thickness = 15; // [mm]

// --- Tolerances & Quality ---
tolerance = 0.4; // A small gap for press-fitting parts. Increase for looser fit.
epsilon = 0.2; // Extra margin for cut-throughs
$fn = 32; // Number of facets for curves. Higher is smoother.

// =============================================================================
//  Helper Modules
// =============================================================================

// Hexagonal nut pocket
module hex_pocket(size, thickness, tol = tolerance) {
  r = (size / 2) / cos(30); // Hex nut radius (distance from center to a vertex)
  translate([0, 0, -epsilon])
    cylinder(h=thickness + 2 * epsilon, r=r + tol, $fn=6);
}

// Simple through-hole cylinder
module screw_hole(d, h) {
  translate([0, 0, -epsilon])
    cylinder(h=h + 2 * epsilon, d=d, center=false);
}

// =============================================================================
//  Clamp Solid Body Components
// =============================================================================

// Bottom arm solid block
module bottom_arm_solid() {
  translate([side_thickness, (side_width - bottom_width) / 2, 0]) {
    cube([bottom_depth, bottom_width, bottom_thickness]);
  }
}

// Top arm solid block
module top_arm_solid() {
  translate([side_thickness, (side_width - top_width) / 2, bottom_thickness + max_desk_height]) {
    cube([top_depth, top_width, top_thickness]);
  }
}

// Vertical side/back solid block
module side_section_solid() {
  total_height = top_thickness + max_desk_height + bottom_thickness;
  cube([side_thickness, side_width, total_height]);
}

// =============================================================================
//  Clamp Cutout Components
// =============================================================================
module cutouts() {
  total_height = top_thickness + max_desk_height + bottom_thickness;

  // Main screw hole and nut trap on bottom arm
  translate([side_thickness + bottom_depth / 2, side_width / 2, 0]) {
    screw_hole(main_screw_diameter, bottom_thickness);
    hex_pocket(main_hex_nut_size, main_hex_nut_thickness);
  }

  // Side screw and nut trap on side section
  // We align everything to the center of the screw on the back plane first
  translate([0, side_width / 2, total_height - side_screw_offset]) {
    // Then we rotate the coordinate system so we can cut horizontally rather than vertically
    rotate([0, 90, 0]) {
      screw_hole(side_screw_diameter, side_thickness / 2);
      hex_pocket(side_hex_nut_size, side_hex_nut_thickness);
    }
  }

  // Spigot socket on side section
  translate([side_thickness / 2, side_width / 2, total_height - spigot_socket_length]) {
    cylinder(h=spigot_socket_length + 2 * epsilon, d=spigot_diameter + tolerance);
  }
}

// =============================================================================
//  Main Assembly
// =============================================================================
module clamp_body() {
  union() {
    bottom_arm_solid();
    top_arm_solid();
    side_section_solid();
  }
}

module clamp() {
  difference() {
    clamp_body();
    cutouts();
  }
}

// =============================================================================
//  Render
// =============================================================================
clamp();