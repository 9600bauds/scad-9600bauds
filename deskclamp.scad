// =============================================================================
//  Parameters - Adjust these values to customize your clamp
// =============================================================================

// --- Main Clamp Shape ---
max_desk_thickness = 40; // [mm] Maximum thickness of the desk/table.
taper_angle = 30; // Angle of the side taper.

// --- Top Arm Parameters (Defines the overall shape) ---
top_depth = 50; // [mm] How far into the desk the top arm goes.
top_thickness = 15; // [mm] The vertical thickness of the top arm.
top_rounding_radius = 8; // [mm] The fillet radius of the top arm.

// --- Bottom Arm Parameters ---
bottom_depth = 20; // [mm] How far into the desk the bottom arm goes.
bottom_thickness = 15; // [mm] The vertical thickness of the bottom arm.
bottom_rounding_radius = 6; // [mm] The fillet radius of the bottom arm.

// --- Middle Section ---
spigot_diameter = 12.8; // [mm] The outer diameter of the lamp's spigot.
middle_wall_thickness = 8; // [mm] Thickness of the walls around the lamp spigot.
middle_rounding_radius = 4; // [mm] The fillet radius for the internal corners of the "C".
spigot_socket_length = 40; // [mm] How deep the spigot fits into the clamp, from the top.

// --- Main Screw ---
main_hex_nut_size = 13; // [mm] The flat-to-flat distance of the main hexagonal nut.
main_hex_nut_thickness = 4; // [mm] The thickness of the main nut.
main_screw_diameter = 8; // [mm] The diameter of the main screw.

// --- Locking Screw ---
side_screw_offset = 20; // [mm] How far down from the top surface the side screw is, from the top.
side_hex_nut_size = 6.5; // [mm] The flat-to-flat distance of the side hexagonal nut.
side_hex_nut_thickness = 3; // [mm] The thickness of the side nut.
side_screw_diameter = 4; // [mm] The diameter of the side screw.

// --- Tolerances & Quality ---
tolerance = 0.4; // A small gap for press-fitting parts. Increase for looser fit.
epsilon = 0.1; // Extra margin for cut-throughs
$fn = 32; // Number of facets for curves. Higher is smoother.

// --- Rendering options ---
debug_mode = true; // Set to true to show cutouts in red inside a transparent body

// =============================================================================
//  Derived Variables
// =============================================================================
total_height = top_thickness + max_desk_thickness + bottom_thickness;
back_cylinder_diameter = spigot_diameter + middle_wall_thickness;

// =============================================================================
//  Helper Modules
// =============================================================================

module rounded_triangle(d_big, d_small, taper_angle, flat_dist) {
  R = d_big / 2;
  r = d_small / 2;

  // Slope of each side; angle is preserved for any flat_dist
  m = tan(taper_angle / 2); // OpenSCAD trig uses degrees
  S = sqrt(1 + m * m); // sec(taper/2)

  // Vertical flat is tangent to the small circles at x = R + flat_dist
  x_flat = R + flat_dist;
  cx = x_flat - r; // small-circle centre x

  // Derived from the tangent condition to both circles:
  // For line y = m x + c, touching big circle => c = R*S.
  // Touching small circle externally => -m*cx + cy - c = -r*S  => cy = m*cx + (R - r)*S
  cy = m * cx + (R - r) * S;

  hull() {
    translate([0, 0]) circle(r=R);
    translate([cx, cy]) circle(r=r);
    translate([cx, -cy]) circle(r=r);
  }
}

// =============================================================================
//  Clamp Solid Body Components
// =============================================================================

module top_arm_solid() {
  translate([0, 0, total_height - top_thickness])
    linear_extrude(height=top_thickness)
      rounded_triangle(back_cylinder_diameter, top_rounding_radius, taper_angle, top_depth);
}

module bottom_arm_solid() {
  linear_extrude(height=bottom_thickness)
    rounded_triangle(back_cylinder_diameter, bottom_rounding_radius, taper_angle, bottom_depth);
}

module middle_section_solid() {
  translate([0, 0, bottom_thickness])
    linear_extrude(height=max_desk_thickness)
      rounded_triangle(back_cylinder_diameter, middle_rounding_radius, taper_angle, 0);
}

module clamp_body() {
  union() {
    top_arm_solid();
    bottom_arm_solid();
    middle_section_solid();
  }
}

// =============================================================================
//  Clamp Cutout Components
// =============================================================================
module cutouts() {
  module hex_pocket(size, thickness, tol = tolerance, sides = 6) {
    r = (size / 2) / cos(30);
    translate([0, 0, -epsilon]) cylinder(h=thickness + 2 * epsilon, r=r + tol, $fn=sides);
  }
  module screw_hole(d, h) {
    translate([0, 0, -epsilon]) cylinder(h=h + 2 * epsilon, d=d);
  }

  translate([(bottom_depth + back_cylinder_diameter) / 2, 0, 0]) {
    screw_hole(d=main_screw_diameter, h=bottom_thickness);
    hex_pocket(size=main_hex_nut_size, thickness=main_hex_nut_thickness);
  }
  translate([(back_cylinder_diameter / -2), 0, total_height - side_screw_offset]) {
    rotate([0, 90, 0]) {
      screw_hole(d=side_screw_diameter, h=back_cylinder_diameter / 2);
      translate([0, 0, 0])
        hex_pocket(size=side_hex_nut_size, thickness=side_hex_nut_thickness);
    }
  }
  translate([0, 0, total_height - spigot_socket_length]) {
    cylinder(h=spigot_socket_length + epsilon, d=spigot_diameter + tolerance);
  }
}

// =============================================================================
//  Main Assembly
// =============================================================================

if (debug_mode) {
  // 1. Render the main body with the '%' modifier.
  // This makes it transparent in the preview, like an x-ray.
  %clamp_body();
  // 2. Render the cutouts in a solid, contrasting color.
  color("red") cutouts();
} else {
  difference() {
    clamp_body();
    cutouts();
  }
}
