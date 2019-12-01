Shader "Custom/Line"
{
    Properties
    {
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
		_LineSpeed("Speed",Range(-30,30)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Transparent"}
		cull off

        CGPROGRAM
        #pragma surface surf Standard alpha:fade

		sampler2D _MainTex;
		float _LineSpeed;

        struct Input
        {
			float2 uv_MainTex;
        };

		fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			fixed4 c = tex2D(_MainTex, float2(IN.uv_MainTex.x - _Time.x * _LineSpeed, IN.uv_MainTex.y)) * _Color;
            o.Emission = c.rgb;

			//깜빡임 o
			//o.Alpha = c.a * abs(sin(_Time.x * 50));
			//깜빡임 x
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
