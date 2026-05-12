shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

uniform int mode = 0;
uniform float contrast = 1.0;

const mat3 RGB_TO_LMS = mat3(
    vec3(0.31399022, 0.15537241, 0.01775239),
    vec3(0.63951294, 0.75789446, 0.10944209),
    vec3(0.04649755, 0.08670142, 0.87256922)
);

const mat3 LMS_TO_RGB = mat3(
    vec3(5.47221206, -1.1252419,  0.02980165),
    vec3(-4.6419601,  2.29317094, -0.19318073),
    vec3(0.16963708, -0.1678952,  1.16364789)
);

void fragment() {
    vec4 color = texture(screen_texture, SCREEN_UV);

    vec3 lms = RGB_TO_LMS * color.rgb;

    if (mode == 1) {
        lms = vec3(lms.g, lms.g, lms.b); // protanopia 
    } else if (mode == 2) {
        lms = vec3(lms.r, lms.r, lms.b); // deuteranopia
    } else if (mode == 3) {
        lms = vec3(lms.r, lms.g, lms.g); // tritanopia
    }

    vec3 final_color = LMS_TO_RGB * lms;

    // contraste real
    final_color = (final_color - 0.5) * contrast + 0.5;

    COLOR = vec4(final_color, color.a);
}