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
// Texture Sampler for fs_param_Path, using register location 1
float2 fs_param_Path_size;
float2 fs_param_Path_dxdy;

Texture fs_param_Path_Texture;
sampler fs_param_Path : register(s1) = sampler_state
{
    texture   = <fs_param_Path_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

float fs_param_blend;

// The following variables are included because they are referenced but are not function parameters. Their values will be set at call time.
// Texture Sampler for fs_param_FarColor, using register location 2
float2 fs_param_FarColor_size;
float2 fs_param_FarColor_dxdy;

Texture fs_param_FarColor_Texture;
sampler fs_param_FarColor : register(s2) = sampler_state
{
    texture   = <fs_param_FarColor_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// The following methods are included because they are referenced by the fragment shader.
float FragSharpFramework__FragSharpStd__min__Single__Single__Single(float a, float b, float c)
{
    return min(min(a, b), c);
}

float4 Game__TerritoryColor__Get__Single(VertexToPixel psin, float player)
{
    if (abs(player - 0.003921569) < .0019)
    {
        return tex2D(fs_param_FarColor, float2(2, 1 + (int)player) * fs_param_FarColor_dxdy);
    }
    if (abs(player - 0.007843138) < .0019)
    {
        return tex2D(fs_param_FarColor, float2(2, 2 + (int)player) * fs_param_FarColor_dxdy);
    }
    if (abs(player - 0.01176471) < .0019)
    {
        return tex2D(fs_param_FarColor, float2(2, 3 + (int)player) * fs_param_FarColor_dxdy);
    }
    if (abs(player - 0.01568628) < .0019)
    {
        return tex2D(fs_param_FarColor, float2(2, 4 + (int)player) * fs_param_FarColor_dxdy);
    }
    return float4(0.0, 0.0, 0.0, 0.0);
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
    float4 dist = tex2D(fs_param_Path, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Path_dxdy);
    float4 enemy_dist = float4(FragSharpFramework__FragSharpStd__min__Single__Single__Single(dist.y, dist.z, dist.w), FragSharpFramework__FragSharpStd__min__Single__Single__Single(dist.x, dist.z, dist.w), FragSharpFramework__FragSharpStd__min__Single__Single__Single(dist.x, dist.y, dist.w), FragSharpFramework__FragSharpStd__min__Single__Single__Single(dist.x, dist.y, dist.z));
    float4 clr = float4(0.0, 0.0, 0.0, 0.0);
    float _blend = 1;
    if (dist.x < 0.02745098 - .0019 && dist.x < enemy_dist.x - .0019)
    {
        clr = Game__TerritoryColor__Get__Single(psin, 0.003921569 + ((int)dist.x / 100));
    }
    if (dist.y < 0.02745098 - .0019 && dist.y < enemy_dist.y - .0019)
    {
        clr = Game__TerritoryColor__Get__Single(psin, 0.007843138 + ((int)dist.x / 100));
    }
    if (dist.z < 0.02745098 - .0019 && dist.z < enemy_dist.z - .0019)
    {
        clr = Game__TerritoryColor__Get__Single(psin, 0.01176471 + ((int)dist.x / 100));
    }
    if (dist.w < 0.02745098 - .0019 && dist.w < enemy_dist.w - .0019)
    {
        clr = Game__TerritoryColor__Get__Single(psin, 0.01568628 + ((int)dist.x / 100));
    }
    clr *= _blend;
    clr.a *= fs_param_blend;
    clr.rgb *= clr.a;
    __FinalOutput.Color = clr;
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