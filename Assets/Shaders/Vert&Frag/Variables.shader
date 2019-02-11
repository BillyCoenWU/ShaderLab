Shader "RGSMS/Vertex/Variables"
{
	Properties
	{
		[NoScaleOffset] // Material inspector will not show texture tiling/offset fields for texture properties with this attribute
		_MyTexture("My Texture", 2D) = "white" {} // Pode ser iniciado com os valores "white", "black", "red" e "grey"

		[Normal] // Indicates that a texture property expects a normal-map
		_MyNormalMap("My Normal Map", 2D) = "bump" {} // Use "bump" para indicar que a textura será um normal map (A cor será #808080)

		[Space] // Add a Vertical Space On Inspector

		_My2DTexture("Texture 2D:", 2D) = "defaulttexture" {}
		_MyCubeMap("Cube Map: ", Cube) = "defaulttexture" {}
		_My3DTexture("Texture 3D:", 3D) = "defaulttexture" {}

		[Space]

		[HideInInspector] // Does not show the property value in the material inspector
		_MyInt ("My Integer", Int) = 0
		_MyFloat ("My Float", Float) = 1.5
		_MyRange ("My Range", Range(0.0, 1.0)) = 0.5

		[Space]

		_MyColor ("My Color", Color) = (1, 0, 0, 1) // ( R, G, B, A )
		_MyVector ("My Vector4", Vector) = (0, 0, 0, 0) // ( X, Y, Z, W )

		[Space]

		[Enum(RGSMS.SIDE)] _CustomEnum("My Custom Enum ", Int) = 0

		[KeywordEnum(None, Add, Multiply)] _Overlay("Overlay mode", Int) = 0
		//[KeywordEnum(None, 0, Add, 1, Multiply, 2)] _Overlay("Overlay mode", int) = 0

		[PowerSlider(3.0)] _PowerRange("My Power Slider", Range(0.01, 1)) = 0.08 // Displays a slider with a non-linear response for a Range shader property.

		[IntRange] _Alpha("My Int Range", Range(0, 255)) = 100

		[Toggle] _Invert("Invert color", Int) = 0

		//[Toggle(ENABLE_FANCY)] _Fancy("Fancy", int) = 0
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.5

			struct appdata
			{
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			sampler2D _MyTexture;
			sampler2D _MyNormalMap;

			//{TextureName}_ST
			float4 _MyTexture_ST; // A float4 property contains "_MyTexture" tiling & offset information:
								  /*
								  x contains X tiling value
								  y contains Y tiling value
								  z contains X offset value
								  w contains Y offset value
								  */

			//{TextureName}_TexelSize
			float4 _My2DTexture_TexelSize; // A float4 property contains "_MyTexture" size information:
										   /*
										   x contains 1.0/width
										   y contains 1.0/height
										   z contains width
										   w contains height
										   */

			sampler2D _My2DTexture;
			samplerCUBE _MyCubeMap;
			sampler3D _My3DTexture;

			int _MyInt;
			int _Fancy;
			int _Alpha;
			int _Invert;

			float _MyFloat;
			float _MyRange;
			float _PowerRange;

			float4 _MyColor; // Pode ser float4, fixed4 ou half4
			float4 _MyVector;

			v2f vert(appdata IN)
			{
				v2f o;
				o.position = UnityObjectToClipPos(IN.position);
				o.uv = IN.uv;
				return o;
			}

			float4 frag(v2f IN) : SV_TARGET
			{
				if (_Invert == 1)
				{
					float4 c = tex2D(_MyTexture, IN.uv);
					c = float4(1.0 - c.r, 1.0 - c.g, 1.0 - c.b, 1);

					return c;
				}
				else
				{
					return tex2D(_MyTexture, IN.uv);
				}
			}

			ENDCG
		}
	}
}
