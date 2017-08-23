﻿Shader "RGSMS/ColorChange"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
	}

	SubShader
	{
		Tags
		{
			"Queue"="Transparent"
			"RenderType"="Transparent"
		}
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert alpha
		#pragma target 3.0

		struct Input
		{
			float2 uv_MainTex;
		};

		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Color;
			o.Alpha = _Color.a;
		}
		ENDCG
	}
}