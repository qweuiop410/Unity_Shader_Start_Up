Shader "Custom/NewSurfaceShader 6"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
	}

    SubShader
    {
        Tags { "RenderType"="Opaque" }
		cull off
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
			float4 color:Color;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            //o.Albedo = c.rgb;
			o.Albedo = c.rgb * IN.color.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
