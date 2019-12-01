Shader "Custom/NewSurfaceShader 8"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Metallic("Metallic", Range(0,1)) = 0
		_Smoothness("Smoothness",Range(0,1)) = 0
		_NormalMap("Normal Map", 2D) = "white" {}
		_NormalForce("Normal Force", Range(0,3)) = 0
		_Occlusion("_Occlusion",2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
		cull off
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
		sampler2D _NormalMap;
		sampler2D _Occlusion;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_NormalMap;
        };

		float _Metallic;
		float _Smoothness;
		float _NormalForce;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			//float4 d = tex2D(_NormalMap, IN.uv_NormalMap);
			float3 n = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
			o.Normal = float3(n.r * _NormalForce, n.g * _NormalForce, n.b);

			o.Occlusion = tex2D(_Occlusion, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Smoothness = _Smoothness;
			o.Metallic = _Metallic;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
