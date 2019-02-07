Shader ".RGSMS/BasicTexture"
{
	Properties
	{
		_Color("Main Color:", Color) = (1,1,1,1)
		_MainTexture("Main Texture:", 2D) = "White" {}
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
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXTCOORD0;
			};

			fixed4 _Color;
			sampler2D _MainTexture;

			v2f vert(appdata IN)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(IN.vertex);
				o.uv = IN.uv;
				return o;
			}

			fixed4 frag(v2f IN) : SV_TARGET
			{
				return _Color * tex2D(_MainTexture, IN.uv);
			}

			ENDCG
		}
	}
}
