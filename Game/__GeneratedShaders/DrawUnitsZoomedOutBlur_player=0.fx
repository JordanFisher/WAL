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
// Texture Sampler for fs_param_CurrentData, using register location 1
float2 fs_param_CurrentData_size;
float2 fs_param_CurrentData_dxdy;

Texture fs_param_CurrentData_Texture;
sampler fs_param_CurrentData : register(s1) = sampler_state
{
    texture   = <fs_param_CurrentData_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_CurrentUnit, using register location 2
float2 fs_param_CurrentUnit_size;
float2 fs_param_CurrentUnit_dxdy;

Texture fs_param_CurrentUnit_Texture;
sampler fs_param_CurrentUnit : register(s2) = sampler_state
{
    texture   = <fs_param_CurrentUnit_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};


// The following variables are included because they are referenced but are not function parameters. Their values will be set at call time.
// Texture Sampler for fs_param_FarColor, using register location 3
float2 fs_param_FarColor_size;
float2 fs_param_FarColor_dxdy;

Texture fs_param_FarColor_Texture;
sampler fs_param_FarColor : register(s3) = sampler_state
{
    texture   = <fs_param_FarColor_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// The following methods are included because they are referenced by the fragment shader.
bool Game__SimShader__Something__data(float4 u)
{
    return u.r > 0 + .0019;
}

bool Game__SimShader__IsStationary__data(float4 d)
{
    return d.r >= 0.01960784 - .0019;
}

bool Game__SimShader__fake_selected__data(float4 u)
{
    float val = u.b;
    return 0.1254902 <= val + .0019 && val < 0.5019608 - .0019;
}

float4 Game__SelectedUnitColor__Get__Single(VertexToPixel psin, float player)
{
    if (abs(player - 0.003921569) < .0019)
    {
        return tex2D(fs_param_FarColor, float2(1, 1 + (int)player) * fs_param_FarColor_dxdy);
    }
    if (abs(player - 0.007843138) < .0019)
    {
        return tex2D(fs_param_FarColor, float2(1, 2 + (int)player) * fs_param_FarColor_dxdy);
    }
    if (abs(player - 0.01176471) < .0019)
    {
        return tex2D(fs_param_FarColor, float2(1, 3 + (int)player) * fs_param_FarColor_dxdy);
    }
    if (abs(player - 0.01568628) < .0019)
    {
        return tex2D(fs_param_FarColor, float2(1, 4 + (int)player) * fs_param_FarColor_dxdy);
    }
    return float4(0.0, 0.0, 0.0, 0.0);
}

float4 Game__UnitColor__Get__Single(VertexToPixel psin, float player)
{
    if (abs(player - 0.003921569) < .0019)
    {
        return tex2D(fs_param_FarColor, float2(0, 1 + (int)player) * fs_param_FarColor_dxdy);
    }
    if (abs(player - 0.007843138) < .0019)
    {
        return tex2D(fs_param_FarColor, float2(0, 2 + (int)player) * fs_param_FarColor_dxdy);
    }
    if (abs(player - 0.01176471) < .0019)
    {
        return tex2D(fs_param_FarColor, float2(0, 3 + (int)player) * fs_param_FarColor_dxdy);
    }
    if (abs(player - 0.01568628) < .0019)
    {
        return tex2D(fs_param_FarColor, float2(0, 4 + (int)player) * fs_param_FarColor_dxdy);
    }
    return float4(0.0, 0.0, 0.0, 0.0);
}

float4 Game__DrawUnits__SolidColor__Single__data__unit(VertexToPixel psin, float player, float4 data, float4 unit)
{
    return abs(unit.g - player) < .0019 && Game__SimShader__fake_selected__data(data) ? Game__SelectedUnitColor__Get__Single(psin, unit.g) : Game__UnitColor__Get__Single(psin, unit.g);
}

float4 Game__DrawUnits__Presence__Single__data__unit(VertexToPixel psin, float player, float4 data, float4 unit)
{
    return (Game__SimShader__Something__data(data) && !(Game__SimShader__IsStationary__data(data))) ? Game__DrawUnits__SolidColor__Single__data__unit(psin, player, data, unit) : float4(0.0, 0.0, 0.0, 0.0);
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
    float4 data_right = tex2D(fs_param_CurrentData, psin.TexCoords + (-float2(0.25,0.25) + float2(1, 0)) * fs_param_CurrentData_dxdy), data_up = tex2D(fs_param_CurrentData, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 1)) * fs_param_CurrentData_dxdy), data_left = tex2D(fs_param_CurrentData, psin.TexCoords + (-float2(0.25,0.25) + float2(-(1), 0)) * fs_param_CurrentData_dxdy), data_down = tex2D(fs_param_CurrentData, psin.TexCoords + (-float2(0.25,0.25) + float2(0, -(1))) * fs_param_CurrentData_dxdy), data_here = tex2D(fs_param_CurrentData, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_CurrentData_dxdy);
    float4 unit_right = tex2D(fs_param_CurrentUnit, psin.TexCoords + (-float2(0.25,0.25) + float2(1, 0)) * fs_param_CurrentUnit_dxdy), unit_up = tex2D(fs_param_CurrentUnit, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 1)) * fs_param_CurrentUnit_dxdy), unit_left = tex2D(fs_param_CurrentUnit, psin.TexCoords + (-float2(0.25,0.25) + float2(-(1), 0)) * fs_param_CurrentUnit_dxdy), unit_down = tex2D(fs_param_CurrentUnit, psin.TexCoords + (-float2(0.25,0.25) + float2(0, -(1))) * fs_param_CurrentUnit_dxdy), unit_here = tex2D(fs_param_CurrentUnit, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_CurrentUnit_dxdy);
    output = 0.5 * 0.25 * (Game__DrawUnits__Presence__Single__data__unit(psin, 0, data_right, unit_right) + Game__DrawUnits__Presence__Single__data__unit(psin, 0, data_up, unit_up) + Game__DrawUnits__Presence__Single__data__unit(psin, 0, data_left, unit_left) + Game__DrawUnits__Presence__Single__data__unit(psin, 0, data_down, unit_down)) + 0.5 * Game__DrawUnits__Presence__Single__data__unit(psin, 0, data_here, unit_here);
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