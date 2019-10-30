Shader "RGSMS/Vertex/Normal Extrude"
{
	Properties
	{
		_MainTexture("Main Texture:", 2D) = "White" {}

		_NormalX("Normal X Multuply:", range(-1, 1)) = 0
		_NormalY("Normal Y Multuply:", range(-1, 1)) = 0
		_NormalZ("Normal X Multuply:", range(-1, 1)) = 0
	}

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
				float3 normal : NORMAL;
				float3 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 position : SV_POSITION;
				float3 normal : NORMAL;
				float3 uv : TEXCOORD0;
			};

			float _NormalX;
			float _NormalY;
			float _NormalZ;

			sampler2D _MainTexture;

			v2f vert (appdata IN)
			{
				v2f o;

				float3 extrude = float3(_NormalX, _NormalY, _NormalZ);
				IN.position.xyz += IN.normal.xyz * extrude;

				o.position = UnityObjectToClipPos(IN.position);
				o.uv = IN.uv;
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				return tex2D(_MainTexture, i.uv);
			}
			ENDCG
		}
	}
}
