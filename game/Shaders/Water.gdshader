shader_type canvas_item;

varying vec2 spritePos;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform sampler3D noise_texture_1 : repeat_enable;
varying vec2 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	vec3 UV3D = vec3(UV, TIME / 7.0);
	vec4 noise1 = texture(noise_texture_1, UV3D);
	
	vec2 distortedUV = SCREEN_UV;
	distortedUV += sin(TIME * 8.0 + SCREEN_UV.x * 50.0) / 500.0;
	distortedUV += sin(TIME * 8.0 + SCREEN_UV.y * 50.0) / 500.0;
	
	vec4 bgTexture = textureLod(screen_texture, distortedUV, 0.0);
	
	bgTexture.rgb = mix(bgTexture.rgb, vec3(0.1, 0.4, 0.6), 0.8);
	bgTexture.g *= 1.0 + noise1.r / 3.0;
	bgTexture.b *= 1.0 + noise1.r;
	bgTexture.rgb = mix(bgTexture.rgb, vec3(0.0, 0.0, 0.0), 0.15);
	
	float waveSpeed = 4.0;
	
	if (UV.y < (sin(TIME * waveSpeed * 1.6 + world_position.x * 0.02) * sin(TIME * waveSpeed * 1.4  + world_position.x * 0.00923) * sin(TIME * waveSpeed + world_position.x * 0.0221) + 1.0) / 20.0){
		bgTexture.a = 0.0;
	}
	
	COLOR = bgTexture;
}