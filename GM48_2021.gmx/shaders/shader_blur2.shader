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
uniform vec3 size; //width,height,radius
uniform float xoffset;

const int Quality = 36;
const int Directions = 32;
const float Pi = 6.28318530718; //pi * 2

void main()
{
    vec2 radius = size.z/size.xy;
    vec2 coord = v_vTexcoord;
    
    float band_xsize = .025/8.;
//    float band_ysize = .025/8.;
    coord.x = ceil(coord.x/band_xsize)*(band_xsize);
    coord.y = ceil(coord.y/band_xsize)*(band_xsize);
    
    vec4 Color = texture2D(gm_BaseTexture, coord);
    float alpha = Color.a;
    
    for(float d=0.0; d<Pi; d+=Pi/float(Directions))
    {
        for(float i=1.0/float(Quality); i<=1.0; i+=1.0/float(Quality) )
        {
            Color += texture2D(gm_BaseTexture, coord+vec2(cos(d) + xoffset, sin(d))*radius*i*2.);
        }
    }
    
    Color /= float(Quality) * float(Directions)+1.0;
    vec4 Color_ = Color * v_vColour;
    float band_size = .125;
    Color_.r = pow(ceil(Color_.r/band_size)*band_size, .5);
    Color_.g = pow(ceil(Color_.g/band_size)*band_size, .5);
    Color_.b = pow(ceil(Color_.b/band_size)*band_size, .5);
    Color_.a = 0.;
    
    if (Color_.r >= 190./255.)
        if (Color_.r < 225./255.)
            Color_ = vec4(184/255, 131/255, 20/255, .1);
    //else
    //    Color_ = vec4(184/255, 131/255, 20/255, .6);

    gl_FragColor = Color_;
}
