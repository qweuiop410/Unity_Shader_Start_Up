Shader "Custom/Water"	
{
    Properties
    {
		_Bumpmap("NormalMap",2D) = "bump" {}
		_Cuve("Cube", Cube) = "" {}
		_SPColor("Specular Color",color) = (1,1,1,1)
		_SPPower("Specular Power",Range(50,300))=150
		_SPMulti("Specular Multiply",Range(1,10))=3
		_Refract("Refract Strength", Range(0,0.2)) = 0.1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent"}
		Cull off

        CGPROGRAM
        #pragma surface surf WaterSpecular alpha:fade vertex:vert

        samplerCUBE _Cube;
		sampler2D _Bumpmap;
		sampler2D _GrabTexture;
		float4 _SPColor;
		float _SPPower;
		float _SPMulti;
		float _Refract;

		void vert(inout appdata_full v)
		{
			float movement;
			movement = sin(abs((v.texcoord.x * 2 - 1) * 12) + _Time.y) * 0.2;
			movement += sin(abs((v.texcoord.x * 2 - 1) * 12) + _Time.y) * 0.2;

			movement += sin(abs((v.texcoord.y * 2 - 1) * 12) + _Time.y * 2) * 0.3;

			v.vertex.y += movement / 2;
		}

        struct Input
        {
			float2 uv_Bumpmap;
			float3 worldRefl;
			float3 viewDir;
			float4 screenPos;
			INTERNAL_DATA
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
			float3 normal1 = UnpackNormal(tex2D(_Bumpmap, IN.uv_Bumpmap + _Time.x * 0.1));
			float3 normal2 = UnpackNormal(tex2D(_Bumpmap, IN.uv_Bumpmap - _Time.x * 0.1));
			//o.Normal = UnpackNormal(tex2D(_Bumpmap, IN.uv_Bumpmap));
			o.Normal = (normal1 + normal2) / 2;

			float3 refcolor = texCUBE(_Cube, WorldReflectionVector(IN, o.Normal));

			float3 screenUV = IN.screenPos.rgb / IN.screenPos.a;
			float3 refraction = tex2D(_GrabTexture, (screenUV.xy + o.Normal.xy * _Refract));

			float rim = saturate(dot(o.Normal, IN.viewDir));
			rim = pow(1 - rim, 1.5);

			o.Emission = (refcolor * rim + refraction) * 0.5;
            //o.Alpha = saturate(rim + 0.5);
			o.Alpha = 1;
        }

		float4 LightingWaterSpecular(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten)
		{
			float3 H = normalize(lightDir + viewDir);
			float spec = saturate(dot(H, s.Normal));
			spec = pow(spec, _SPPower);

			float4 finalColor;
			finalColor.rgb = spec * _SPColor.rgb * _SPMulti;
			finalColor.a = s.Alpha + spec;

			return finalColor;
		}

        ENDCG
    }
    FallBack "Legacy Shaders/Transparent/Vertexlit"
}
