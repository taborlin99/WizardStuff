shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform vec4 base_color : source_color;

vec4 hard_light(vec4 base, vec4 blend){
	vec4 limit = step(0.5, blend);
	return mix(2.0 * base * blend, 1.0 - 2.0 * (1.0 - base) * (1.0 - blend), limit);
}
vec4 lighten(vec4 base, vec4 blend){
	return max(base, blend);
}
vec4 screen(vec4 base, vec4 blend){
	return 1.0 - (1.0 - base) * (1.0 - blend);
}


void fragment() {
	vec4 fog_color_1 = texture(TEXTURE, vec2(UV.x / 1.0 + TIME / 50.0, UV.y / 1.0  + TIME  / 150.0)).rgba;
	vec4 fog_color_2 = texture(TEXTURE, vec2(UV.x / 1.0 - 1.0 - TIME / 50.0, UV.y / 1.0 -2.0 - TIME / 150.0)).rgba;
	vec4 fog_color_3 = texture(TEXTURE, vec2(UV.x / 1.0  - 1.0 + TIME / 50.0, UV.y / 1.0 -3.0 - TIME / 150.0)).rgba;
	vec4 fog = mix(fog_color_1, mix(fog_color_3, fog_color_2, 0.5), 0.7);
	
	
	vec4 baseColor = texture(TEXTURE, UV);
	vec4 screenColor = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR = hard_light(fog, screenColor);
	}