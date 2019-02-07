Shader ".RGSMS/FixedColor" // ShaderLab Begin
{
	// Variables
	Properties // "Custom Data" tudo aquilo que afeta o render, mas que é externo
	{
		_Color ("Main Color:", Color) = (1,1,1,1)
	}

	// Voce pode ter varios subshaders no seu codigo e pode usar cada um para, por exemplo:
	// 1 - ter valores diferente para plataformas diferente
	// 2 - trabalhar valores para GPUs com diferentes capacidades

	SubShader
	{
		Pass // Responsavel por pegar informacao e desenhar ela na tela, tambem é possivel ter mais de um pass dentro de um SubShader, cada pass é 1 drawcall extra
		{ // ShaderLab Interval
			CGPROGRAM // CG BEGIN
			#pragma vertex vert
			#pragma fragment frag

			//Pode ter :
			//- Vertex = POSITION / float3 or float 4
			//- Tangent = TANGENT / float4
			//- Normal = NORMAL / float3
			//- UV4 = TEXCOORD3 
			//- UV3 = TEXCOORD2
			//- UV2 = TEXCOORD1
			//- UV = TEXCOORD0 / float2, float3 or float4
			//- Color = COLOR / float4
			struct appdata // Object Data
			{
				float4 vertex : POSITION;
			};

			struct v2f // Estrutura que vai "enviar" os seus dados do seu objeto para a tela
			{
				float4 position : SV_POSITION; // Pode ser "POSITION", mas o SV_POSITION é importante para funcionar no Playstation 4 e DX9 (ou DX11, tem q confirmar)
			};

			fixed4 _Color;

			v2f vert (appdata IN) // "BUILDA" seu objeto, é aqui q a posicao do vertex pode ser alterado para depois ser pintado na tela da forma correta
			{
				v2f o;
				o.position = UnityObjectToClipPos(IN.vertex);
				return o;
			}

			fixed4 frag (v2f IN) : COLOR // Pinta os pixels na tela
			{
				return _Color;
			}
			ENDCG // CG End
		}  // ShaderLab Return
	}
} // ShaderLab End
