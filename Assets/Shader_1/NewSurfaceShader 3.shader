Shader "Custom/NewSurfaceShader 3"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SpeedY ("Speed Y",Range(-1,1)) = 0
		_SpeedX ("Speed X",Range(-1,1)) = 0
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
        };

		float _SpeedY;
		float _SpeedX;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			//fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			//fixed4 c = tex2D(_MainTex, IN.uv_MainTex + _SinTime.w);
			//fixed4 c = tex2D(_MainTex, float2(IN.uv_MainTex.x * _SinTime.w,IN.uv_MainTex.y));
			fixed4 c = tex2D(_MainTex, float2(IN.uv_MainTex.x * _SinTime.w * _SpeedX, IN.uv_MainTex.y * _SinTime.w * _SpeedY));

            o.Albedo = c.rgb;
			//o.Emission = IN.uv_MainTex.x;
			//o.Emission = IN.uv_MainTex.y;
			//o.Emission = float3(IN.uv_MainTex.x, IN.uv_MainTex.y, 0);
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
