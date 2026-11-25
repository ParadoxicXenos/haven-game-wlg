shader_type canvas_item;

varying vec2 spritePos;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform sampler3D noise_texture_1 : repeat_enable;
varying vec2 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	vec3 UV3D = vec3(UV, TIME / 10.0);
	vec4 noise1 = texture(noise_texture_1, UV3D);//world_position / 180.0);
	
	vec2 distortedUV = SCREEN_UV;
	distortedUV += sin(TIME * 8.0 + SCREEN_UV.x * 50.0) / 500.0;
	distortedUV += sin(TIME * 8.0 + SCREEN_UV.y * 50.0) / 500.0;
	
	//distortedUV.y += ((noise1.r * 2.0) - 1.0) * 0.05;
	//distortedUV.x += ((noise1.g * 2.0) - 1.0) * 0.05;
	
	vec4 bgTexture = textureLod(screen_texture, distortedUV, 0.0);
	
	bgTexture.rgb = mix(bgTexture.rgb, vec3(0.1, 0.6, 0.5), 0.5);
	bgTexture.r -= 0.4 + noise1.r;
	bgTexture.g *= 1.0 + noise1.r;
	bgTexture.g -= 0.4 + noise1.r;
	bgTexture.b *= 1.0 + noise1.r;
	
	COLOR = bgTexture;
}