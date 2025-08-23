// =============================================================================
//  Parameters - Adjust these values to customize your clamp
// =============================================================================

// --- Main Clamp Shape ---
max_desk_thickness = 42; // [mm] Maximum thickness of the desk/table.
taper_angle = 15; // Angle of the side taper.

// --- Middle Section ---
spigot_diameter = 12.4; // [mm] The outer diameter of the lamp's spigot.
spigot_socket_length = 32; // [mm] How deep the spigot fits into the clamp, from the top.
spigot_wall_thickness = 4; // [mm] Thickness of the outer cylinder around the lamp spigot.
middle_wall_thickness = 5; // [mm] Thickness of the wall connecting the top and bottom arms.
middle_fillet_radius = 2; // [mm] The fillet radius for the inner wall.

// --- Top Arm Parameters ---
top_depth = 40; // [mm] How far into the desk the top arm goes.
top_thickness = 5; // [mm] The vertical thickness of the top arm.
top_fillet_radius = 6; // [mm] The fillet radius of the top arm.
top_chamfer_radius = 1;

// --- Bottom Arm Parameters ---
bottom_depth = 20; // [mm] How far into the desk the bottom arm goes.
bottom_thickness = 7; // [mm] The vertical thickness of the bottom arm.
bottom_rounding_radius = 6; // [mm] The fillet radius of the bottom arm.
bottom_chamfer_radius = 1;

// --- Desk Screw ---
desk_hex_nut_size = 12.5; // [mm] The flat-to-flat distance of the desk hexagonal nut.
desk_hex_nut_thickness = 6.75; // [mm] The thickness of the desk nut.
desk_screw_diameter = 7.8; // [mm] The diameter of the desk screw.
desk_screw_cap_diameter = 16; // [mm] The diameter of the screw cap.
desk_screw_cap_thickness = 4; // [mm] The thickness of the screw cap.

// --- Locking Screw ---
side_screw_offset = 8.65; // [mm] How far down from the top surface the side screw is, from the top.
side_hex_nut_size = 7.9; // [mm] The flat-to-flat distance of the side hexagonal nut.
side_hex_nut_thickness = 3.25; // [mm] The thickness of the side nut.
side_screw_diameter = 4; // [mm] The diameter of the side screw.

// --- Tolerances & Quality ---
spigot_tolerance = 0.4; // [mm] Tolerance (extra empty space) for the spigot. Increase for looser fit.
hex_nut_tolerance = 0.4; // [mm] Tolerance (extra empty space) for hex nuts. Might be hard to fit the nut if set too low.
epsilon = 0.1; // [mm] Extra margin for cut-throughs.
$fn = 32; // Number of facets for curves. Higher is smoother.

// --- Rendering options ---
debug_mode = false; // Set to true to show cutouts in red inside a transparent body

// =============================================================================
//  Derived Variables
// =============================================================================

middle_wall_height = max_desk_thickness + desk_screw_cap_thickness;
total_height = top_thickness + middle_wall_height + bottom_thickness;
spigot_socket_diameter = spigot_diameter + spigot_tolerance;
back_cylinder_diameter = spigot_socket_diameter + spigot_wall_thickness * 2;
extra_inner_offset = middle_wall_thickness - spigot_wall_thickness;
bottom_arm_center = (spigot_socket_diameter / 2) + middle_wall_thickness + bottom_depth / 2;

// =============================================================================
//  Sanity Checks & Warnings
// =============================================================================

// --- Critical Errors (will stop rendering) ---

// Check that essential dimensions are positive values
assert(max_desk_thickness > 0, "ERROR: max_desk_thickness must be a positive value.");
assert(top_thickness > 0, "ERROR: top_thickness must be a positive value.");
assert(bottom_thickness > 0, "ERROR: bottom_thickness must be a positive value.");
assert(spigot_diameter > 0, "ERROR: spigot_diameter must be a positive value.");
assert(spigot_wall_thickness > 0, "ERROR: spigot_wall_thickness must be a positive value.");
assert(middle_wall_thickness > 0, "ERROR: middle_wall_thickness must be a positive value.");

// Check if the side screw is logically placed to actually hit the spigot
assert(
  side_screw_offset <= spigot_socket_length,
  str("ERROR: Side screw offset (", side_screw_offset, ") is below the spigot socket (length: ", spigot_socket_length, "). The screw will not engage with the spigot. Increase spigot_socket_length or decrease side_screw_offset.")
);

// Check if the bottom arm is deep enough for the screw/screw nut
assert(
  bottom_depth > desk_screw_diameter,
  str("ERROR: Bottom arm depth (", bottom_depth, ") is not enough to fit the desk screw (diameter: ", desk_screw_diameter, "). Increase bottom_depth, or decrease desk_screw_diameter (not recommended).")
);
assert(
  bottom_depth > desk_hex_nut_size,
  str("ERROR: Bottom arm depth (", bottom_depth, ") is not enough to fit the desk hex nut (diameter: ", desk_hex_nut_size, "). Increase bottom_depth, or decrease desk_hex_nut_size (not recommended).")
);

// Check if the screw cap fits
assert(
  bottom_depth >= desk_screw_cap_diameter,
  str("ERROR: Bottom arm depth (", bottom_depth, ") is not enough to fit the screw cap (diameter: ", desk_screw_cap_diameter, "). Increase bottom_depth, or decrease desk_screw_cap_diameter.")
);
assert(
  desk_screw_cap_diameter > desk_screw_diameter + 0.4,
  str("ERROR: Screw cap (diameter: ", desk_screw_cap_diameter, ") is not wide enough for the actual screw (diameter: ", desk_screw_diameter, "). Increase desk_screw_cap_diameter, or decrease desk_screw_diameter (not recommended).")
);

