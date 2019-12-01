Shader "Custom/CubeMap"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("Albedo (RGB)", 2D) = "white" {}
		_MaskMap("Albedo (RGB)",2D) = "white" {}
		_Cube("Cubemap",Cube) = ""{}
		_EffectRange("Effect", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
		cull off

        CGPROGRAM
        #pragma surface surf Lambert noambient

        sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _MaskMap;
		samplerCUBE _Cube;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_BumpMap;
			float2 uv_MaskMap;
			float3 worldRefl;
			INTERNAL_DATA
        };

		float _EffectRange;
		 
        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			float4 re = texCUBE(_Cube, WorldReflectionVector(IN,o.Normal));
			float4 m = tex2D(_MaskMap, IN.uv_MaskMap);

			o.Albedo = c.rgb - (1 - _EffectRange) * m.r;
			//o.Albedo = c.rgb * (1 - m.r);
			o.Emission = re.rgb *( (1 - _EffectRange) * m.r);
			//o.Emission = re.rgb * m.r;
            o.Alpha = c.a;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
