shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float movementMag = 0;
	
	
void fragment() {
	float blurAmt = 30.0;
	float blurDiv = 700.0;
	float angle = radians(TIME * 100.0);
	
	vec2 distortedUV = UV;
	//distortedUV -= UV.x;
	vec4 blurVal = textureLod(screen_texture, distortedUV, 0.0);
	vec4 sampleColor;
	for (float i = 0.0; i < blurAmt; i ++) {
		sampleColor = textureLod(screen_texture, vec2(distortedUV.x - (((i - blurAmt) * -1.0) / blurDiv * sin(angle)), distortedUV.y - (((i - blurAmt) * -1.0) / blurDiv * cos(angle))), 0.0);
		blurVal = mix(blurVal, sampleColor, 0.1);
	}
	//blurVal /= blurAmt;
	
	
	//vec4 newColor = textureLod(screen_texture, distortedUV, 0.0);
	//vec4 newColor = blurVal;
	vec4 newColor = blurVal;
    COLOR = newColor;
}