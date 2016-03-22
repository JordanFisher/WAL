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
// Texture Sampler for fs_param_Target, using register location 1
float2 fs_param_Target_size;
float2 fs_param_Target_dxdy;

Texture fs_param_Target_Texture;
sampler fs_param_Target : register(s1) = sampler_state
{
    texture   = <fs_param_Target_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};


// The following variables are included because they are referenced but are not function parameters. Their values will be set at call time.

// The following methods are included because they are referenced by the fragment shader.
bool Game__MakeSymmetricBase__DoNothing__Sampler__vec2__Single(VertexToPixel psin, sampler Units, float2 Units_size, float2 Units_dxdy, float2 pos, float type)
{
    if (abs(type - 0.0) < .0019)
    {
        if (all(pos < Units_size / 2 - .0019))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    if (abs(type - 1.0) < .0019)
    {
        if (all(pos < Units_size / 4 - .0019))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    return true;
}

float2 Game__MakeSymmetricBase__QuadMirrorShift__Sampler__vec2__Single(VertexToPixel psin, sampler Info, float2 Info_size, float2 Info_dxdy, float2 pos, float type)
{
    float2 shift = float2(0, 0);
    if (abs(type - 0.0) < .0019)
    {
        if (pos.x > Info_size.x / 2 + .0019)
        {
            shift.x = 2 * pos.x - Info_size.x;
        }
        if (pos.y > Info_size.y / 2 + .0019)
        {
            shift.y = 2 * pos.y - Info_size.y;
        }
    }
    if (abs(type - 1.0) < .0019)
    {
        if (pos.x > Info_size.x / 4 + .0019)
        {
            shift.x = 2 * pos.x - Info_size.x / 2;
        }
        if (pos.y > Info_size.y / 4 + .0019)
        {
            shift.y = 2 * pos.y - Info_size.y / 2;
        }
    }
    return float2(shift.x, shift.y);
}

float Game__SimShader__unpack_val__vec2(float2 packed)
{
    float coord = 0;
    packed = floor(255.0 * packed + float2(0.5, 0.5));
    coord = 256 * packed.x + packed.y;
    return coord;
}

float2 Game__SimShader__unpack_vec2__vec4(float4 packed)
{
    float2 v = float2(0, 0);
    v.x = Game__SimShader__unpack_val__vec2(packed.rg);
    v.y = Game__SimShader__unpack_val__vec2(packed.ba);
    return v;
}

float2 Game__MakeSymmetricBase__QuadMirrorTarget__Sampler__vec2__vec2__Single(VertexToPixel psin, sampler Info, float2 Info_size, float2 Info_dxdy, float2 pos, float2 target, float type)
{
    if (abs(type - 0.0) < .0019)
    {
        if (pos.x > Info_size.x / 2 + .0019)
        {
            target.x = Info_size.x - target.x;
        }
        if (pos.y > Info_size.y / 2 + .0019)
        {
            target.y = Info_size.y - target.y;
        }
    }
    if (abs(type - 1.0) < .0019)
    {
        if (pos.x > Info_size.x / 4 + .0019)
        {
            target.x = Info_size.x / 2 - target.x;
        }
        if (pos.y > Info_size.y / 4 + .0019)
        {
            target.y = Info_size.y / 2 - target.y;
        }
    }
    return target;
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
    float4 info = tex2D(fs_param_Target, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Target_dxdy);
    float2 pos = psin.TexCoords * fs_param_Target_size;
    if (Game__MakeSymmetricBase__DoNothing__Sampler__vec2__Single(psin, fs_param_Target, fs_param_Target_size, fs_param_Target_dxdy, pos, 1))
    {
        __FinalOutput.Color = info;
        return __FinalOutput;
    }
    float4 copy = tex2D(fs_param_Target, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0) - Game__MakeSymmetricBase__QuadMirrorShift__Sampler__vec2__Single(psin, fs_param_Target, fs_param_Target_size, fs_param_Target_dxdy, pos, 1)) * fs_param_Target_dxdy);
    float2 target = Game__SimShader__unpack_vec2__vec4(copy);
    target = Game__MakeSymmetricBase__QuadMirrorTarget__Sampler__vec2__vec2__Single(psin, fs_param_Target, fs_param_Target_size, fs_param_Target_dxdy, pos, target, 1);
    copy = Game__SimShader__pack_vec2__vec2(target);
    __FinalOutput.Color = copy;
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