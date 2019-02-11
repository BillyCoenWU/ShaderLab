Shader "RGSMS/Vertex/Outline"
{
	Properties
	{
		_MainTexture("Main Texture:", 2D) = "white" {}
		_OutlineColor("Outline Color:", Color) = (1, 1, 1, 1)
		_OutlineSize("Outline Size:", Range(0, 5)) = 0
	}

	SubShader
	{
		Pass
		{
			Tags
			{
				"Queue" = "Transparent"
			}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float3 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXTCOORD0;
				float4 color : COLOR;
			};

			sampler2D _MainTexture;
			float4 _OutlineColor;
			float _OutlineSize;

			v2f vert(appdata IN)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(IN.vertex);
				o.uv = IN.uv;

				float3 normal = mul((float3x3)UNITY_MATRIX_IT_MV, IN.normal);
				float2 offset = TransformViewToProjection(normal.xy);

				o.pos.xy += offset * o.pos.z * _OutlineSize;
				o.color = _OutlineColor;

				return o;
			}

			fixed4 frag(v2f IN) : SV_TARGET
			{
				return tex2D(_MainTexture, IN.uv);
			}

			ENDCG
		}
	}
}
