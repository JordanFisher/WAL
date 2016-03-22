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
// Texture Sampler for fs_param_Unit, using register location 1
float2 fs_param_Unit_size;
float2 fs_param_Unit_dxdy;

Texture fs_param_Unit_Texture;
sampler fs_param_Unit : register(s1) = sampler_state
{
    texture   = <fs_param_Unit_Texture>;
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

// Texture Sampler for fs_param_Magic, using register location 4
float2 fs_param_Magic_size;
float2 fs_param_Magic_dxdy;

Texture fs_param_Magic_Texture;
sampler fs_param_Magic : register(s4) = sampler_state
{
    texture   = <fs_param_Magic_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// The following variables are included because they are referenced but are not function parameters. Their values will be set at call time.

// The following methods are included because they are referenced by the fragment shader.
bool Game__SimShader__IsUnit__Single(float type)
{
    return type >= 0.003921569 - .0019 && type < 0.02352941 - .0019;
}

bool Game__SimShader__IsUnit__unit(float4 u)
{
    return Game__SimShader__IsUnit__Single(u.r);
}

bool Game__SimShader__IsStationary__data(float4 d)
{
    return d.r >= 0.01960784 - .0019;
}

bool Game__SimShader__Stayed__data(float4 u)
{
    return Game__SimShader__IsStationary__data(u) || abs(u.g - 0.003921569) < .0019;
}

bool Game__SimShader__IsValid__Single(float direction)
{
    return direction > 0 + .0019;
}

float2 Game__SimShader__dir_to_vec__Single(float direction)
{
    float angle = (float)((direction * 255 - 1) * (3.1415926 / 2.0));
    return Game__SimShader__IsValid__Single(direction) ? float2(cos(angle), sin(angle)) : float2(0, 0);
}

bool Game__SimShader__Something__data(float4 u)
{
    return u.r > 0 + .0019;
}

bool Game__SimShader__IsBuilding__Single(float type)
{
    return type >= 0.02352941 - .0019 && type < 0.07843138 - .0019;
}

bool Game__SimShader__IsBuilding__unit(float4 u)
{
    return Game__SimShader__IsBuilding__Single(u.r);
}

bool Game__SimShader__UnitIsFireImmune__unit(float4 u)
{
    return abs(u.r - 0.01176471) < .0019 || abs(u.r - 0.007843138) < .0019;
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
    float4 unit_here = tex2D(fs_param_Unit, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Unit_dxdy);
    float4 data_here = tex2D(fs_param_Data, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Data_dxdy);
    bool DoRaiseAnim = false;
    if (abs(unit_here.a - 0.2352941) < .0019)
    {
        DoRaiseAnim = true;
    }
    if (Game__SimShader__IsUnit__unit(unit_here))
    {
        unit_here.a = 0.0;
    }
    if (Game__SimShader__Stayed__data(data_here) && abs(unit_here.b - 0.0) > .0019)
    {
        if (Game__SimShader__IsUnit__unit(unit_here) && abs(data_here.a - 0.007843138) < .0019)
        {
            float4 facing = tex2D(fs_param_Unit, psin.TexCoords + (-float2(0.25,0.25) + Game__SimShader__dir_to_vec__Single(data_here.r)) * fs_param_Unit_dxdy);
            if (abs(facing.b - unit_here.b) > .0019 && abs(facing.b - 0.0) > .0019)
            {
                unit_here.a = 0.04705882;
            }
        }
        float4 data_right = tex2D(fs_param_Data, psin.TexCoords + (-float2(0.25,0.25) + float2(1, 0)) * fs_param_Data_dxdy), data_up = tex2D(fs_param_Data, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 1)) * fs_param_Data_dxdy), data_left = tex2D(fs_param_Data, psin.TexCoords + (-float2(0.25,0.25) + float2(-(1), 0)) * fs_param_Data_dxdy), data_down = tex2D(fs_param_Data, psin.TexCoords + (-float2(0.25,0.25) + float2(0, -(1))) * fs_param_Data_dxdy);
        float4 unit_right = tex2D(fs_param_Unit, psin.TexCoords + (-float2(0.25,0.25) + float2(1, 0)) * fs_param_Unit_dxdy), unit_up = tex2D(fs_param_Unit, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 1)) * fs_param_Unit_dxdy), unit_left = tex2D(fs_param_Unit, psin.TexCoords + (-float2(0.25,0.25) + float2(-(1), 0)) * fs_param_Unit_dxdy), unit_down = tex2D(fs_param_Unit, psin.TexCoords + (-float2(0.25,0.25) + float2(0, -(1))) * fs_param_Unit_dxdy);
        float4 rnd = tex2D(fs_param_Random, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Random_dxdy);
        if (abs(unit_here.r - 0.007843138) > .0019 && rnd.x > 0.7 + .0019 || rnd.x > 0.915 + .0019)
        {
            if (Game__SimShader__Something__data(data_right) && abs(unit_right.b - unit_here.b) > .0019 && abs(unit_right.b - 0.0) > .0019 && abs(data_right.r - 0.01176471) < .0019 && abs(data_right.a - 0.007843138) < .0019 && abs(data_right.g - 0.003921569) < .0019 || Game__SimShader__Something__data(data_left) && abs(unit_left.b - unit_here.b) > .0019 && abs(unit_left.b - 0.0) > .0019 && abs(data_left.r - 0.003921569) < .0019 && abs(data_left.a - 0.007843138) < .0019 && abs(data_left.g - 0.003921569) < .0019 || Game__SimShader__Something__data(data_up) && abs(unit_up.b - unit_here.b) > .0019 && abs(unit_up.b - 0.0) > .0019 && abs(data_up.r - 0.01568628) < .0019 && abs(data_up.a - 0.007843138) < .0019 && abs(data_up.g - 0.003921569) < .0019 || Game__SimShader__Something__data(data_down) && abs(unit_down.b - unit_here.b) > .0019 && abs(unit_down.b - 0.0) > .0019 && abs(data_down.r - 0.007843138) < .0019 && abs(data_down.a - 0.007843138) < .0019 && abs(data_down.g - 0.003921569) < .0019)
            {
                if (Game__SimShader__IsBuilding__unit(unit_here))
                {
                    unit_here.a += 0.003921569;
                }
                else
                {
                    unit_here.a = 0.07058824;
                }
            }
        }
    }
    if (Game__SimShader__IsUnit__unit(unit_here) && abs(tex2D(fs_param_Magic, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Magic_dxdy).r - 0.003921569) < .0019 && !(Game__SimShader__UnitIsFireImmune__unit(unit_here)))
    {
        unit_here.a = 0.07058824;
    }
    if (Game__SimShader__IsUnit__unit(unit_here) && DoRaiseAnim)
    {
        unit_here.a = 0.2588235;
    }
    __FinalOutput.Color = unit_here;
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