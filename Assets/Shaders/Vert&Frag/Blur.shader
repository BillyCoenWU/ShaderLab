Shader "RGSMS/Vertex/Blur"
{
	Properties
	{
		[PerRendererData]_MainTexture("Main Texture:", 2D) = "white" {}
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
				fixed4 s = tex2D(_MainTexture, IN.uv) * 0.38774;

				s += tex2D(_MainTexture, IN.uv + float2(2.0, 2.0)) * 0.06136;
				s += tex2D(_MainTexture, IN.uv + float2(1.0, 1.0)) * 0.24477;
				s += tex2D(_MainTexture, IN.uv + float2(-1.0, -1.0)) * 0.24477;
				s += tex2D(_MainTexture, IN.uv + float2(-2.0, -2.0)) * 0.06136;

				return s;
			}
			ENDCG
		}
	}
}
