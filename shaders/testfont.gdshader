shader_type canvas_item;

uniform sampler2D NOISE_PATTERN;
uniform vec2 scroll = vec2(0.6,0.6);
uniform sampler2D TONE_MAPPING; 

void fragment() {
	float text_alpha = texture(TEXTURE, UV).a;
	float pattern_intensity = texture(NOISE_PATTERN, UV + (0.1 * sin(TIME * scroll))).r;
	float intensity = text_alpha * pattern_intensity;
	COLOR = vec4(intensity);
	//vec3 text_color = texture(TONE_MAPPING, UV).rgb * intensity;
	//COLOR.rgb = text_color;
}

