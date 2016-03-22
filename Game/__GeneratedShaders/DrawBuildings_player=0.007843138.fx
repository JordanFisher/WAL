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
// Texture Sampler for fs_param_Buildings, using register location 1
float2 fs_param_Buildings_size;
float2 fs_param_Buildings_dxdy;

Texture fs_param_Buildings_Texture;
sampler fs_param_Buildings : register(s1) = sampler_state
{
    texture   = <fs_param_Buildings_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_Units, using register location 2
float2 fs_param_Units_size;
float2 fs_param_Units_dxdy;

Texture fs_param_Units_Texture;
sampler fs_param_Units : register(s2) = sampler_state
{
    texture   = <fs_param_Units_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

// Texture Sampler for fs_param_Texture, using register location 3
float2 fs_param_Texture_size;
float2 fs_param_Texture_dxdy;

Texture fs_param_Texture_Texture;
sampler fs_param_Texture : register(s3) = sampler_state
{
    texture   = <fs_param_Texture_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Wrap;
    AddressV  = Wrap;
};

// Texture Sampler for fs_param_Explosion, using register location 4
float2 fs_param_Explosion_size;
float2 fs_param_Explosion_dxdy;

Texture fs_param_Explosion_Texture;
sampler fs_param_Explosion : register(s4) = sampler_state
{
    texture   = <fs_param_Explosion_Texture>;
    MipFilter = Point;
    MagFilter = Point;
    MinFilter = Point;
    AddressU  = Wrap;
    AddressV  = Wrap;
};

float fs_param_s;

// The following variables are included because they are referenced but are not function parameters. Their values will be set at call time.

// The following methods are included because they are referenced by the fragment shader.
bool Game__SimShader__IsBuilding__Single(float type)
{
    return type >= 0.02352941 - .0019 && type < 0.07843138 - .0019;
}

bool Game__SimShader__IsBuilding__unit(float4 u)
{
    return Game__SimShader__IsBuilding__Single(u.r);
}

float2 Game__SimShader__get_subcell_pos__VertexOut__vec2(VertexToPixel vertex, float2 grid_size)
{
    float2 coords = vertex.TexCoords * grid_size + float2(-(0.25), -(0.25));
    float i = floor(coords.x);
    float j = floor(coords.y);
    return coords - float2(i, j);
}

bool Game__SimShader__Something__building(float4 u)
{
    return u.r > 0 + .0019;
}

float Game__ExplosionSpriteSheet__ExplosionFrame__Single__building(float s, float4 building_here)
{
    return (s + 255 * (building_here.r - 0.02745098)) * 6;
}

float4 Game__DrawBuildings__ExplosionSprite__building__unit__vec2__Single__PointSampler(VertexToPixel psin, float4 u, float4 d, float2 pos, float frame, sampler Texture, float2 Texture_size, float2 Texture_dxdy)
{
    if (pos.x > 1 + .0019 || pos.y > 1 + .0019 || pos.x < 0 - .0019 || pos.y < 0 - .0019)
    {
        return float4(0.0, 0.0, 0.0, 0.0);
    }
    pos += 255 * float2(u.g, u.a);
    pos.x += floor(frame) * 3;
    pos *= float2(1.0 / 48, 1.0 / 3);
    return tex2D(Texture, pos);
}

bool Game__SimShader__fake_selected__data(float4 u)
{
    float val = u.b;
    return 0.1254902 <= val + .0019 && val < 0.5019608 - .0019;
}

bool Game__SimShader__fake_selected__building(float4 u)
{
    return Game__SimShader__fake_selected__data(u);
}

float2 FragSharpFramework__FragSharpStd__Float__vec2(float2 v)
{
    return floor(255 * v + float2(0.5, 0.5));
}

float FragSharpFramework__FragSharpStd__Float__Single(float v)
{
    return floor(255 * v + 0.5);
}

float Game__UnitType__BuildingIndex__Single(float type)
{
    return type - 0.02352941;
}

float4 Game__DrawBuildings__Sprite__Single__building__unit__vec2__Single__PointSampler(VertexToPixel psin, float player, float4 b, float4 u, float2 pos, float frame, sampler Texture, float2 Texture_size, float2 Texture_dxdy)
{
    if (pos.x > 1 + .0019 || pos.y > 1 + .0019 || pos.x < 0 - .0019 || pos.y < 0 - .0019)
    {
        return float4(0.0, 0.0, 0.0, 0.0);
    }
    bool draw_selected = abs(u.g - player) < .0019 && Game__SimShader__fake_selected__building(b);
    float selected_offset = draw_selected ? 3 : 0;
    pos += FragSharpFramework__FragSharpStd__Float__vec2(float2(b.g, b.a));
    pos.x += FragSharpFramework__FragSharpStd__Float__Single(u.g) * 3;
    pos.y += selected_offset + 6 * FragSharpFramework__FragSharpStd__Float__Single(Game__UnitType__BuildingIndex__Single(u.r));
    pos *= float2(1.0 / 15, 1.0 / 30);
    return tex2D(Texture, pos);
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
    float4 building_here = tex2D(fs_param_Buildings, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Buildings_dxdy);
    float4 unit_here = tex2D(fs_param_Units, psin.TexCoords + (-float2(0.25,0.25) + float2(0, 0)) * fs_param_Units_dxdy);
    if (!(Game__SimShader__IsBuilding__unit(unit_here)))
    {
        __FinalOutput.Color = output;
        return __FinalOutput;
    }
    float2 subcell_pos = Game__SimShader__get_subcell_pos__VertexOut__vec2(psin, fs_param_Buildings_size);
    if (Game__SimShader__Something__building(building_here))
    {
        if (building_here.r >= 0.02745098 - .0019)
        {
            float frame = Game__ExplosionSpriteSheet__ExplosionFrame__Single__building(fs_param_s, building_here);
            if (frame < 16 - .0019)
            {
                output += Game__DrawBuildings__ExplosionSprite__building__unit__vec2__Single__PointSampler(psin, building_here, unit_here, subcell_pos, frame, fs_param_Explosion, fs_param_Explosion_size, fs_param_Explosion_dxdy);
            }
        }
        else
        {
            float frame = 0;
            output += Game__DrawBuildings__Sprite__Single__building__unit__vec2__Single__PointSampler(psin, 0.007843138, building_here, unit_here, subcell_pos, frame, fs_param_Texture, fs_param_Texture_size, fs_param_Texture_dxdy);
        }
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