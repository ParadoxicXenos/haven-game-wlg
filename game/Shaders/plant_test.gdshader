shader_type canvas_item;

varying vec2 spritePos;

void vertex() {
	// Called for every vertex the material is visible on.
	spritePos = (MODEL_MATRIX * vec4(0.0, 0.0, 0.0, 1.0)).xy;
}

void fragment() {
	float windStrength = 0.8;
	float wind =  sin(TIME - (spritePos.x / -500.0)) * sin(TIME * 2.83 - (spritePos.x / -500.0));
	
	float angle = distance(vec2(0.5, 1), vec2(UV)) * wind * windStrength;
	
	vec2 inVec = UV - vec2(0.5, 1);
	vec2 rotatedVec;
	
	rotatedVec.x = (inVec.x * cos(angle)) - (inVec.y * sin(angle));
	rotatedVec.y = (inVec.x * sin(angle)) + (inVec.y * cos(angle));
	
	vec2 ditsortedUV = rotatedVec +  vec2(0.5, 1);
	
	
	vec4 tex_color = texture(TEXTURE, ditsortedUV);
	
	COLOR = tex_color;
}