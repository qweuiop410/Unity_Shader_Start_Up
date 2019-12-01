﻿Shader "Custom/CustomBlending"
{
    Properties
    {
		_TintColor("Tint Color", Color) = (0.5,0.5,0.5,0.5)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		[Enum(UnityEngine.Rendering.BlendMode)]_SrcBlend("SrcBlend Mode",Float) = 5	
		[Enum(UnityEngine.Rendering.BlendMode)]_DstBlend("DstBlend Mode",Float)=10
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Transparent" "IgnoreProjector"="True"}
		zwrite off
		blend [_Srcblend][_DstBlend]
		cull off

        CGPROGRAM
        #pragma surface surf Lambert keepalpha noforwardadd nolightmap noambient novertexlights noshadow

        sampler2D _MainTex;
		float4 _TintColor;

        struct Input
        {
            float2 uv_MainTex;
			float4 color:COLOR;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			c = c * 2 * _TintColor * IN.color;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

		float4 Lightingnolight(SurfaceOutput s, float3 lightDir, float atten)
		{
			return float4(0, 0, 0, s.Alpha);
		}

        ENDCG
    }
    FallBack "Legacy Shaders/Transparent/VertexLit"
}
