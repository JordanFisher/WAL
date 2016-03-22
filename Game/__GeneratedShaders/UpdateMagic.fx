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
// Texture Sampler for fs_param_Magic, using register location 1
float2 fs_param_Magic_size;
float2 fs_param_Magic_dxdy;

Texture fs_param_Magic_Texture;
sampler fs_param_Magic : register(s1) = sampler_state
{
    texture   = <fs_param_Magic_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_CurrentData, using register location 2
float2 fs_param_CurrentData_size;
float2 fs_param_CurrentData_dxdy;

Texture fs_param_CurrentData_Texture;
sampler fs_param_CurrentData : register(s2) = sampler_state
{
    texture   = <fs_param_CurrentData_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_PreviousData, using register location 3
float2 fs_param_PreviousData_size;
float2 fs_param_PreviousData_dxdy;

Texture fs_param_PreviousData_Texture;
sampler fs_param_PreviousData : register(s3) = sampler_state
{
    texture   = <fs_param_PreviousData_Texture>;
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

// Texture Sampler for fs_param_Necromancy, using register location 5
float2 fs_param_Necromancy_size;
float2 fs_param_Necromancy_dxdy;

Texture fs_param_Necromancy_Texture;
sampler fs_param_Necromancy : register(s5) = sampler_state
{
    texture   = <fs_param_Necromancy_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// The following variables are included because they are referenced but are not function parameters. Their values will be set at call time.

// The following methods are included because they are referenced by the fragment shader.
bool Game__SimShader__CorpsePresent__corpse(float4 u)
{
    return u.r > 0 + .0019;
}

bool Game__SimShader__Something__data(float4 u)
{
    return u.r > 0 + .0019;
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
    float4 here = tex2D(fs_param_Magic, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Magic_dxdy);
    float4 corpse_here = tex2D(fs_param_Corpses, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Corpses_dxdy);
    float4 necromancy = tex2D(fs_param_Necromancy, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Necromancy_dxdy);
    float4 cur_data = tex2D(fs_param_CurrentData, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_CurrentData_dxdy), prev_data = tex2D(fs_param_PreviousData, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_PreviousData_dxdy);
    here.r = 0.0;
    here.g = 0.0;
    if (Game__SimShader__CorpsePresent__corpse(corpse_here) && !(Game__SimShader__Something__data(cur_data)) && !(Game__SimShader__Something__data(prev_data)))
    {
        float player = 0.0;
        float necro = 0.0;
        if (necromancy.r > necro + .0019)
        {
            necro = necromancy.r;
            player = 0.003921569;
        }
        if (necromancy.g > necro + .0019)
        {
            necro = necromancy.g;
            player = 0.007843138;
        }
        if (necromancy.b > necro + .0019)
        {
            necro = necromancy.b;
            player = 0.01176471;
        }
        if (necromancy.a > necro + .0019)
        {
            necro = necromancy.a;
            player = 0.01568628;
        }
        here.g = player;
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