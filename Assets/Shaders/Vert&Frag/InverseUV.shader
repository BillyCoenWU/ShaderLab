Shader "RGSMS/Vertex/InverseUV"
{
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 position : POSITION;
				float4 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 position : SV_POSITION;
				float4 uv : TEXCOORD0;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.position = UnityObjectToClipPos(v.position);
				o.uv = float4(v.uv.xy, 0, 0);
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				float4 c = frac(i.uv);

				if (any(saturate(i.uv) - i.uv))
				{
					c.b = 0.5;
				}

				float4 inverse = float4(1.0 - c.r, 1.0 - c.g, 1.0 - c.b, 1);

				return inverse;
			}
			ENDCG
		}
	}
}
