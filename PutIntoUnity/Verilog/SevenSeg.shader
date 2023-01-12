Shader "Custom/SevenSeg"
{
	Properties
	{
		_Color ("Text Color", Color) = (1,1,1,1)
		_MainTex ("Texture", 2D) = "white" {}
		_TexDim ("CRT Texture Dimensions", Int) = 128
	}
	Subshader
	{

		Tags {
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
			"PreviewType" = "Plane"
		}
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vertex_shader
			#pragma fragment pixel_shader
			#pragma target 3.0

			#define IO_LEDS_BASE 194

			fixed4 _Color;
			Texture2D<uint4> _MainTex;
			int _TexDim;

			#define get_wire(address) (_MainTex[uint2((address) % _TexDim, (address) / _TexDim)].r)

			struct custom_type
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			float segment(float2 uv, bool On) {
			return (On) ? (1. - smoothstep(0.08, 0.09 + float(On) * 0.02, abs(uv.x))) *
				(1. - smoothstep(0.46, 0.47 + float(On) * 0.02, abs(uv.y) + abs(uv.x)))
				: 0.;
			}

			float digit(float2 uv) {
				float seg = 0;
				seg += segment(uv.yx + float2(-1., 0.), 1);
				seg += segment(uv.xy + float2(-.5, -.5), 1);
				seg += segment(uv.xy + float2(.5, -.5), 1);
				seg += segment(uv.yx + float2(0., 0.), 1);
				seg += segment(uv.xy + float2(-.5, .5), 1);
				seg += segment(uv.xy + float2(.5, .5), 1);
				seg += segment(uv.yx + float2(1., 0.), 1);
				if(distance(uv.xy, float2(-.7, -1.2)) < 0.1) seg += 1;
				return seg;
			}

			float veri(float2 uv) {
				float seg = 0;
				seg += segment(uv.yx + float2(-1., 0.), get_wire(IO_LEDS_BASE) ? 1 : 0);
				seg += segment(uv.xy + float2(.5, -.5), get_wire(IO_LEDS_BASE + 1) ? 1 : 0);
				seg += segment(uv.xy + float2(.5, .5), get_wire(IO_LEDS_BASE + 2) ? 1 : 0);
				seg += segment(uv.yx + float2(1., 0.), get_wire(IO_LEDS_BASE + 3) ? 1 : 0);
				seg += segment(uv.xy + float2(-.5, .5), get_wire(IO_LEDS_BASE + 4) ? 1 : 0);
				seg += segment(uv.xy + float2(-.5, -.5), get_wire(IO_LEDS_BASE + 5) ? 1 : 0);
				seg += segment(uv.yx + float2(0., 0.), get_wire(IO_LEDS_BASE + 6) ? 1 : 0);

				if(get_wire(IO_LEDS_BASE + 7) && distance(uv.xy, float2(-.7, -1.2)) < 0.1) seg += 1;

				return seg;
			}

			custom_type vertex_shader(float4 vertex:POSITION, float2 uv : TEXCOORD0)
			{
				custom_type vs;
				vs.vertex = UnityObjectToClipPos(vertex);
				uv.x = 1 - uv.x;
				vs.uv = uv;
				return vs;
			}



			float4 pixel_shader(custom_type ps) : COLOR
			{
				float2 uv = float2(2.0 * ps.uv.xy - 1.0);
				uv.y *= 2;

				if(veri(uv) > 0.5) return _Color;
				if(digit(uv) > 0.5) return float4(_Color.rgb, 0.05);
				return float4(0,0,0,0);
			}
			ENDCG
		}
	}
}
