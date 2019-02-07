Shader ".RGSMS/UV2"
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
				float4 uv1 : TEXCOORD1;
			};

			struct v2f
			{
				float4 position : SV_POSITION;
				float4 uv : TEXCOORD0;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.position = UnityObjectToClipPos(v.position);
				o.uv = float4(v.uv1.xy, 0, 0);
				return o;
			}
			
			half4 frag (v2f i) : SV_Target
			{
				half4 c = frac(i.uv);

				if (any(saturate(i.uv) - i.uv))
				{
					c.b = 0.5;
				}

				return c;
			}
			ENDCG
		}
	}
}
