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
// Texture Sampler for fs_param_Data, using register location 1
float2 fs_param_Data_size;
float2 fs_param_Data_dxdy;

Texture fs_param_Data_Texture;
sampler fs_param_Data : register(s1) = sampler_state
{
    texture   = <fs_param_Data_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_Unit, using register location 2
float2 fs_param_Unit_size;
float2 fs_param_Unit_dxdy;

Texture fs_param_Unit_Texture;
sampler fs_param_Unit : register(s2) = sampler_state
{
    texture   = <fs_param_Unit_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_TargetData, using register location 3
float2 fs_param_TargetData_size;
float2 fs_param_TargetData_dxdy;

Texture fs_param_TargetData_Texture;
sampler fs_param_TargetData : register(s3) = sampler_state
{
    texture   = <fs_param_TargetData_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

float2 fs_param_Destination_BL;

float2 fs_param_Selection_BL;

float2 fs_param_ConversionRatio;


// The following variables are included because they are referenced but are not function parameters. Their values will be set at call time.

// The following methods are included because they are referenced by the fragment shader.
bool Game__SimShader__selected__data(float4 u)
{
    float val = u.b;
    return val >= 0.3764706 - .0019;
}

bool Game__SimShader__IsUnit__Single(float type)
{
    return type >= 0.003921569 - .0019 && type < 0.02352941 - .0019;
}

bool Game__SimShader__IsBuilding__Single(float type)
{
    return type >= 0.02352941 - .0019 && type < 0.07843138 - .0019;
}

bool Game__SimShader__IsSpecialUnit__Single(float type)
{
    return abs(type - 0.007843138) < .0019 || abs(type - 0.01176471) < .0019;
}

bool Game__SimShader__IsSoldierUnit__Single(float type)
{
    return Game__SimShader__IsUnit__Single(type) && !(Game__SimShader__IsSpecialUnit__Single(type));
}

bool Game__SelectionFilter__FilterHasUnit__Single__Single(float filter, float type)
{
    if (abs(filter - 0.0) < .0019)
    {
        return true;
    }
    if (abs(filter - 1.0) < .0019)
    {
        return Game__SimShader__IsUnit__Single(type);
    }
    if (abs(filter - 2.0) < .0019)
    {
        return Game__SimShader__IsBuilding__Single(type);
    }
    if (abs(filter - 3.0) < .0019)
    {
        return Game__SimShader__IsSoldierUnit__Single(type);
    }
    if (abs(filter - 4.0) < .0019)
    {
        return Game__SimShader__IsSpecialUnit__Single(type);
    }
    return false;
}

float2 Game__SimShader__pack_val_2byte__Single(float x)
{
    float2 packed = float2(0, 0);
    packed.x = floor(x / 256.0);
    packed.y = x - packed.x * 256.0;
    return packed / 255.0;
}

float4 Game__SimShader__pack_vec2__vec2(float2 v)
{
    float2 packed_x = Game__SimShader__pack_val_2byte__Single(v.x);
    float2 packed_y = Game__SimShader__pack_val_2byte__Single(v.y);
    return float4(packed_x.x, packed_x.y, packed_y.x, packed_y.y);
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
    float4 data_here = tex2D(fs_param_Data, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Data_dxdy);
    float4 unit_here = tex2D(fs_param_Unit, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Unit_dxdy);
    float4 target = float4(0, 0, 0, 0);
    if (abs(0.003921569 - unit_here.g) < .0019 && Game__SimShader__selected__data(data_here) && Game__SelectionFilter__FilterHasUnit__Single__Single(0, unit_here.r))
    {
        float2 pos = psin.TexCoords * fs_param_Data_size;
        pos = (pos - fs_param_Selection_BL);
        pos = pos * fs_param_ConversionRatio + fs_param_Destination_BL;
        pos = round(pos);
        target = Game__SimShader__pack_vec2__vec2(pos);
    }
    else
    {
        target = tex2D(fs_param_TargetData, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_TargetData_dxdy);
    }
    __FinalOutput.Color = target;
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