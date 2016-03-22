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
// Texture Sampler for fs_param_Select, using register location 1
float2 fs_param_Select_size;
float2 fs_param_Select_dxdy;

Texture fs_param_Select_Texture;
sampler fs_param_Select : register(s1) = sampler_state
{
    texture   = <fs_param_Select_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_Data, using register location 2
float2 fs_param_Data_size;
float2 fs_param_Data_dxdy;

Texture fs_param_Data_Texture;
sampler fs_param_Data : register(s2) = sampler_state
{
    texture   = <fs_param_Data_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_Units, using register location 3
float2 fs_param_Units_size;
float2 fs_param_Units_dxdy;

Texture fs_param_Units_Texture;
sampler fs_param_Units : register(s3) = sampler_state
{
    texture   = <fs_param_Units_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_Corpses, using register location 4
float2 fs_param_Corpses_size;
float2 fs_param_Corpses_dxdy;

Texture fs_param_Corpses_Texture;
sampler fs_param_Corpses : register(s4) = sampler_state
{
    texture   = <fs_param_Corpses_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_AntiMagic, using register location 5
float2 fs_param_AntiMagic_size;
float2 fs_param_AntiMagic_dxdy;

Texture fs_param_AntiMagic_Texture;
sampler fs_param_AntiMagic : register(s5) = sampler_state
{
    texture   = <fs_param_AntiMagic_Texture>;
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

bool Game__SimShader__CorpsePresent__corpse(float4 u)
{
    return u.r > 0 + .0019;
}

bool Game__UnitDistribution__Contains__Single__vec2__Field(VertexToPixel psin, float distribution, float2 v, sampler Corpses, float2 Corpses_size, float2 Corpses_dxdy)
{
    if (abs(distribution - 1.0) < .0019)
    {
        return true;
    }
    if (abs(distribution - 2.0) < .0019)
    {
        return abs((int)(v.x) % 2 - 0) < .0019 && abs((int)(v.y) % 2 - 0) < .0019;
    }
    if (abs(distribution - 3.0) < .0019)
    {
        return Game__SimShader__CorpsePresent__corpse(tex2D(Corpses, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * Corpses_dxdy));
    }
    return false;
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
    float4 select = tex2D(fs_param_Select, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Select_dxdy);
    float4 here = tex2D(fs_param_Data, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Data_dxdy);
    float4 antimagic = tex2D(fs_param_AntiMagic, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_AntiMagic_dxdy);
    if (antimagic.r > 0.0 + .0019 && abs(0.01176471 - 0.003921569) > .0019)
    {
        __FinalOutput.Color = float4(0, 0, 0, 0);
        return __FinalOutput;
    }
    if (antimagic.g > 0.0 + .0019 && abs(0.01176471 - 0.007843138) > .0019)
    {
        __FinalOutput.Color = float4(0, 0, 0, 0);
        return __FinalOutput;
    }
    if (antimagic.b > 0.0 + .0019 && abs(0.01176471 - 0.01176471) > .0019)
    {
        __FinalOutput.Color = float4(0, 0, 0, 0);
        return __FinalOutput;
    }
    if (antimagic.a > 0.0 + .0019 && abs(0.01176471 - 0.01568628) > .0019)
    {
        __FinalOutput.Color = float4(0, 0, 0, 0);
        return __FinalOutput;
    }
    if (Game__SimShader__Something__data(select) && !(Game__SimShader__Something__data(here)))
    {
        if (Game__UnitDistribution__Contains__Single__vec2__Field(psin, 3, psin.TexCoords * fs_param_Select_size, fs_param_Corpses, fs_param_Corpses_size, fs_param_Corpses_dxdy))
        {
            __FinalOutput.Color = select;
            return __FinalOutput;
        }
    }
    __FinalOutput.Color = float4(0, 0, 0, 0);
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