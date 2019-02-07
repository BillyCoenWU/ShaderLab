Shader ".RGSMS/Variables"
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

		[Space] // Add a Vertical Space On Inspector

		[Enum(RGSMS.SIDE)] _CustomEnum("My Custom Enum ", int) = 0

		[KeywordEnum(None, Add, Multiply)] _Overlay("Overlay mode", int) = 0
		//[KeywordEnum(None, 0, Add, 1, Multiply, 2)] _Overlay("Overlay mode", int) = 0

		[PowerSlider(3.0)] _PowerRange("My Power Slider", Range(0.01, 1)) = 0.08 // Displays a slider with a non-linear response for a Range shader property.

		[IntRange] _Alpha("My Int Range", Range(0, 255)) = 100

		[Toggle] _Invert("Invert color", int) = 0

		//[Toggle(ENABLE_FANCY)] _Fancy("Fancy", int) = 0
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

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

			int _MyInt;
			int _Fancy;
			int _Alpha;
			int _Invert;

			float _MyFloat;
			float _MyRange;
			float _PowerRange;

			//half4 _MyColor;
			fixed4 _MyColor;
			float4 _MyVector;

			v2f vert(appdata IN)
			{
				v2f o;
				o.position = UnityObjectToClipPos(IN.position);
				o.uv = IN.uv;
				return o;
			}

			fixed4 frag(v2f IN) : SV_TARGET
			{
				if (_Invert == 1)
				{
					float4 c = tex2D(_MyTexture, IN.uv);
					c = float4(c.b, c.g, c.r, 1);

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
