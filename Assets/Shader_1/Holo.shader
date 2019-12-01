Shader "Custom/Holo"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue" = "Transparent"}

        CGPROGRAM
        #pragma surface surf Lambert noambient alpha:fade

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
			float3 viewDir;
			float3 worldPos;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			float rim = saturate(dot(o.Normal, IN.viewDir));
			//rim = pow(1 - rim, 3) + pow(frac(IN.worldPos.g * 3 - _Time.y), 30);//frac함수는 소수점만 리턴함 예) 1.1 = 0.1, 2.5 = 0.5
			rim = pow(1 - rim, 3) + frac(IN.worldPos.g * 3 -_Time.y);//frac함수는 소수점만 리턴함 예) 1.1 = 0.1, 2.5 = 0.5

			//o.Emission = pow(1 - rim, 3) + c.rgb;
			o.Emission = float3(0, 1, 0);
			//o.Emission = pow(1 - rim, 3);
			
            //o.Alpha = c.a;
			//o.Alpha = rim * sin(_Time.y * 10);//깜빡이는 효과 추가 1
			//o.Alpha = rim * (sin(_Time.y * 10)*0.5 + 0.5);//깜빡이는 효과 추가 2
			o.Alpha = rim *abs(sin(_Time.y * 3));//깜빡이는 효과 추가 3, abs() 함수는 모듬 음수를 양수로 변환
			//o.Alpha = rim;//홀로그램 효과
			//o.Alpha = 1;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
