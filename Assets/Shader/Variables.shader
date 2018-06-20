Shader "RGSMS/Variables"
{
	Properties
	{
		_MyTexture("My Texture", 2D) = "white" {}
		_MyNormalMap("My Normal Map", 2D) = "bump" {}

		_MyInt ("My Integer", Int) = 0
		_MyFloat ("My Float", Float) = 1.5
		_MyRange ("My Range", Range(0.0, 1.0)) = 0.5
 
		_MyColor ("My Color", Color) = (1, 0, 0, 1)
		_MyVector ("My Vector4", Vector) = (0, 0, 0, 0)
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}

        LOD 200

        CGPROGRAM
			#pragma surface surf Standard fullforwardshadows
			#pragma target 3.0

			struct Input
			{
				float2 uv_MainTex;
			};

			sampler2D _MyTexture;
			sampler2D _MyNormalMap;

			int _MyInt;
			float _MyFloat;
			float _MyRange;
 
			//half4 _MyColor;
			fixed4 _MyColor;
			float4 _MyVector;

			void surf (Input IN, inout SurfaceOutputStandard o) {}
		ENDCG
	}
}
