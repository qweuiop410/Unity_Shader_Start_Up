Shader "Custom/PositionColor"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;

			float3 worldPos;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            //o.Albedo = c.rgb;
			//o.Albedo = float3(IN.worldPos.x, IN.worldPos.y, IN.worldPos.z);
			o.Emission = float3(IN.worldPos.x, IN.worldPos.y, IN.worldPos.z);
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
