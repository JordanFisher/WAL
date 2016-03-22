// This file was auto-generated by FragSharp. It will be regenerated on the next compilation.
// Manual changes made will not persist and may cause incorrect behavior between compilations.

#define PIXEL_SHADER ps_3_0
#define VERTEX_SHADER vs_3_0

// Vertex shader data structure definition
struct VertexToPixel
{
    float4 Position   : POSITION0;
    float4 Color      : COLOR0;
    float2 TexCoords  : TEXCOORD0;
    float2 Position2D : TEXCOORD2;
};

// Fragment shader data structure definition
struct PixelToFrame
{
    float4 Color      : COLOR0;
};

// The following are variables used by the vertex shader (vertex parameters).

// The following are variables used by the fragment shader (fragment parameters).
// Texture Sampler for fs_param_Tiles, using register location 1
float2 fs_param_Tiles_size;
float2 fs_param_Tiles_dxdy;

Texture fs_param_Tiles_Texture;
sampler fs_param_Tiles : register(s1) = sampler_state
{
    texture   = <fs_param_Tiles_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_Select, using register location 2
float2 fs_param_Select_size;
float2 fs_param_Select_dxdy;

Texture fs_param_Select_Texture;
sampler fs_param_Select : register(s2) = sampler_state
{
    texture   = <fs_param_Select_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_Random, using register location 3
float2 fs_param_Random_size;
float2 fs_param_Random_dxdy;

Texture fs_param_Random_Texture;
sampler fs_param_Random : register(s3) = sampler_state
{
    texture   = <fs_param_Random_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};


// The following variables are included because they are referenced but are not function parameters. Their values will be set at call time.

// The following methods are included because they are referenced by the fragment shader.
bool Game__SimShader__Something__data(float4 u)
{
    return u.r > 0 + .0019;
}

float FragSharpFramework__FragSharpStd__fint_floor__Single(float v)
{
    v += 0.0005;
    return floor(255 * v) * 0.003921569;
}

float Game__SimShader__RndFint__Single__Single__Single(float rnd, float f1, float f2)
{
    f2 += 0.003921569;
    f2 -= 0.0006;
    float val = rnd * (f2 - f1) + f1;
    return FragSharpFramework__FragSharpStd__fint_floor__Single(val);
}

// Compiled vertex shader
VertexToPixel StandardVertexShader(float2 inPos : POSITION0, float2 inTexCoords : TEXCOORD0, float4 inColor : COLOR0)
{
    VertexToPixel Output = (VertexToPixel)0;
    Output.Position.w = 1;
    Output.Position.xy = inPos.xy;
    Output.TexCoords = inTexCoords;
    return Output;
}

// Compiled fragment shader
PixelToFrame FragmentShader(VertexToPixel psin)
{
    PixelToFrame __FinalOutput = (PixelToFrame)0;
    float4 here = tex2D(fs_param_Tiles, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Tiles_dxdy);
    float4 select = tex2D(fs_param_Select, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Select_dxdy);
    float4 rndv = tex2D(fs_param_Random, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Random_dxdy);
    float rnd = rndv.x * rndv.x * rndv.x * rndv.x;
    if (Game__SimShader__Something__data(select))
    {
        here.r = 0.01960784;
        if (abs(0.01960784 - 0.003921569) < .0019)
        {
            here.g = Game__SimShader__RndFint__Single__Single__Single(rnd, 0.0, 0.02352941);
            here.b = 0.1215686;
        }
        else
        {
            if (abs(0.01960784 - 0.007843138) < .0019)
            {
                here.g = Game__SimShader__RndFint__Single__Single__Single(rnd, 0.0, 0.03529412);
                here.b = 0.1176471;
            }
            else
            {
                if (abs(0.01960784 - 0.01960784) < .0019)
                {
                    here.g = 0.0;
                    here.b = 0.09803922;
                }
            }
        }
    }
    __FinalOutput.Color = here;
    return __FinalOutput;
}

// Shader compilation
technique Simplest
{
    pass Pass0
    {
        VertexShader = compile VERTEX_SHADER StandardVertexShader();
        PixelShader = compile PIXEL_SHADER FragmentShader();
    }
}