﻿Shader ".RGSMS/FixedColor"
{
	Properties
	{
		_Color ("Main Color:", Color) = (1,1,1,1)
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
			};

			fixed4 _Color;

			v2f vert (appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}

			fixed4 frag (v2f v) : COLOR
			{
				return _Color;
			}

			ENDCG
		}
	}
}