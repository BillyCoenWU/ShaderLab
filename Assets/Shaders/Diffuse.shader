Shader ".RGSMS/Diffuse"
{
	Properties
	{
		_Color("Main Color:", Color) = (1,1,1,1)
		_MainTexture("Main Texture:", 2D) = "White" {}
	}

	SubShader //Vc pode ter mais de 1 subshader para trabalhar com coisas mais "complexas" q deveriam funcionar para por exmeplo, sistemas mais complexos e "pesados"
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			struct appdata
			{
				float3 normal : NORMAL;
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				//float4 pos : SV_POSITION; //usar caso seja trabalhado para Playstation 4, pois eles esperam q usem o SV_POSITION
				float4 pos : POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXTCOORD0;
			};

			fixed4 _Color;
			float4 _LightColor0;
			sampler2D _MainTexture;

			v2f vert (appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.normal = mul(float4(v.normal, 0.0f), unity_ObjectToWorld).xyz;
				o.texcoord = v.texcoord;
				return o;
			}

			fixed4 frag (v2f v) : COLOR
			{
				fixed4 texColor = tex2D(_MainTexture, v.texcoord);

				float3 normalDirection = normalize(v.normal);
				float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
				float3 diffuse = _LightColor0.rgb * max(0.0, dot(normalDirection, lightDirection));

				return _Color * texColor * float4(diffuse, 1);
			}

			ENDCG
		}
	}
}