// --- Non-Critical Warnings (will print to console) ---

// Check if nut pockets too thick for the parts they're in
if (desk_hex_nut_thickness + epsilon + 0.8 > bottom_thickness) {
  echo(str("WARNING: Desk nut thickness (", desk_hex_nut_thickness, ") is too much for the bottom arm thickness (", bottom_thickness, "). The nut may break through the bottom."));
}
if (side_hex_nut_thickness + epsilon + 0.8 > spigot_wall_thickness) {
  echo(str("WARNING: Side nut thickness (", side_hex_nut_thickness, ") is too much for the spigot wall thickness (", spigot_wall_thickness, "). The nut may break through into the spigot socket."));
}

// Check if the side screw is too close to the top edge
if (side_screw_offset < (side_hex_nut_size / 2) + 1) {
  // Nut radius + 1mm of wall
  echo(str("WARNING: Side screw offset (", side_screw_offset, ") is very close to the top surface. There may not be enough material above the nut for strength."));
}

// Check for potentially weak, thin walls
if (middle_wall_thickness < 3) {
  echo(str("WARNING: Middle wall thickness is very thin (", middle_wall_thickness, "mm). The clamp may be weak. Consider increasing it."));
}
if (top_thickness < 4) {
  echo(str("WARNING: Top arm thickness is very thin (", top_thickness, "mm). The clamp may be weak. Consider increasing it."));
}
if (bottom_thickness < 4) {
  echo(str("WARNING: Bottom arm thickness is very thin (", bottom_thickness, "mm). The clamp may be weak. Consider increasing it."));
}
if (spigot_tolerance > 1) {
  echo(str("WARNING: Spigot tolerance is high (", spigot_tolerance, "mm). The spigot may have a very loose fit."));
}

// =============================================================================
//  Helper Modules
// =============================================================================

module rounded_triangle(big_diameter, small_diameter, taper_angle, flat_face_dist) {
  R = big_diameter / 2;
  r = small_diameter / 2;

  // The geometry is a large circle at the origin and two smaller circles
  // tangent to a vertical line and the two sides of the taper.

  // Slope of the tapered sides
  m = tan(taper_angle / 2);
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

module hex_pocket(size, thickness, tol = hex_nut_tolerance) {
  r = (size / 2) / cos(30); // Apothecary to radius conversion for hexagon
  translate([0, 0, -epsilon]) cylinder(h=thickness + 2 * epsilon, r=r + tol, $fn=6);
}
module screw_hole(d, h) {
  translate([0, 0, -epsilon]) cylinder(h=h + 2 * epsilon, d=d);
}

// =============================================================================
//  Clamp Solid Body Components
// =============================================================================

module top_arm_solid() {
  translate([0, 0, total_height - top_thickness])
    chamfered_extrude(height = top_thickness, bottom_radius = 0, top_radius = top_chamfer_radius)
      rounded_triangle(back_cylinder_diameter, top_fillet_radius, taper_angle, top_depth + extra_inner_offset);
}

module bottom_arm_solid() {
  chamfered_extrude(height = bottom_thickness, bottom_radius = bottom_chamfer_radius, top_radius = bottom_chamfer_radius)
    rounded_triangle(back_cylinder_diameter, bottom_rounding_radius, taper_angle, bottom_depth + extra_inner_offset);
}

module middle_section_solid() {
  translate([0, 0, bottom_chamfer_radius])
    linear_extrude(height=total_height - bottom_chamfer_radius - top_chamfer_radius)
      rounded_triangle(back_cylinder_diameter, middle_fillet_radius, taper_angle, extra_inner_offset);
}

module clamp_body() {
  union() {
    top_arm_solid();
    bottom_arm_solid();
    middle_section_solid();
  }
}

module desk_screw_cap() {
  translate([bottom_arm_center, 0, bottom_thickness])
    cylinder(d=desk_screw_cap_diameter, h=desk_screw_cap_thickness);
}

// =============================================================================
//  Clamp Cutout Components
// =============================================================================
module cutouts() {
  // Hole for the spigot
  translate([0, 0, total_height - spigot_socket_length]) {
    screw_hole(d=spigot_socket_diameter, h=spigot_socket_length);
  }
  // Desk screw + hex socket in the bottom arm
  translate([bottom_arm_center, 0, 0]) {
    screw_hole(d=desk_screw_diameter, h=bottom_thickness);
    hex_pocket(size=desk_hex_nut_size, thickness=desk_hex_nut_thickness);
  }
  // Side screw + hex socket at the back
  translate([(back_cylinder_diameter / -2), 0, total_height - side_screw_offset]) {
    rotate([0, 90, 0]) {
      screw_hole(d=side_screw_diameter, h=back_cylinder_diameter / 2);
      hex_pocket(size=side_hex_nut_size, thickness=side_hex_nut_thickness);
    }
  }
}

// =============================================================================
//  Main Assembly
// =============================================================================

if (debug_mode) {
  // 1. Render the main body with the '%' modifier.
  // This makes it transparent in the preview, like an x-ray.
  %clamp_body();
  // 2. Render the cutouts in solid red.
  color("red") cutouts();
  // 3. Render the conceptual screw cap in solid blue.
  color("blue") desk_screw_cap();
} else {
  difference() {
    clamp_body();
    cutouts();
  }
}
