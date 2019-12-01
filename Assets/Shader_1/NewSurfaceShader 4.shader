Shader "Custom/NewSurfaceShader 4"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_MainTex2("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
		//반투명을 사용할때 "Queue" = "Transparent" 필요
        Tags { "RenderType"="Opaque" "Queue" = "Transparent"}
		cull off
        LOD 200

        CGPROGRAM
        //#pragma surface surf Standard fullforwardshadows
		//반투명을 사용할때 필요
		#pragma surface surf Standard alpha:fade

        sampler2D _MainTex;
		sampler2D _MainTex2;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_MainTex2;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 d = tex2D(_MainTex2, float2(IN.uv_MainTex2.x, IN.uv_MainTex2.y - _Time.y));
            //o.Albedo = c.rgb;
			//o.Emission = d.rgb;
			o.Emission = c.rgb * d.rgb;
            o.Alpha = c.a * d.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
