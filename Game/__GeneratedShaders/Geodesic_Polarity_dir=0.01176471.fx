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
// Texture Sampler for fs_param_Dirward, using register location 1
float2 fs_param_Dirward_size;
float2 fs_param_Dirward_dxdy;

Texture fs_param_Dirward_Texture;
sampler fs_param_Dirward : register(s1) = sampler_state
{
    texture   = <fs_param_Dirward_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_Geo, using register location 2
float2 fs_param_Geo_size;
float2 fs_param_Geo_dxdy;

Texture fs_param_Geo_Texture;
sampler fs_param_Geo : register(s2) = sampler_state
{
    texture   = <fs_param_Geo_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_ShiftedGeo, using register location 3
float2 fs_param_ShiftedGeo_size;
float2 fs_param_ShiftedGeo_dxdy;

Texture fs_param_ShiftedGeo_Texture;
sampler fs_param_ShiftedGeo : register(s3) = sampler_state
{
    texture   = <fs_param_ShiftedGeo_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_Info, using register location 4
float2 fs_param_Info_size;
float2 fs_param_Info_dxdy;

Texture fs_param_Info_Texture;
sampler fs_param_Info : register(s4) = sampler_state
{
    texture   = <fs_param_Info_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_ShiftedInfo, using register location 5
float2 fs_param_ShiftedInfo_size;
float2 fs_param_ShiftedInfo_dxdy;

Texture fs_param_ShiftedInfo_Texture;
sampler fs_param_ShiftedInfo : register(s5) = sampler_state
{
    texture   = <fs_param_ShiftedInfo_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};


// The following variables are included because they are referenced but are not function parameters. Their values will be set at call time.

// The following methods are included because they are referenced by the fragment shader.
float Game__SimShader__unpack_val__vec2(float2 packed)
{
    float coord = 0;
    packed = floor(255.0 * packed + float2(0.5, 0.5));
    coord = 256 * packed.x + packed.y;
    return coord;
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
    float4 geo_here = tex2D(fs_param_Geo, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Geo_dxdy), geo_shift = tex2D(fs_param_ShiftedGeo, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_ShiftedGeo_dxdy);
    if (abs(geo_here.r - 0.0) < .0019)
    {
        __FinalOutput.Color = float4(0, 0, 0, 0);
        return __FinalOutput;
    }
    float4 info_here = tex2D(fs_param_Info, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Info_dxdy), info_shift = tex2D(fs_param_ShiftedInfo, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_ShiftedInfo_dxdy);
    if (any(abs(geo_here.gba - geo_shift.gba) > .0019))
    {
        __FinalOutput.Color = tex2D(fs_param_Dirward, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Dirward_dxdy);
        return __FinalOutput;
    }
    float dist_here = Game__SimShader__unpack_val__vec2(info_here.xy), dist_shift = Game__SimShader__unpack_val__vec2(info_shift.xy), circum = Game__SimShader__unpack_val__vec2(info_here.zw);
    float diff = dist_here - dist_shift;
    float clockwise = 0, counterclockwise = 0;
    if (diff > 0 + .0019)
    {
        clockwise = diff;
        counterclockwise = circum - diff;
    }
    else
    {
        clockwise = circum + diff;
        counterclockwise = -(diff);
    }
    float4 output = float4(0, 0, 0, 0);
    output.a = clockwise > counterclockwise + .0019 ? 0 : 1;
    output.g = 0.003921569;
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