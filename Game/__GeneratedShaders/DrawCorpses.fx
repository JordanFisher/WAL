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
float4 vs_param_cameraPos;
float vs_param_cameraAspect;

// The following are variables used by the fragment shader (fragment parameters).
// Texture Sampler for fs_param_Corpses, using register location 1
float2 fs_param_Corpses_size;
float2 fs_param_Corpses_dxdy;

Texture fs_param_Corpses_Texture;
sampler fs_param_Corpses : register(s1) = sampler_state
{
    texture   = <fs_param_Corpses_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_Texture, using register location 2
float2 fs_param_Texture_size;
float2 fs_param_Texture_dxdy;

Texture fs_param_Texture_Texture;
sampler fs_param_Texture : register(s2) = sampler_state
{
    texture   = <fs_param_Texture_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Wrap;
    AddressV  = Wrap;
};

float fs_param_blend;

// The following variables are included because they are referenced but are not function parameters. Their values will be set at call time.

// The following methods are included because they are referenced by the fragment shader.
float2 Game__SimShader__get_subcell_pos__VertexOut__vec2(VertexToPixel vertex, float2 grid_size)
{
    float2 coords = vertex.TexCoords * grid_size + float2(-(0.25), -(0.25));
    float i = floor(coords.x);
    float j = floor(coords.y);
    return coords - float2(i, j);
}

bool Game__SimShader__CorpsePresent__corpse(float4 u)
{
    return u.r > 0 + .0019;
}

float FragSharpFramework__FragSharpStd__Float__Single(float v)
{
    return floor(255 * v + 0.5);
}

float4 Game__DrawCorpses__Sprite__corpse__vec2__PointSampler(VertexToPixel psin, float4 c, float2 pos, sampler Texture, float2 Texture_size, float2 Texture_dxdy)
{
    if (pos.x > 1 + .0019 || pos.y > 1 + .0019 || pos.x < 0 - .0019 || pos.y < 0 - .0019)
    {
        return float4(0.0, 0.0, 0.0, 0.0);
    }
    pos.x += FragSharpFramework__FragSharpStd__Float__Single(0.09411765);
    pos.y += FragSharpFramework__FragSharpStd__Float__Single(c.r) - 1;
    pos *= float2(1.0 / 32, 1.0 / 96);
    float4 clr = tex2D(Texture, pos);
    return clr;
}

// Compiled vertex shader
VertexToPixel StandardVertexShader(float2 inPos : POSITION0, float2 inTexCoords : TEXCOORD0, float4 inColor : COLOR0)
{
    VertexToPixel Output = (VertexToPixel)0;
    Output.Position.w = 1;
    Output.Position.x = (inPos.x - vs_param_cameraPos.x) / vs_param_cameraAspect * vs_param_cameraPos.z;
    Output.Position.y = (inPos.y - vs_param_cameraPos.y) * vs_param_cameraPos.w;
    Output.TexCoords = inTexCoords;
    Output.Color = inColor;
    return Output;
}

// Compiled fragment shader
PixelToFrame FragmentShader(VertexToPixel psin)
{
    PixelToFrame __FinalOutput = (PixelToFrame)0;
    float4 output = float4(0.0, 0.0, 0.0, 0.0);
    float4 here = tex2D(fs_param_Corpses, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Corpses_dxdy);
    float2 subcell_pos = Game__SimShader__get_subcell_pos__VertexOut__vec2(psin, fs_param_Corpses_size);
    if (Game__SimShader__CorpsePresent__corpse(here))
    {
        output += Game__DrawCorpses__Sprite__corpse__vec2__PointSampler(psin, here, subcell_pos, fs_param_Texture, fs_param_Texture_size, fs_param_Texture_dxdy);
        output *= fs_param_blend;
    }
    __FinalOutput.Color = output;
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