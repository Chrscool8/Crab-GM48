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
uniform vec3 size; //width, height, radius
uniform float xoffset;
const int Quality = 36;
const int Directions = 32;
const float Pi = 6.28318530718; //pi * 2

vec4 gauss(vec4 colorin)
{
    vec2 radius = size.z/size.xy;
    vec2 coord = v_vTexcoord;
    
    for(float d = 0.0; d < Pi; d += Pi/float(Directions))
    {
        for(float i = 1.0/float(Quality); i <= 1.0; i += 1.0/float(Quality) )
        {
            colorin += texture2D(gm_BaseTexture, coord+vec2(cos(d) + xoffset, sin(d))*radius*i*2.);
        }
    }
    
    colorin /= float(Quality) * float(Directions) + 1.0;    
    return colorin * v_vColour;
}

// automatically generated by GenerateGaussFunctionCode in GaussianBlur.h
vec4 GaussianBlur(vec2 centreUV, vec2 pixelOffset ) 
{     
    vec3 colOut = vec3( 0, 0, 0 );
       
    ////////////////////////////////////////////////;
    // Kernel width 7 x 7
    //
    const int stepCount = 2;
    //
       
    float gWeights[stepCount];
    gWeights[0] = 0.44908;
    gWeights[1] = 0.05092;
    
    float gOffsets[stepCount];
    gOffsets[0] = 0.53805;
    gOffsets[1] = 2.06278;
    
    ////////////////////////////////////////////////;

    for( int i = 0; i < stepCount; i++ )    
    {   
        vec2 texCoordOffset = gOffsets[i] * pixelOffset;
        vec3 col =  texture2D(gm_BaseTexture, centreUV + texCoordOffset).xyz +
                    texture2D(gm_BaseTexture, centreUV - texCoordOffset).xyz;
        colOut += gWeights[i]*col;
    }  

    return vec4(colOut, 1.0);
    //return colOut;
}

vec4 bandify(vec4 colorin)
{
    float band_size = .125;
    colorin.r = pow(ceil(colorin.r/band_size)*band_size, .5);
    colorin.g = pow(ceil(colorin.g/band_size)*band_size, .5);
    colorin.b = pow(ceil(colorin.b/band_size)*band_size, .5);    
    colorin.a =(1. - ceil(colorin.r - 225./255.));
    return colorin;
}

void main()
{   
    vec4 Color = texture2D(gm_BaseTexture, v_vTexcoord);
    //vec4 Color_blurred = gauss(Color);
    vec4 Color_blurred = GaussianBlur(v_vTexcoord, vec2(.001));
    vec4 Color_banded = Color_blurred;//bandify(Color_blurred);                          
    gl_FragColor = Color_banded;
}
