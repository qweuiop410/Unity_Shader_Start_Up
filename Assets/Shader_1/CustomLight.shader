Shader "Custom/CustomLight"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_NormalMap("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
		//#pragma surface surf Test noambient
		#pragma surface surf Test

        sampler2D _MainTex;
		sampler2D _NormalMap;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_NormalMap;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
            o.Alpha = c.a;
        }

		float4 LightingTest(SurfaceOutput s, float3 lightDir, float atten)
		{
			//float ndotl = dot(s.Normal, lightDir); // 밝음과 어둠의 범위가 -1 ~ 1 임
			float ndotl = dot(s.Normal, lightDir) * 0.5 + 0.5; // Half-Lambert(하프 램버트)공식
			//float ndotl = saturate(dot(s.Normal, lightDir)); // 밝음과 어둠의 범위가 0 ~ 1
			//float ndotl = max(0,dot(s.Normal, lightDir)); //어둠의 값이 0 이하이면 0으로 처리

			float4 final;
			final.rgb = ndotl * s.Albedo * _LightColor0.rgb * atten;
			final.a = s.Alpha;

			//return ndotl;
			//return pow(ndotl,3); // Half-Lambert(하프 램버트)공식에 3을 제곱한다
			return final;
		}

        ENDCG
    }
    FallBack "Diffuse"
}
