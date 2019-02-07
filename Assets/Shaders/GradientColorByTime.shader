Shader ".RGSMS/GradientColorByTime"
{
	Properties
	{
		_Color("Main Color:", Color) = (1,1,1,1)
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
				float4 position : SV_POSITION;
			};

			float4 _Color;

			v2f vert(appdata IN)
			{
				v2f o;
				o.position = UnityObjectToClipPos(IN.vertex);
				return o;
			}

			float4 frag(v2f IN) : COLOR
			{
				float4 gradientColor = float4(_Color.r, cos(_Time.y), sin(_Time.x), 1);

				return gradientColor;
			}

			ENDCG
		}
	}
}
