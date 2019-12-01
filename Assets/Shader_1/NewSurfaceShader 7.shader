Shader "Custom/NewSurfaceShader 7"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SubTex1("Albedo (RGB)", 2D) = "white" {}
		_SubTex2("Albedo (RGB)", 2D) = "white" {}
		_SubTex3("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
		cull off
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
		sampler2D _SubTex1;
		sampler2D _SubTex2;
		sampler2D _SubTex3;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_SubTex1;
			float2 uv_SubTex2;
			float2 uv_SubTex3;

			float4 color:COLOR;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			float4 d = tex2D(_SubTex1, IN.uv_SubTex1);
			float4 e = tex2D(_SubTex2, IN.uv_SubTex2);
			float4 f = tex2D(_SubTex3, IN.uv_SubTex3);
            //o.Albedo = c.rgb;
			o.Albedo = lerp(c.rgb, d.rgb, IN.color.r);
			o.Albedo = lerp(o.Albedo, e.rgb, IN.color.g);
			o.Albedo = lerp(o.Albedo, f.rgb, IN.color.b);
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
