Shader "Custom/NewSurfaceShader 5"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_MainTex2("Albedo (RGB)", 2D) = "white" {}
		_fireSpeed("Fire Speed",Range(0,20)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue" = "Transparent"}
		cull off

        CGPROGRAM
        //#pragma surface surf Standard fullforwardshadows
		#pragma surface surf Standard alpha:fade

        sampler2D _MainTex;
		sampler2D _MainTex2;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_MainTex2;
        };

		float _fireSpeed;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float4 d = tex2D(_MainTex2, float2(IN.uv_MainTex2.x,IN.uv_MainTex2.y - _Time.x * _fireSpeed));
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex + d.r);
            //o.Albedo = c.rgb;
			o.Emission = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
