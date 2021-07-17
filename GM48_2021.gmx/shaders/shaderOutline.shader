//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float outlineH;
uniform float outlineW;
uniform vec4 outlineColor; 

void main()
{
  vec2 offsetx;
  offsetx.x = outlineW;
  vec2 offsety;
  offsety.y = outlineH;
  
  float alpha = texture2D( gm_BaseTexture, v_vTexcoord ).a;
  vec4 newColor = texture2D( gm_BaseTexture, v_vTexcoord );
  
  if ( alpha < 1.0 ) { newColor = outlineColor; } 

  alpha = max(alpha, texture2D( gm_BaseTexture, v_vTexcoord + offsetx).a);
  alpha = max(alpha, texture2D( gm_BaseTexture, v_vTexcoord - offsetx).a);
  alpha = max(alpha, texture2D( gm_BaseTexture, v_vTexcoord + offsety).a);
  alpha = max(alpha, texture2D( gm_BaseTexture, v_vTexcoord - offsety).a);
    
  
  gl_FragColor = newColor;
  gl_FragColor.a = alpha;
}

///

uniform vec4 line_color : hint_color = vec4(1);
uniform float line_thickness : hint_range(0, 10) = 1.0;

void fragment() {
vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	
float outline = texture(TEXTURE, UV + vec2(-size.x, 0)).a;
	outline += texture(TEXTURE, UV + vec2(0, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, 0)).a;
	outline += texture(TEXTURE, UV + vec2(0, -size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
	outline = min(outline, 1.0);
	
vec4 color = texture(TEXTURE, UV);
gl_FragColor = mix(color, line_color, outline - color.a);
}
