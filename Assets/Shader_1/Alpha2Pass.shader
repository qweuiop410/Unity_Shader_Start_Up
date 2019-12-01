Shader "Custom/Alpha2Pass"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_AlphaValue("Alpha", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Transparent"  "Queue" = "Transparent"}
        
		zwrite on
		ColorMask 0
		CGPROGRAM
		#pragma surface surf nolight noambient noforwardadd nolightmap novertexlights noshadow

		struct Input
		{
			float4 color:COLOR;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
		}

		float4 Lightingnolight(SurfaceOutput s, float3 lightDir, float atten)
		{
			return float4(0, 0, 0, 0);
		}
		ENDCG

		zwrite on
		ColorMask 0

		CGPROGRAM
		#pragma surface surf Lambert alpha:fade
		sampler2D _MainTex;
		float _AlphaValue;

		struct Input
		{
			float2 uv_MainTex;

			float3 viewDir;
			float3 worldPos;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			float4 c = tex2D(_MainTex, IN.uv_MainTex);
			float rim = saturate(dot(o.Normal, IN.viewDir));
			//rim = pow(1 - rim, 3) + pow(frac(IN.worldPos.g * 3 - _Time.y), 30);//frac함수는 소수점만 리턴함 예) 1.1 = 0.1, 2.5 = 0.5
			rim = pow(1 - rim, 3) + frac(IN.worldPos.g * 3 + _Time.y);//frac함수는 소수점만 리턴함 예) 1.1 = 0.1, 2.5 = 0.5
			o.Emission = 1;// float3(0.1, 0.1, 0.1);

			o.Albedo = c.rgb;
			//o.Alpha = _AlphaValue * rim;
			o.Alpha = _AlphaValue * rim * (sin(_Time.y) * 0.5 + 0.5);
		}
		ENDCG
    }
    FallBack "Diffuse"
}
