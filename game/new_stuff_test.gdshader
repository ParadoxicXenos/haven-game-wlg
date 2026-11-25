shader_type canvas_item;

varying vec2 spritePos;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void vertex() {
	// Called for every vertex the material is visible on.
	spritePos = (MODEL_MATRIX * vec4(0.0, 0.0, 0.0, 1.0)).xy;
}

void fragment() {
	vec2 ditsortedUV = UV;
	
	vec4 bgTexture = textureLod(screen_texture, SCREEN_UV, 0.0);
	
	COLOR = bgTexture;
}