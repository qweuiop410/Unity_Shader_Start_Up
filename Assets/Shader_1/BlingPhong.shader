Shader "Custom/BlingPhong"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SpecColor ("Specular Color", color) = (1,1,1,1)//예약어 이므로 단어를 바꾸면 안되고, 이곳에 만들면 float4 _SpecCulor 처럼 추가로 더 안써도됨
		_GrossValue("Specular Size",Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
		cull off

        CGPROGRAM
        #pragma surface surf BlinnPhong noambient

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

		float _GrossValue;

		void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
			o.Specular = 0.5;
			o.Gloss = 1;// 0~1사이의 값을 사용/ SpecCular의 크기를 의미, 0이면 커지고 1이면 작아짐
        }
        ENDCG
    }
    FallBack "Diffuse"
}
