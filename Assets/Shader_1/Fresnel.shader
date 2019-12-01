Shader "Custom/Fresnel"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("Albedo (RGB)", 2D) = "white" {}
		_RimColor("RimColor", Color) = (1,1,1,1)
		_RimPower("RimPower", Range(1,10)) = 3
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
		sampler2D _BumpMap;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 viewDir;
        };

		float4 _RimColor;
		float _RimPower;

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
			//o.Albedo = 0;

			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));

			float rim = saturate(dot(o.Normal, IN.viewDir));
			//o.Emission = 1 - rim;
			//o.Emission = rim;
			//o.Emission = pow(1 - rim, _RimColor);//제곱 계산 하여 테두리를 더 얇게 만듬
			o.Emission = pow(1 - rim, _RimPower) * _RimColor.rgb;//제곱 계산 하여 테두리를 더 얇게 만고 _RimColor의 RGB값을 곱해 색을 변환
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
