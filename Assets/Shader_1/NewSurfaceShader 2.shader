Shader "Custom/NewSurfaceShader 2"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_MainTex2("Albedo (RGB)",2D) = "white"{}
		_Bright ("Bright",Range(0,1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
		cull off
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
		sampler2D _MainTex2;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_MainTex2;
        };

		float _Bright;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 d = tex2D (_MainTex2, IN.uv_MainTex2);

			o.Albedo = lerp(c.rgb,d.rgb, 1 - c.a);
            //o.Albedo = (c.r + c.g + c.b) / 3 * _Bright;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
