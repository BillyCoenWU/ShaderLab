Shader "RGSMS/Vertex/Diffuse"
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
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXTCOORD0;
			};

			fixed4 _Color;
			float4 _LightColor0;
			sampler2D _MainTexture;

			v2f vert (appdata IN)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(IN.vertex);
				o.normal = mul(float4(IN.normal, 0.0f), unity_ObjectToWorld).xyz; // mul = multiply a matrix by a column vector, row vector by a matrix, or matrix by a matrix
				o.uv = IN.uv;
				return o;
			}

			fixed4 frag (v2f IN) : SV_TARGET /*: COLOR*/
			{
				fixed4 texColor = tex2D(_MainTexture, IN.uv); // Metodo usado para combinar uma textura com a UV

				float3 normalDirection = normalize(IN.normal);
				float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
				float3 diffuse = _LightColor0.rgb * max(0.0, dot(normalDirection, lightDirection));

				return _Color * texColor * float4(diffuse, 1);
			}

			ENDCG
		}
	}
}
