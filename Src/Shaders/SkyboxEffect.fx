//--------------------------------------------------------------------------------------
// SkyboxEffect_VS.hlsl
//
// A sky box rendering helper.
//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
//--------------------------------------------------------------------------------------

#include "SkyboxEffect_Common.hlsli"

[RootSignature(SkyboxRS)]
VSOutputPixelLightingTxTangent SkyboxVS(VSInputNmTxTangent vin)
{
    VSOutputPixelLightingTxTangent vout;

    vout.PositionPS = mul(vin.Position, Skybox_WorldViewProj);
    vout.PositionPS.z = vout.PositionPS.w; // Draw on far plane
    vout.TexCoord = vin.Position.xyz;

    return vout;
}

//--------------------------------------------------------------------------------------
// SkyboxEffect_PS.hlsl
//
// A sky box rendering helper.
//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
//--------------------------------------------------------------------------------------

TextureCube<float4> CubeMap : register(t0);
SamplerState Sampler        : register(s0);

[RootSignature(SkyboxRS)]
float4 SkyboxPS(PSInputPixelLightingTxTangent pin) : SV_TARGET0
{
    return CubeMap.Sample(Sampler, pin.TexCoord);
}
