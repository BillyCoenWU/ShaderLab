Shader "RGSMS/Vertex/FixedColorWithAlpha"
{
	Properties
	{
		_Color("Main Color:", Color) = (1,1,1,1)
	}

	SubShader
	{
		tags
		{
			"Queue" = "Transparent"
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha

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

			fixed4 _Color;

			v2f vert(appdata IN)
			{
				v2f o;
				o.position = UnityObjectToClipPos(IN.vertex);
				return o;
			}

			fixed4 frag(v2f IN) : COLOR
			{
				return _Color;
			}
			ENDCG
		}
	}
}
