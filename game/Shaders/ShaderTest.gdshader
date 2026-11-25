shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float movementMag = 0;
	
global uniform vec2 player_move_dir;
	
void fragment() {
	float blurAmt = 6.0;
	float blurDiv = 1000.0;
	float angle = radians(TIME * 100.0);
	
	vec2 distortedUV = SCREEN_UV;
	//distortedUV -= UV.x;
	vec4 blurVal = textureLod(screen_texture, distortedUV, 0.0);
	vec4 sampleColor;
	for (float i = 0.0; i < blurAmt; i ++) {
		sampleColor = textureLod(screen_texture, vec2(distortedUV.x - (((i - blurAmt) * -1.0) / blurDiv * player_move_dir.x / -1000.0), distortedUV.y - (((i - blurAmt) * -1.0) / blurDiv *  player_move_dir.y / -1000.0)), 0.0);
		blurVal = mix(blurVal, sampleColor, 0.2);
	}
	//blurVal /= blurAmt;
	
	
	//vec4 newColor = textureLod(screen_texture, distortedUV, 0.0);
	//vec4 newColor = blurVal;
	vec4 newColor = blurVal;
    COLOR = newColor;
}