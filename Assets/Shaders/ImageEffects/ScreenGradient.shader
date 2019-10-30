Shader "RGSMS/Image Effects/ScreenGradient"
{
	Properties
	{
		[NoScaleOffset]
		_MainTex("Base (RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			fixed4 _MyColor;

			float4 frag(v2f_img i) : COLOR
			{
				float4 c = tex2D(_MainTex, i.uv);
				c *= float4(i.uv.x, i.uv.y, 0, 1);

				return c;
			}
			ENDCG
		}
	}
}
