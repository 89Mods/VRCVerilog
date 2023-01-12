Shader "Tholin/VerilogVisualizer"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_TexDim ("CRT Texture Dimensions", Int) = 128
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			Texture2D<uint4> _MainTex;
			int _TexDim;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				uint4 s = _MainTex[uint2((uint)(i.uv.x * _TexDim), (uint)(i.uv.y * _TexDim))];
				fixed4 col = s.r ? fixed4(1, 1, 1, 1) : fixed4(0, 0, 0, 1);
				if(s.b) col = fixed4(0.1, 0.2, 1, 1);
				if(s.g) col.g = 1;
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
