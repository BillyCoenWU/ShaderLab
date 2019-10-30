// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "RGSMS/Vertex/Specular"
{
	Properties
	{
		_Color	("Main Color:", Color) = (1,1,1,1)
		_SpecColor	("Specular Color:", Color) = (1,1,1,1)

		_SpecShininess("Specular Shininess:", Range(1.0, 100.0)) = 2.0

		_MainTexture ("Main Texture:", 2D) = "White" {}
	}

	SubShader //Vc pode ter mais de 1 subshader para trabalhar com coisas mais "complexas" q deveriam funcionar para por exmeplo, sistemas mais complexos e "pesados"
	{
		Pass
		{
			Tags
			{
				"LightMode" = "ForwardBase"
			}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

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
				float2 texcoord : TEXCOORD0;
				float4 posWorld : TEXCOORD1;
			};

			fixed4 _Color;
			float4 _SpecColor;
			float4 _LightColor0;
			float _SpecShininess;
			sampler2D _MainTexture;
			float4 _MainTexture_ST;

			v2f vert (appdata i)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(i.vertex);
				o.posWorld = mul(unity_ObjectToWorld, i.vertex);
				o.normal = mul(float4(i.normal, 0.0f), unity_ObjectToWorld).xyz;
				o.texcoord = TRANSFORM_TEX(i.texcoord, _MainTexture);
				return o;
			}

			float4 frag (v2f i) : COLOR
			{
				fixed4 texColor = tex2D(_MainTexture, i.texcoord);

				float3 normalDirection = normalize(i.normal);
				float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
				float3 viewDirection = normalize(_WorldSpaceCameraPos - i.posWorld.xyz);
				float3 diffuse = _LightColor0.rgb * _Color.rgb * max(0.0, dot(normalDirection, lightDirection));

				float3 specular;
				if (dot(normalDirection, lightDirection) < 0.0)
				{
					specular = float3(0.0f, 0.0f, 0.0f);
				}
				else
				{
					specular = _LightColor0.rgb * _SpecColor.rgb * pow(max(0.0, dot(reflect(-lightDirection, normalDirection), viewDirection)), _SpecShininess);
				}

				float3 diffuseSpecular = diffuse + specular;

				return float4(diffuseSpecular, 1) * texColor;
			}

			ENDCG
		}
	}
}
