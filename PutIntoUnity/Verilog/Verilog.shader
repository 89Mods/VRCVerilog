Shader "Tholin/Generated/Verilog"
{
	Properties
	{
		[Toggle] _CLK ("CLK", Int) = 0
		[Toggle] _ROLL ("ROLL", Int) = 0
		[Toggle] _RST ("RST", Int) = 0
		_Iters ("Iterations per frame", Int) = 2
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		Lighting Off
		Blend One Zero
		ZTest Always
		LOD 100

		Pass
		{
			CGPROGRAM
				#define _SelfTexture2D _JunkTexture
				#include "UnityCustomRenderTexture.cginc"
				#undef _SelfTexture2D
				Texture2D<uint4> _SelfTexture2D;
				#include "UnityCG.cginc"
				#pragma vertex CustomRenderTextureVertexShader
				#pragma fragment frag
				#pragma target 3.0

				struct appdata
				{
					float2 uv : TEXCOORD0;
				};

				struct verilog_regs {
					uint bcd[3];
					uint clkdiv[8];
					uint counter[8];
					uint dp;
					uint _lfsr_reg__0__;
					uint _lfsr_reg__1__;
					uint _lfsr_reg__2__;
					uint _lfsr_reg__3__;
					uint _lfsr_reg__4__;
					uint _lfsr_reg__5__;
					uint _lfsr_reg__6__;
					uint _lfsr_reg__7__;
					uint _lfsr_reg__8__;
					uint _lfsr_reg__9__;
					uint _lfsr_reg__10__;
					uint _lfsr_reg__11__;
					uint _lfsr_reg__12__;
					uint _lfsr_reg__13__;
					uint _lfsr_reg__14__;
				};

				struct verilog_wires {
					uint _000_[3];
					uint _001_[8];
					uint _002_[8];
					uint _003_;
					uint _004_[16];
					uint _005_;
					uint _006_;
					uint _007_;
					uint _008_;
					uint _009_;
					uint _010_;
					uint _011_;
					uint _012_;
					uint _013_;
					uint _014_;
					uint _015_;
					uint _016_;
					uint _017_;
					uint _018_;
					uint _019_;
					uint _020_;
					uint _021_;
					uint _022_;
					uint _023_;
					uint _024_;
					uint _025_;
					uint _026_;
					uint _027_;
					uint _028_;
					uint _029_;
					uint _030_;
					uint _031_;
					uint _032_;
					uint _033_;
					uint _034_;
					uint _035_;
					uint _036_;
					uint _037_;
					uint _038_;
					uint _039_;
					uint _040_;
					uint _041_;
					uint _042_;
					uint _043_;
					uint _044_;
					uint _045_;
					uint _046_;
					uint _047_;
					uint _048_;
					uint _049_;
					uint _050_;
					uint _051_;
					uint _052_;
					uint _053_;
					uint _054_;
					uint _055_;
					uint _056_;
					uint _057_;
					uint _058_;
					uint _059_;
					uint _060_;
					uint _061_;
					uint _062_;
					uint _063_;
					uint _064_;
					uint _065_;
					uint _066_;
					uint _067_;
					uint _068_;
					uint _069_;
					uint _070_;
					uint _071_;
					uint _072_;
					uint _073_;
					uint _074_;
					uint _075_;
					uint _076_;
					uint _077_;
					uint _078_;
					uint _079_;
					uint _080_;
					uint _081_;
					uint _082_;
					uint _083_;
					uint _084_;
					uint _085_;
					uint _086_;
					uint _087_;
					uint _088_;
					uint _089_;
					uint _090_;
					uint _091_;
					uint _092_;
					uint _093_;
					uint _094_;
					uint _095_;
					uint _096_;
					uint _097_;
					uint _098_;
					uint _099_;
					uint _100_;
					uint _101_;
					uint _102_;
					uint _103_;
					uint _104_;
					uint _105_;
					uint _106_;
					uint _107_;
					uint _108_;
					uint _109_;
					uint _110_;
					uint _111_;
					uint _112_;
					uint _113_;
					uint _114_;
					uint _115_;
					uint _116_;
					uint _117_;
					uint _118_;
					uint _119_;
					uint _120_;
					uint _121_;
					uint _122_;
					uint _123_;
					uint _124_;
					uint _125_;
					uint _126_;
					uint _127_;
					uint _128_;
					uint _129_;
					uint _130_;
					uint _131_;
					uint _132_;
					uint _133_;
					uint _134_;
					uint _135_;
					uint _136_;
					uint _137_;
					uint _138_;
					uint _139_;
					uint _140_;
					uint _141_;
					uint _142_;
					uint _143_;
					uint _144_;
					uint _145_;
					uint _146_;
					uint _147_;
					uint _148_;
					uint _149_;
					uint _150_;
					uint _151_;
					uint _152_;
					uint _153_;
					uint _154_;
					uint _155_;
					uint _156_;
					uint _157_;
					uint _158_;
					uint _159_;
					uint _160_;
					uint _161_;
					uint lfsr[16];
					uint segments[7];
				};

				struct verilog_io {
					uint CLK; // INPUT
					uint clk_prev_CLK;
					uint LEDS[8]; // OUTPUT
					uint ROLL; // INPUT
					uint RST; // INPUT
				};

				uint _CLK;
				uint _ROLL;
				uint _RST;
				uint _Iters;

				#define get_wire(address) (_SelfTexture2D[uint2((address) % 128, (address) / 128)].r)
				#define get_wire_prev(address) (_SelfTexture2D[uint2((address) % 128, (address) / 128)].g)
				#define get_reg(address) (get_wire(16383 - (address)))
				#define MAX_ITERS 256

				uint4 frag (v2f_customrendertexture i) : COLOR
				{
					uint idxx = (uint)(i.globalTexcoord.x * 128.0);
					uint idxy = (uint)(i.globalTexcoord.y * 128.0);
					uint idx = idxy * 128 + idxx;
					uint4 col = _SelfTexture2D[uint2(idxx, idxy)]; //Return this if unchanged
					if(idx > 227 && idx < 16383 - 35) return col;
					verilog_regs regs;
					verilog_wires wires;
					verilog_io io;

					//Load regs
					for(int i = 0; i < 3; i++) regs.bcd[i] = get_reg(0 + i);
					for(int i = 0; i < 8; i++) regs.clkdiv[i] = get_reg(3 + i);
					for(int i = 0; i < 8; i++) regs.counter[i] = get_reg(11 + i);
					regs.dp = get_reg(19) ? 1 : 0;
					regs._lfsr_reg__0__ = get_reg(20) ? 1 : 0;
					regs._lfsr_reg__1__ = get_reg(21) ? 1 : 0;
					regs._lfsr_reg__2__ = get_reg(22) ? 1 : 0;
					regs._lfsr_reg__3__ = get_reg(23) ? 1 : 0;
					regs._lfsr_reg__4__ = get_reg(24) ? 1 : 0;
					regs._lfsr_reg__5__ = get_reg(25) ? 1 : 0;
					regs._lfsr_reg__6__ = get_reg(26) ? 1 : 0;
					regs._lfsr_reg__7__ = get_reg(27) ? 1 : 0;
					regs._lfsr_reg__8__ = get_reg(28) ? 1 : 0;
					regs._lfsr_reg__9__ = get_reg(29) ? 1 : 0;
					regs._lfsr_reg__10__ = get_reg(30) ? 1 : 0;
					regs._lfsr_reg__11__ = get_reg(31) ? 1 : 0;
					regs._lfsr_reg__12__ = get_reg(32) ? 1 : 0;
					regs._lfsr_reg__13__ = get_reg(33) ? 1 : 0;
					regs._lfsr_reg__14__ = get_reg(34) ? 1 : 0;

					//Load wires
					for(int i = 0; i < 3; i++) wires._000_[i] = get_wire(0 + i);
					for(int i = 0; i < 8; i++) wires._001_[i] = get_wire(3 + i);
					for(int i = 0; i < 8; i++) wires._002_[i] = get_wire(11 + i);
					wires._003_ = get_wire(19) ? 1 : 0;
					for(int i = 0; i < 16; i++) wires._004_[i] = get_wire(20 + i);
					wires._005_ = get_wire(36) ? 1 : 0;
					wires._006_ = get_wire(37) ? 1 : 0;
					wires._007_ = get_wire(38) ? 1 : 0;
					wires._008_ = get_wire(39) ? 1 : 0;
					wires._009_ = get_wire(40) ? 1 : 0;
					wires._010_ = get_wire(41) ? 1 : 0;
					wires._011_ = get_wire(42) ? 1 : 0;
					wires._012_ = get_wire(43) ? 1 : 0;
					wires._013_ = get_wire(44) ? 1 : 0;
					wires._014_ = get_wire(45) ? 1 : 0;
					wires._015_ = get_wire(46) ? 1 : 0;
					wires._016_ = get_wire(47) ? 1 : 0;
					wires._017_ = get_wire(48) ? 1 : 0;
					wires._018_ = get_wire(49) ? 1 : 0;
					wires._019_ = get_wire(50) ? 1 : 0;
					wires._020_ = get_wire(51) ? 1 : 0;
					wires._021_ = get_wire(52) ? 1 : 0;
					wires._022_ = get_wire(53) ? 1 : 0;
					wires._023_ = get_wire(54) ? 1 : 0;
					wires._024_ = get_wire(55) ? 1 : 0;
					wires._025_ = get_wire(56) ? 1 : 0;
					wires._026_ = get_wire(57) ? 1 : 0;
					wires._027_ = get_wire(58) ? 1 : 0;
					wires._028_ = get_wire(59) ? 1 : 0;
					wires._029_ = get_wire(60) ? 1 : 0;
					wires._030_ = get_wire(61) ? 1 : 0;
					wires._031_ = get_wire(62) ? 1 : 0;
					wires._032_ = get_wire(63) ? 1 : 0;
					wires._033_ = get_wire(64) ? 1 : 0;
					wires._034_ = get_wire(65) ? 1 : 0;
					wires._035_ = get_wire(66) ? 1 : 0;
					wires._036_ = get_wire(67) ? 1 : 0;
					wires._037_ = get_wire(68) ? 1 : 0;
					wires._038_ = get_wire(69) ? 1 : 0;
					wires._039_ = get_wire(70) ? 1 : 0;
					wires._040_ = get_wire(71) ? 1 : 0;
					wires._041_ = get_wire(72) ? 1 : 0;
					wires._042_ = get_wire(73) ? 1 : 0;
					wires._043_ = get_wire(74) ? 1 : 0;
					wires._044_ = get_wire(75) ? 1 : 0;
					wires._045_ = get_wire(76) ? 1 : 0;
					wires._046_ = get_wire(77) ? 1 : 0;
					wires._047_ = get_wire(78) ? 1 : 0;
					wires._048_ = get_wire(79) ? 1 : 0;
					wires._049_ = get_wire(80) ? 1 : 0;
					wires._050_ = get_wire(81) ? 1 : 0;
					wires._051_ = get_wire(82) ? 1 : 0;
					wires._052_ = get_wire(83) ? 1 : 0;
					wires._053_ = get_wire(84) ? 1 : 0;
					wires._054_ = get_wire(85) ? 1 : 0;
					wires._055_ = get_wire(86) ? 1 : 0;
					wires._056_ = get_wire(87) ? 1 : 0;
					wires._057_ = get_wire(88) ? 1 : 0;
					wires._058_ = get_wire(89) ? 1 : 0;
					wires._059_ = get_wire(90) ? 1 : 0;
					wires._060_ = get_wire(91) ? 1 : 0;
					wires._061_ = get_wire(92) ? 1 : 0;
					wires._062_ = get_wire(93) ? 1 : 0;
					wires._063_ = get_wire(94) ? 1 : 0;
					wires._064_ = get_wire(95) ? 1 : 0;
					wires._065_ = get_wire(96) ? 1 : 0;
					wires._066_ = get_wire(97) ? 1 : 0;
					wires._067_ = get_wire(98) ? 1 : 0;
					wires._068_ = get_wire(99) ? 1 : 0;
					wires._069_ = get_wire(100) ? 1 : 0;
					wires._070_ = get_wire(101) ? 1 : 0;
					wires._071_ = get_wire(102) ? 1 : 0;
					wires._072_ = get_wire(103) ? 1 : 0;
					wires._073_ = get_wire(104) ? 1 : 0;
					wires._074_ = get_wire(105) ? 1 : 0;
					wires._075_ = get_wire(106) ? 1 : 0;
					wires._076_ = get_wire(107) ? 1 : 0;
					wires._077_ = get_wire(108) ? 1 : 0;
					wires._078_ = get_wire(109) ? 1 : 0;
					wires._079_ = get_wire(110) ? 1 : 0;
					wires._080_ = get_wire(111) ? 1 : 0;
					wires._081_ = get_wire(112) ? 1 : 0;
					wires._082_ = get_wire(113) ? 1 : 0;
					wires._083_ = get_wire(114) ? 1 : 0;
					wires._084_ = get_wire(115) ? 1 : 0;
					wires._085_ = get_wire(116) ? 1 : 0;
					wires._086_ = get_wire(117) ? 1 : 0;
					wires._087_ = get_wire(118) ? 1 : 0;
					wires._088_ = get_wire(119) ? 1 : 0;
					wires._089_ = get_wire(120) ? 1 : 0;
					wires._090_ = get_wire(121) ? 1 : 0;
					wires._091_ = get_wire(122) ? 1 : 0;
					wires._092_ = get_wire(123) ? 1 : 0;
					wires._093_ = get_wire(124) ? 1 : 0;
					wires._094_ = get_wire(125) ? 1 : 0;
					wires._095_ = get_wire(126) ? 1 : 0;
					wires._096_ = get_wire(127) ? 1 : 0;
					wires._097_ = get_wire(128) ? 1 : 0;
					wires._098_ = get_wire(129) ? 1 : 0;
					wires._099_ = get_wire(130) ? 1 : 0;
					wires._100_ = get_wire(131) ? 1 : 0;
					wires._101_ = get_wire(132) ? 1 : 0;
					wires._102_ = get_wire(133) ? 1 : 0;
					wires._103_ = get_wire(134) ? 1 : 0;
					wires._104_ = get_wire(135) ? 1 : 0;
					wires._105_ = get_wire(136) ? 1 : 0;
					wires._106_ = get_wire(137) ? 1 : 0;
					wires._107_ = get_wire(138) ? 1 : 0;
					wires._108_ = get_wire(139) ? 1 : 0;
					wires._109_ = get_wire(140) ? 1 : 0;
					wires._110_ = get_wire(141) ? 1 : 0;
					wires._111_ = get_wire(142) ? 1 : 0;
					wires._112_ = get_wire(143) ? 1 : 0;
					wires._113_ = get_wire(144) ? 1 : 0;
					wires._114_ = get_wire(145) ? 1 : 0;
					wires._115_ = get_wire(146) ? 1 : 0;
					wires._116_ = get_wire(147) ? 1 : 0;
					wires._117_ = get_wire(148) ? 1 : 0;
					wires._118_ = get_wire(149) ? 1 : 0;
					wires._119_ = get_wire(150) ? 1 : 0;
					wires._120_ = get_wire(151) ? 1 : 0;
					wires._121_ = get_wire(152) ? 1 : 0;
					wires._122_ = get_wire(153) ? 1 : 0;
					wires._123_ = get_wire(154) ? 1 : 0;
					wires._124_ = get_wire(155) ? 1 : 0;
					wires._125_ = get_wire(156) ? 1 : 0;
					wires._126_ = get_wire(157) ? 1 : 0;
					wires._127_ = get_wire(158) ? 1 : 0;
					wires._128_ = get_wire(159) ? 1 : 0;
					wires._129_ = get_wire(160) ? 1 : 0;
					wires._130_ = get_wire(161) ? 1 : 0;
					wires._131_ = get_wire(162) ? 1 : 0;
					wires._132_ = get_wire(163) ? 1 : 0;
					wires._133_ = get_wire(164) ? 1 : 0;
					wires._134_ = get_wire(165) ? 1 : 0;
					wires._135_ = get_wire(166) ? 1 : 0;
					wires._136_ = get_wire(167) ? 1 : 0;
					wires._137_ = get_wire(168) ? 1 : 0;
					wires._138_ = get_wire(169) ? 1 : 0;
					wires._139_ = get_wire(170) ? 1 : 0;
					wires._140_ = get_wire(171) ? 1 : 0;
					wires._141_ = get_wire(172) ? 1 : 0;
					wires._142_ = get_wire(173) ? 1 : 0;
					wires._143_ = get_wire(174) ? 1 : 0;
					wires._144_ = get_wire(175) ? 1 : 0;
					wires._145_ = get_wire(176) ? 1 : 0;
					wires._146_ = get_wire(177) ? 1 : 0;
					wires._147_ = get_wire(178) ? 1 : 0;
					wires._148_ = get_wire(179) ? 1 : 0;
					wires._149_ = get_wire(180) ? 1 : 0;
					wires._150_ = get_wire(181) ? 1 : 0;
					wires._151_ = get_wire(182) ? 1 : 0;
					wires._152_ = get_wire(183) ? 1 : 0;
					wires._153_ = get_wire(184) ? 1 : 0;
					wires._154_ = get_wire(185) ? 1 : 0;
					wires._155_ = get_wire(186) ? 1 : 0;
					wires._156_ = get_wire(187) ? 1 : 0;
					wires._157_ = get_wire(188) ? 1 : 0;
					wires._158_ = get_wire(189) ? 1 : 0;
					wires._159_ = get_wire(190) ? 1 : 0;
					wires._160_ = get_wire(191) ? 1 : 0;
					wires._161_ = get_wire(192) ? 1 : 0;
					io.CLK = _CLK;
					io.clk_prev_CLK = get_wire_prev(193) ? 1 : 0;
					for(int i = 0; i < 8; i++) io.LEDS[i] = get_wire(194 + i);
					io.ROLL = _ROLL;
					io.RST = _RST;
					for(int i = 0; i < 16; i++) wires.lfsr[i] = get_wire(204 + i);
					for(int i = 0; i < 7; i++) wires.segments[i] = get_wire(220 + i);

					uint changed;
					uint iter_count = 0;
					verilog_wires compare;
					verilog_io compare_io;
					for(int jjj = 0; jjj < _Iters; jjj++) {
					for(int iii = 0; iii < MAX_ITERS; iii++) {
						wires._059_ = !wires.lfsr[2];
						wires._060_ = !(wires.lfsr[2] != wires.lfsr[1]);
						wires._061_ = wires._013_ ? wires._059_ : wires._060_;
						wires._062_ = wires._055_ ? wires._058_ : wires._061_;
						wires._063_ = wires._010_ ? wires._058_ : wires._062_;
						wires._000_[1] = wires._149_ && !(wires._063_);
						wires._064_ = !regs.bcd[2];
						wires._065_ = !(wires.lfsr[2] && wires.lfsr[1]);
						wires._066_ = wires._065_ != wires.lfsr[3];
						wires._067_ = wires._013_ ? wires.lfsr[3] : wires._066_;
						wires._068_ = wires._055_ ? wires._064_ : wires._067_;
						wires._069_ = wires._010_ ? wires._064_ : wires._068_;
						wires._000_[2] = wires._149_ && !(wires._069_);
						wires._070_ = !(wires._055_ != wires._153_);
						wires._071_ = wires._010_ ? wires._153_ : wires._070_;
						wires._001_[0] = wires._149_ && !(wires._071_);
						wires._072_ = !(wires._154_ != wires._153_);
						wires._073_ = wires._055_ ? wires._154_ : wires._072_;
						wires._074_ = wires._010_ ? wires._154_ : wires._073_;
						wires._001_[1] = wires._149_ && !(wires._074_);
						wires._075_ = !wires._156_;
						wires._076_ = wires._154_ || wires._153_;
						wires._077_ = wires._076_ != wires._075_;
						wires._078_ = wires._055_ ? wires._156_ : wires._077_;
						wires._079_ = wires._010_ ? wires._156_ : wires._078_;
						wires._001_[2] = wires._149_ && !(wires._079_);
						wires._080_ = wires._075_ && !(wires._076_);
						wires._081_ = wires._080_ != wires._157_;
						wires._082_ = wires._055_ ? wires._157_ : wires._081_;
						wires._083_ = wires._010_ ? wires._157_ : wires._082_;
						wires._001_[3] = wires._149_ && !(wires._083_);
						wires._084_ = !wires._160_;
						wires._085_ = wires._157_ || wires._156_;
						wires._086_ = wires._085_ || wires._076_;
						wires._087_ = wires._086_ != wires._160_;
						wires._088_ = wires._055_ ? wires._084_ : wires._087_;
						wires._089_ = wires._010_ ? wires._084_ : wires._088_;
						wires._001_[4] = wires._149_ && !(wires._089_);
						wires._090_ = wires._160_ && !(wires._086_);
						wires._091_ = wires._090_ != wires._161_;
						wires._092_ = wires._055_ ? wires._161_ : wires._091_;
						wires._093_ = wires._010_ ? wires._161_ : wires._092_;
						wires._001_[5] = wires._093_ || io.RST;
						wires._094_ = !(wires._161_ && wires._160_);
						wires._095_ = wires._094_ || wires._086_;
						wires._096_ = wires._095_ != wires._006_;
						wires._097_ = wires._055_ ? wires._043_ : wires._096_;
						wires._098_ = wires._010_ ? wires._043_ : wires._097_;
						wires._001_[6] = wires._149_ && !(wires._098_);
						wires._099_ = wires._006_ && !(wires._095_);
						wires._100_ = wires._099_ != wires._007_;
						wires._101_ = wires._055_ ? wires._007_ : wires._100_;
						wires._102_ = wires._010_ ? wires._007_ : wires._101_;
						wires._001_[7] = wires._102_ || io.RST;
						wires._103_ = !wires._015_;
						wires._104_ = wires._055_ && !(wires._103_);
						wires._105_ = wires._010_ ? wires._103_ : wires._104_;
						wires._002_[0] = io.RST ? regs.counter[0] : wires._105_;
						wires._106_ = !wires._017_;
						wires._107_ = wires._055_ && !(wires._018_);
						wires._108_ = wires._010_ ? wires._106_ : wires._107_;
						wires._002_[1] = io.RST ? regs.counter[1] : wires._108_;
						wires._109_ = wires._055_ && !(wires._024_);
						wires._110_ = wires._010_ ? wires._022_ : wires._109_;
						wires._002_[2] = io.RST ? regs.counter[2] : wires._110_;
						wires._111_ = !wires._026_;
						wires._112_ = wires._055_ && !(wires._028_);
						wires._113_ = wires._010_ ? wires._111_ : wires._112_;
						wires._002_[3] = io.RST ? regs.counter[3] : wires._113_;
						wires._114_ = wires._055_ && !(wires._036_);
						wires._115_ = wires._010_ ? wires._033_ : wires._114_;
						wires._002_[4] = io.RST ? regs.counter[4] : wires._115_;
						wires._116_ = !wires._038_;
						wires._117_ = wires._055_ && !(wires._040_);
						wires._118_ = wires._010_ ? wires._116_ : wires._117_;
						wires._002_[5] = io.RST ? regs.counter[5] : wires._118_;
						wires._119_ = wires._055_ && !(wires._047_);
						wires._120_ = wires._010_ ? wires._044_ : wires._119_;
						wires._002_[6] = io.RST ? regs.counter[6] : wires._120_;
						wires._121_ = !wires._049_;
						wires._122_ = wires._055_ && !(wires._051_);
						wires._123_ = wires._010_ ? wires._121_ : wires._122_;
						wires._002_[7] = io.RST ? regs.counter[7] : wires._123_;
						wires._004_[15] = wires.lfsr[1] && !(io.RST);
						wires._004_[1] = wires.lfsr[2] || io.RST;
						wires._004_[2] = wires.lfsr[3] && !(io.RST);
						wires._004_[3] = wires.lfsr[4] || io.RST;
						wires._004_[4] = wires.lfsr[5] || io.RST;
						wires._004_[5] = wires.lfsr[6] && !(io.RST);
						wires._004_[6] = wires.lfsr[7] || io.RST;
						wires._004_[7] = wires.lfsr[8] || io.RST;
						wires._124_ = regs.bcd[1] && regs.bcd[0];
						wires._125_ = wires._124_ && !(wires._064_);
						wires._126_ = regs.bcd[1] && !(regs.bcd[0]);
						wires._127_ = wires._126_ && !(wires._064_);
						wires._128_ = wires._127_ || wires._125_;
						wires._129_ = regs.bcd[1] || !(regs.bcd[0]);
						wires._130_ = regs.bcd[1] || regs.bcd[0];
						wires._131_ = !((wires._130_ && wires._129_) || wires._064_);
						wires._132_ = wires._131_ || wires._128_;
						wires._133_ = !regs.bcd[0];
						wires._134_ = !((wires._058_ && wires._133_) || regs.bcd[2]);
						wires._135_ = !(wires._134_ || wires._132_);
						wires._136_ = regs.bcd[2] ? wires._133_ : wires._058_;
						io.LEDS[0] = wires._135_ || !(wires._136_);
						wires._137_ = !wires._124_;
						wires._138_ = !((wires._130_ && wires._137_) || wires._064_);
						wires._139_ = !(wires._138_ || wires._134_);
						io.LEDS[1] = wires._135_ || !(wires._139_);
						wires._140_ = !((wires._129_ && wires._137_) || regs.bcd[2]);
						wires._141_ = wires._140_ || wires._132_;
						io.LEDS[2] = wires._141_ || wires._135_;
						wires._142_ = !((wires._126_ || wires._124_) && wires._064_);
						wires._143_ = regs.bcd[2] && !(wires._129_);
						wires._144_ = wires._143_ || wires._127_;
						wires._145_ = wires._142_ && !(wires._144_);
						io.LEDS[3] = wires._135_ || !(wires._145_);
						io.LEDS[4] = !((regs.bcd[2] && wires._058_) || regs.bcd[0]);
						wires._146_ = !(wires._131_ || wires._127_);
						io.LEDS[5] = wires._135_ || !(wires._146_);
						io.LEDS[6] = !((wires._146_ && wires._142_) || wires._135_);
						wires._147_ = regs.dp && !(io.ROLL);
						wires._148_ = wires._147_ || wires._010_;
						wires._003_ = wires._148_ || io.RST;
						wires._149_ = !io.RST;
						wires._150_ = !(wires.lfsr[13] != wires.lfsr[1]);
						wires._004_[12] = wires._149_ && !(wires._150_);
						wires._004_[14] = wires.lfsr[0] && !(io.RST);
						wires._151_ = !(wires.lfsr[14] != wires.lfsr[1]);
						wires._004_[13] = wires._149_ && !(wires._151_);
						wires._004_[8] = wires.lfsr[9] && !(io.RST);
						wires._004_[9] = wires.lfsr[10] && !(io.RST);
						wires._004_[11] = wires.lfsr[12] && !(io.RST);
						wires._152_ = !(wires.lfsr[11] != wires.lfsr[1]);
						wires._004_[10] = wires._149_ && !(wires._152_);
						wires._153_ = io.ROLL || !(regs.clkdiv[0]);
						wires._154_ = !(regs.clkdiv[1] || io.ROLL);
						wires._155_ = wires._154_ && wires._153_;
						wires._156_ = io.ROLL || !(regs.clkdiv[2]);
						wires._157_ = io.ROLL || !(regs.clkdiv[3]);
						wires._158_ = !(wires._157_ && wires._156_);
						wires._159_ = wires._155_ && !(wires._158_);
						wires._160_ = regs.clkdiv[4] && !(io.ROLL);
						wires._161_ = regs.clkdiv[5] && !(io.ROLL);
						wires._005_ = wires._160_ || !(wires._161_);
						wires._006_ = regs.clkdiv[6] && !(io.ROLL);
						wires._007_ = regs.clkdiv[7] && !(io.ROLL);
						wires._008_ = wires._006_ || !(wires._007_);
						wires._009_ = wires._008_ || wires._005_;
						wires._010_ = wires._159_ && !(wires._009_);
						wires._011_ = !((wires.lfsr[2] || wires.lfsr[1]) && wires.lfsr[3]);
						wires._012_ = wires.lfsr[3] && !(wires.lfsr[2]);
						wires._013_ = !((wires._012_ && wires.lfsr[1]) || wires._011_);
						wires._014_ = !(wires._013_ != wires.lfsr[1]);
						wires._015_ = io.ROLL || !(regs.counter[0]);
						wires._016_ = wires._015_ != wires._153_;
						wires._017_ = io.ROLL || !(regs.counter[1]);
						wires._018_ = !(wires._017_ != wires._015_);
						wires._019_ = wires._018_ != wires._154_;
						wires._020_ = wires._016_ && !(wires._019_);
						wires._021_ = io.ROLL || !(regs.counter[2]);
						wires._022_ = !wires._021_;
						wires._023_ = wires._017_ || wires._015_;
						wires._024_ = wires._023_ != wires._022_;
						wires._025_ = wires._024_ != wires._156_;
						wires._026_ = io.ROLL || !(regs.counter[3]);
						wires._027_ = wires._022_ && !(wires._023_);
						wires._028_ = wires._027_ != wires._026_;
						wires._029_ = wires._028_ != wires._157_;
						wires._030_ = wires._029_ || wires._025_;
						wires._031_ = wires._020_ && !(wires._030_);
						wires._032_ = io.ROLL || !(regs.counter[4]);
						wires._033_ = !wires._032_;
						wires._034_ = wires._026_ || wires._021_;
						wires._035_ = wires._034_ || wires._023_;
						wires._036_ = wires._035_ != wires._033_;
						wires._037_ = wires._036_ != wires._160_;
						wires._038_ = io.ROLL || !(regs.counter[5]);
						wires._039_ = wires._033_ && !(wires._035_);
						wires._040_ = wires._039_ != wires._038_;
						wires._041_ = !(wires._040_ != wires._161_);
						wires._042_ = wires._037_ && !(wires._041_);
						wires._043_ = !wires._006_;
						wires._044_ = regs.counter[6] && !(io.ROLL);
						wires._045_ = wires._038_ || wires._032_;
						wires._046_ = wires._045_ || wires._035_;
						wires._047_ = wires._046_ != wires._044_;
						wires._048_ = wires._047_ != wires._043_;
						wires._049_ = io.ROLL || !(regs.counter[7]);
						wires._050_ = wires._044_ && !(wires._046_);
						wires._051_ = wires._050_ != wires._049_;
						wires._052_ = !(wires._051_ != wires._007_);
						wires._053_ = wires._052_ || wires._048_;
						wires._054_ = wires._042_ && !(wires._053_);
						wires._055_ = !(wires._054_ && wires._031_);
						wires._056_ = wires._055_ ? regs.bcd[0] : wires._014_;
						wires._057_ = wires._010_ ? regs.bcd[0] : wires._056_;
						wires._000_[0] = wires._057_ || io.RST;
						wires._058_ = !regs.bcd[1];
						wires.lfsr[0] = regs._lfsr_reg__0__ ;
						wires.lfsr[1] = regs._lfsr_reg__1__ ;
						wires.lfsr[2] = regs._lfsr_reg__2__ ;
						wires.lfsr[3] = regs._lfsr_reg__3__ ;
						wires.lfsr[4] = regs._lfsr_reg__4__ ;
						wires.lfsr[5] = regs._lfsr_reg__5__ ;
						wires.lfsr[6] = regs._lfsr_reg__6__ ;
						wires.lfsr[7] = regs._lfsr_reg__7__ ;
						wires.lfsr[8] = regs._lfsr_reg__8__ ;
						wires.lfsr[9] = regs._lfsr_reg__9__ ;
						wires.lfsr[10] = regs._lfsr_reg__10__ ;
						wires.lfsr[11] = regs._lfsr_reg__11__ ;
						wires.lfsr[12] = regs._lfsr_reg__12__ ;
						wires.lfsr[13] = regs._lfsr_reg__13__ ;
						wires.lfsr[14] = regs._lfsr_reg__14__ ;
						wires._004_[0] = wires._004_[15];
						io.LEDS[7] = regs.dp;
						wires.lfsr[15] = wires.lfsr[0];
						for(int i = 0; i < 6; i++) {
							wires.segments[i] = io.LEDS[i];
						}

						iter_count++;
						changed = 0;
						for(int i = 0; i < 3; i++) {
							if(compare._000_[i] != wires._000_[i]) changed = 1;
							compare._000_[i] = wires._000_[i];
						}
						for(int i = 0; i < 8; i++) {
							if(compare._001_[i] != wires._001_[i]) changed = 1;
							compare._001_[i] = wires._001_[i];
						}
						for(int i = 0; i < 8; i++) {
							if(compare._002_[i] != wires._002_[i]) changed = 1;
							compare._002_[i] = wires._002_[i];
						}
						if(compare._003_ != wires._003_) changed = 1;
						compare._003_ = wires._003_;
						for(int i = 0; i < 16; i++) {
							if(compare._004_[i] != wires._004_[i]) changed = 1;
							compare._004_[i] = wires._004_[i];
						}
						if(compare._005_ != wires._005_) changed = 1;
						compare._005_ = wires._005_;
						if(compare._006_ != wires._006_) changed = 1;
						compare._006_ = wires._006_;
						if(compare._007_ != wires._007_) changed = 1;
						compare._007_ = wires._007_;
						if(compare._008_ != wires._008_) changed = 1;
						compare._008_ = wires._008_;
						if(compare._009_ != wires._009_) changed = 1;
						compare._009_ = wires._009_;
						if(compare._010_ != wires._010_) changed = 1;
						compare._010_ = wires._010_;
						if(compare._011_ != wires._011_) changed = 1;
						compare._011_ = wires._011_;
						if(compare._012_ != wires._012_) changed = 1;
						compare._012_ = wires._012_;
						if(compare._013_ != wires._013_) changed = 1;
						compare._013_ = wires._013_;
						if(compare._014_ != wires._014_) changed = 1;
						compare._014_ = wires._014_;
						if(compare._015_ != wires._015_) changed = 1;
						compare._015_ = wires._015_;
						if(compare._016_ != wires._016_) changed = 1;
						compare._016_ = wires._016_;
						if(compare._017_ != wires._017_) changed = 1;
						compare._017_ = wires._017_;
						if(compare._018_ != wires._018_) changed = 1;
						compare._018_ = wires._018_;
						if(compare._019_ != wires._019_) changed = 1;
						compare._019_ = wires._019_;
						if(compare._020_ != wires._020_) changed = 1;
						compare._020_ = wires._020_;
						if(compare._021_ != wires._021_) changed = 1;
						compare._021_ = wires._021_;
						if(compare._022_ != wires._022_) changed = 1;
						compare._022_ = wires._022_;
						if(compare._023_ != wires._023_) changed = 1;
						compare._023_ = wires._023_;
						if(compare._024_ != wires._024_) changed = 1;
						compare._024_ = wires._024_;
						if(compare._025_ != wires._025_) changed = 1;
						compare._025_ = wires._025_;
						if(compare._026_ != wires._026_) changed = 1;
						compare._026_ = wires._026_;
						if(compare._027_ != wires._027_) changed = 1;
						compare._027_ = wires._027_;
						if(compare._028_ != wires._028_) changed = 1;
						compare._028_ = wires._028_;
						if(compare._029_ != wires._029_) changed = 1;
						compare._029_ = wires._029_;
						if(compare._030_ != wires._030_) changed = 1;
						compare._030_ = wires._030_;
						if(compare._031_ != wires._031_) changed = 1;
						compare._031_ = wires._031_;
						if(compare._032_ != wires._032_) changed = 1;
						compare._032_ = wires._032_;
						if(compare._033_ != wires._033_) changed = 1;
						compare._033_ = wires._033_;
						if(compare._034_ != wires._034_) changed = 1;
						compare._034_ = wires._034_;
						if(compare._035_ != wires._035_) changed = 1;
						compare._035_ = wires._035_;
						if(compare._036_ != wires._036_) changed = 1;
						compare._036_ = wires._036_;
						if(compare._037_ != wires._037_) changed = 1;
						compare._037_ = wires._037_;
						if(compare._038_ != wires._038_) changed = 1;
						compare._038_ = wires._038_;
						if(compare._039_ != wires._039_) changed = 1;
						compare._039_ = wires._039_;
						if(compare._040_ != wires._040_) changed = 1;
						compare._040_ = wires._040_;
						if(compare._041_ != wires._041_) changed = 1;
						compare._041_ = wires._041_;
						if(compare._042_ != wires._042_) changed = 1;
						compare._042_ = wires._042_;
						if(compare._043_ != wires._043_) changed = 1;
						compare._043_ = wires._043_;
						if(compare._044_ != wires._044_) changed = 1;
						compare._044_ = wires._044_;
						if(compare._045_ != wires._045_) changed = 1;
						compare._045_ = wires._045_;
						if(compare._046_ != wires._046_) changed = 1;
						compare._046_ = wires._046_;
						if(compare._047_ != wires._047_) changed = 1;
						compare._047_ = wires._047_;
						if(compare._048_ != wires._048_) changed = 1;
						compare._048_ = wires._048_;
						if(compare._049_ != wires._049_) changed = 1;
						compare._049_ = wires._049_;
						if(compare._050_ != wires._050_) changed = 1;
						compare._050_ = wires._050_;
						if(compare._051_ != wires._051_) changed = 1;
						compare._051_ = wires._051_;
						if(compare._052_ != wires._052_) changed = 1;
						compare._052_ = wires._052_;
						if(compare._053_ != wires._053_) changed = 1;
						compare._053_ = wires._053_;
						if(compare._054_ != wires._054_) changed = 1;
						compare._054_ = wires._054_;
						if(compare._055_ != wires._055_) changed = 1;
						compare._055_ = wires._055_;
						if(compare._056_ != wires._056_) changed = 1;
						compare._056_ = wires._056_;
						if(compare._057_ != wires._057_) changed = 1;
						compare._057_ = wires._057_;
						if(compare._058_ != wires._058_) changed = 1;
						compare._058_ = wires._058_;
						if(compare._059_ != wires._059_) changed = 1;
						compare._059_ = wires._059_;
						if(compare._060_ != wires._060_) changed = 1;
						compare._060_ = wires._060_;
						if(compare._061_ != wires._061_) changed = 1;
						compare._061_ = wires._061_;
						if(compare._062_ != wires._062_) changed = 1;
						compare._062_ = wires._062_;
						if(compare._063_ != wires._063_) changed = 1;
						compare._063_ = wires._063_;
						if(compare._064_ != wires._064_) changed = 1;
						compare._064_ = wires._064_;
						if(compare._065_ != wires._065_) changed = 1;
						compare._065_ = wires._065_;
						if(compare._066_ != wires._066_) changed = 1;
						compare._066_ = wires._066_;
						if(compare._067_ != wires._067_) changed = 1;
						compare._067_ = wires._067_;
						if(compare._068_ != wires._068_) changed = 1;
						compare._068_ = wires._068_;
						if(compare._069_ != wires._069_) changed = 1;
						compare._069_ = wires._069_;
						if(compare._070_ != wires._070_) changed = 1;
						compare._070_ = wires._070_;
						if(compare._071_ != wires._071_) changed = 1;
						compare._071_ = wires._071_;
						if(compare._072_ != wires._072_) changed = 1;
						compare._072_ = wires._072_;
						if(compare._073_ != wires._073_) changed = 1;
						compare._073_ = wires._073_;
						if(compare._074_ != wires._074_) changed = 1;
						compare._074_ = wires._074_;
						if(compare._075_ != wires._075_) changed = 1;
						compare._075_ = wires._075_;
						if(compare._076_ != wires._076_) changed = 1;
						compare._076_ = wires._076_;
						if(compare._077_ != wires._077_) changed = 1;
						compare._077_ = wires._077_;
						if(compare._078_ != wires._078_) changed = 1;
						compare._078_ = wires._078_;
						if(compare._079_ != wires._079_) changed = 1;
						compare._079_ = wires._079_;
						if(compare._080_ != wires._080_) changed = 1;
						compare._080_ = wires._080_;
						if(compare._081_ != wires._081_) changed = 1;
						compare._081_ = wires._081_;
						if(compare._082_ != wires._082_) changed = 1;
						compare._082_ = wires._082_;
						if(compare._083_ != wires._083_) changed = 1;
						compare._083_ = wires._083_;
						if(compare._084_ != wires._084_) changed = 1;
						compare._084_ = wires._084_;
						if(compare._085_ != wires._085_) changed = 1;
						compare._085_ = wires._085_;
						if(compare._086_ != wires._086_) changed = 1;
						compare._086_ = wires._086_;
						if(compare._087_ != wires._087_) changed = 1;
						compare._087_ = wires._087_;
						if(compare._088_ != wires._088_) changed = 1;
						compare._088_ = wires._088_;
						if(compare._089_ != wires._089_) changed = 1;
						compare._089_ = wires._089_;
						if(compare._090_ != wires._090_) changed = 1;
						compare._090_ = wires._090_;
						if(compare._091_ != wires._091_) changed = 1;
						compare._091_ = wires._091_;
						if(compare._092_ != wires._092_) changed = 1;
						compare._092_ = wires._092_;
						if(compare._093_ != wires._093_) changed = 1;
						compare._093_ = wires._093_;
						if(compare._094_ != wires._094_) changed = 1;
						compare._094_ = wires._094_;
						if(compare._095_ != wires._095_) changed = 1;
						compare._095_ = wires._095_;
						if(compare._096_ != wires._096_) changed = 1;
						compare._096_ = wires._096_;
						if(compare._097_ != wires._097_) changed = 1;
						compare._097_ = wires._097_;
						if(compare._098_ != wires._098_) changed = 1;
						compare._098_ = wires._098_;
						if(compare._099_ != wires._099_) changed = 1;
						compare._099_ = wires._099_;
						if(compare._100_ != wires._100_) changed = 1;
						compare._100_ = wires._100_;
						if(compare._101_ != wires._101_) changed = 1;
						compare._101_ = wires._101_;
						if(compare._102_ != wires._102_) changed = 1;
						compare._102_ = wires._102_;
						if(compare._103_ != wires._103_) changed = 1;
						compare._103_ = wires._103_;
						if(compare._104_ != wires._104_) changed = 1;
						compare._104_ = wires._104_;
						if(compare._105_ != wires._105_) changed = 1;
						compare._105_ = wires._105_;
						if(compare._106_ != wires._106_) changed = 1;
						compare._106_ = wires._106_;
						if(compare._107_ != wires._107_) changed = 1;
						compare._107_ = wires._107_;
						if(compare._108_ != wires._108_) changed = 1;
						compare._108_ = wires._108_;
						if(compare._109_ != wires._109_) changed = 1;
						compare._109_ = wires._109_;
						if(compare._110_ != wires._110_) changed = 1;
						compare._110_ = wires._110_;
						if(compare._111_ != wires._111_) changed = 1;
						compare._111_ = wires._111_;
						if(compare._112_ != wires._112_) changed = 1;
						compare._112_ = wires._112_;
						if(compare._113_ != wires._113_) changed = 1;
						compare._113_ = wires._113_;
						if(compare._114_ != wires._114_) changed = 1;
						compare._114_ = wires._114_;
						if(compare._115_ != wires._115_) changed = 1;
						compare._115_ = wires._115_;
						if(compare._116_ != wires._116_) changed = 1;
						compare._116_ = wires._116_;
						if(compare._117_ != wires._117_) changed = 1;
						compare._117_ = wires._117_;
						if(compare._118_ != wires._118_) changed = 1;
						compare._118_ = wires._118_;
						if(compare._119_ != wires._119_) changed = 1;
						compare._119_ = wires._119_;
						if(compare._120_ != wires._120_) changed = 1;
						compare._120_ = wires._120_;
						if(compare._121_ != wires._121_) changed = 1;
						compare._121_ = wires._121_;
						if(compare._122_ != wires._122_) changed = 1;
						compare._122_ = wires._122_;
						if(compare._123_ != wires._123_) changed = 1;
						compare._123_ = wires._123_;
						if(compare._124_ != wires._124_) changed = 1;
						compare._124_ = wires._124_;
						if(compare._125_ != wires._125_) changed = 1;
						compare._125_ = wires._125_;
						if(compare._126_ != wires._126_) changed = 1;
						compare._126_ = wires._126_;
						if(compare._127_ != wires._127_) changed = 1;
						compare._127_ = wires._127_;
						if(compare._128_ != wires._128_) changed = 1;
						compare._128_ = wires._128_;
						if(compare._129_ != wires._129_) changed = 1;
						compare._129_ = wires._129_;
						if(compare._130_ != wires._130_) changed = 1;
						compare._130_ = wires._130_;
						if(compare._131_ != wires._131_) changed = 1;
						compare._131_ = wires._131_;
						if(compare._132_ != wires._132_) changed = 1;
						compare._132_ = wires._132_;
						if(compare._133_ != wires._133_) changed = 1;
						compare._133_ = wires._133_;
						if(compare._134_ != wires._134_) changed = 1;
						compare._134_ = wires._134_;
						if(compare._135_ != wires._135_) changed = 1;
						compare._135_ = wires._135_;
						if(compare._136_ != wires._136_) changed = 1;
						compare._136_ = wires._136_;
						if(compare._137_ != wires._137_) changed = 1;
						compare._137_ = wires._137_;
						if(compare._138_ != wires._138_) changed = 1;
						compare._138_ = wires._138_;
						if(compare._139_ != wires._139_) changed = 1;
						compare._139_ = wires._139_;
						if(compare._140_ != wires._140_) changed = 1;
						compare._140_ = wires._140_;
						if(compare._141_ != wires._141_) changed = 1;
						compare._141_ = wires._141_;
						if(compare._142_ != wires._142_) changed = 1;
						compare._142_ = wires._142_;
						if(compare._143_ != wires._143_) changed = 1;
						compare._143_ = wires._143_;
						if(compare._144_ != wires._144_) changed = 1;
						compare._144_ = wires._144_;
						if(compare._145_ != wires._145_) changed = 1;
						compare._145_ = wires._145_;
						if(compare._146_ != wires._146_) changed = 1;
						compare._146_ = wires._146_;
						if(compare._147_ != wires._147_) changed = 1;
						compare._147_ = wires._147_;
						if(compare._148_ != wires._148_) changed = 1;
						compare._148_ = wires._148_;
						if(compare._149_ != wires._149_) changed = 1;
						compare._149_ = wires._149_;
						if(compare._150_ != wires._150_) changed = 1;
						compare._150_ = wires._150_;
						if(compare._151_ != wires._151_) changed = 1;
						compare._151_ = wires._151_;
						if(compare._152_ != wires._152_) changed = 1;
						compare._152_ = wires._152_;
						if(compare._153_ != wires._153_) changed = 1;
						compare._153_ = wires._153_;
						if(compare._154_ != wires._154_) changed = 1;
						compare._154_ = wires._154_;
						if(compare._155_ != wires._155_) changed = 1;
						compare._155_ = wires._155_;
						if(compare._156_ != wires._156_) changed = 1;
						compare._156_ = wires._156_;
						if(compare._157_ != wires._157_) changed = 1;
						compare._157_ = wires._157_;
						if(compare._158_ != wires._158_) changed = 1;
						compare._158_ = wires._158_;
						if(compare._159_ != wires._159_) changed = 1;
						compare._159_ = wires._159_;
						if(compare._160_ != wires._160_) changed = 1;
						compare._160_ = wires._160_;
						if(compare._161_ != wires._161_) changed = 1;
						compare._161_ = wires._161_;
						if(compare_io.CLK != io.CLK) changed = 1;
						compare_io.CLK = io.CLK;
						for(int i = 0; i < 8; i++) {
							if(compare_io.LEDS[i] != io.LEDS[i]) changed = 1;
							compare_io.LEDS[i] = io.LEDS[i];
						}
						if(compare_io.ROLL != io.ROLL) changed = 1;
						compare_io.ROLL = io.ROLL;
						if(compare_io.RST != io.RST) changed = 1;
						compare_io.RST = io.RST;
						for(int i = 0; i < 16; i++) {
							if(compare.lfsr[i] != wires.lfsr[i]) changed = 1;
							compare.lfsr[i] = wires.lfsr[i];
						}
						for(int i = 0; i < 7; i++) {
							if(compare.segments[i] != wires.segments[i]) changed = 1;
							compare.segments[i] = wires.segments[i];
						}

						if(!changed && iter_count > 1) break;
					}

					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__0__  = wires._004_[15];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__1__  = wires._004_[1];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__2__  = wires._004_[2];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__3__  = wires._004_[3];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__4__  = wires._004_[4];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__5__  = wires._004_[5];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__6__  = wires._004_[6];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__7__  = wires._004_[7];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__8__  = wires._004_[8];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__9__  = wires._004_[9];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__10__  = wires._004_[10];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__11__  = wires._004_[11];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__12__  = wires._004_[12];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__13__  = wires._004_[13];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs._lfsr_reg__14__  = wires._004_[14];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.clkdiv[0] = wires._001_[0];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.clkdiv[1] = wires._001_[1];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.clkdiv[2] = wires._001_[2];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.clkdiv[3] = wires._001_[3];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.clkdiv[4] = wires._001_[4];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.clkdiv[5] = wires._001_[5];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.clkdiv[6] = wires._001_[6];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.clkdiv[7] = wires._001_[7];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.counter[0] = wires._002_[0];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.counter[1] = wires._002_[1];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.counter[2] = wires._002_[2];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.counter[3] = wires._002_[3];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.counter[4] = wires._002_[4];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.counter[5] = wires._002_[5];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.counter[6] = wires._002_[6];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.counter[7] = wires._002_[7];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.bcd[0] = wires._000_[0];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.bcd[1] = wires._000_[1];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.bcd[2] = wires._000_[2];
					if(io.CLK != io.clk_prev_CLK && io.CLK)
						regs.dp = wires._003_;
					}

					io.clk_prev_CLK = io.CLK;

					//Oh my god, this part sucks
					switch(idx) {
						case 0:
							col.r = wires._000_[0] ? 1 : 0;
							break;
						case 1:
							col.r = wires._000_[1] ? 1 : 0;
							break;
						case 2:
							col.r = wires._000_[2] ? 1 : 0;
							break;
						case 3:
							col.r = wires._001_[0] ? 1 : 0;
							break;
						case 4:
							col.r = wires._001_[1] ? 1 : 0;
							break;
						case 5:
							col.r = wires._001_[2] ? 1 : 0;
							break;
						case 6:
							col.r = wires._001_[3] ? 1 : 0;
							break;
						case 7:
							col.r = wires._001_[4] ? 1 : 0;
							break;
						case 8:
							col.r = wires._001_[5] ? 1 : 0;
							break;
						case 9:
							col.r = wires._001_[6] ? 1 : 0;
							break;
						case 10:
							col.r = wires._001_[7] ? 1 : 0;
							break;
						case 11:
							col.r = wires._002_[0] ? 1 : 0;
							break;
						case 12:
							col.r = wires._002_[1] ? 1 : 0;
							break;
						case 13:
							col.r = wires._002_[2] ? 1 : 0;
							break;
						case 14:
							col.r = wires._002_[3] ? 1 : 0;
							break;
						case 15:
							col.r = wires._002_[4] ? 1 : 0;
							break;
						case 16:
							col.r = wires._002_[5] ? 1 : 0;
							break;
						case 17:
							col.r = wires._002_[6] ? 1 : 0;
							break;
						case 18:
							col.r = wires._002_[7] ? 1 : 0;
							break;
						case 19:
							col.r = wires._003_ ? 1 : 0;
							break;
						case 20:
							col.r = wires._004_[0] ? 1 : 0;
							break;
						case 21:
							col.r = wires._004_[1] ? 1 : 0;
							break;
						case 22:
							col.r = wires._004_[2] ? 1 : 0;
							break;
						case 23:
							col.r = wires._004_[3] ? 1 : 0;
							break;
						case 24:
							col.r = wires._004_[4] ? 1 : 0;
							break;
						case 25:
							col.r = wires._004_[5] ? 1 : 0;
							break;
						case 26:
							col.r = wires._004_[6] ? 1 : 0;
							break;
						case 27:
							col.r = wires._004_[7] ? 1 : 0;
							break;
						case 28:
							col.r = wires._004_[8] ? 1 : 0;
							break;
						case 29:
							col.r = wires._004_[9] ? 1 : 0;
							break;
						case 30:
							col.r = wires._004_[10] ? 1 : 0;
							break;
						case 31:
							col.r = wires._004_[11] ? 1 : 0;
							break;
						case 32:
							col.r = wires._004_[12] ? 1 : 0;
							break;
						case 33:
							col.r = wires._004_[13] ? 1 : 0;
							break;
						case 34:
							col.r = wires._004_[14] ? 1 : 0;
							break;
						case 35:
							col.r = wires._004_[15] ? 1 : 0;
							break;
						case 36:
							col.r = wires._005_ ? 1 : 0;
							break;
						case 37:
							col.r = wires._006_ ? 1 : 0;
							break;
						case 38:
							col.r = wires._007_ ? 1 : 0;
							break;
						case 39:
							col.r = wires._008_ ? 1 : 0;
							break;
						case 40:
							col.r = wires._009_ ? 1 : 0;
							break;
						case 41:
							col.r = wires._010_ ? 1 : 0;
							break;
						case 42:
							col.r = wires._011_ ? 1 : 0;
							break;
						case 43:
							col.r = wires._012_ ? 1 : 0;
							break;
						case 44:
							col.r = wires._013_ ? 1 : 0;
							break;
						case 45:
							col.r = wires._014_ ? 1 : 0;
							break;
						case 46:
							col.r = wires._015_ ? 1 : 0;
							break;
						case 47:
							col.r = wires._016_ ? 1 : 0;
							break;
						case 48:
							col.r = wires._017_ ? 1 : 0;
							break;
						case 49:
							col.r = wires._018_ ? 1 : 0;
							break;
						case 50:
							col.r = wires._019_ ? 1 : 0;
							break;
						case 51:
							col.r = wires._020_ ? 1 : 0;
							break;
						case 52:
							col.r = wires._021_ ? 1 : 0;
							break;
						case 53:
							col.r = wires._022_ ? 1 : 0;
							break;
						case 54:
							col.r = wires._023_ ? 1 : 0;
							break;
						case 55:
							col.r = wires._024_ ? 1 : 0;
							break;
						case 56:
							col.r = wires._025_ ? 1 : 0;
							break;
						case 57:
							col.r = wires._026_ ? 1 : 0;
							break;
						case 58:
							col.r = wires._027_ ? 1 : 0;
							break;
						case 59:
							col.r = wires._028_ ? 1 : 0;
							break;
						case 60:
							col.r = wires._029_ ? 1 : 0;
							break;
						case 61:
							col.r = wires._030_ ? 1 : 0;
							break;
						case 62:
							col.r = wires._031_ ? 1 : 0;
							break;
						case 63:
							col.r = wires._032_ ? 1 : 0;
							break;
						case 64:
							col.r = wires._033_ ? 1 : 0;
							break;
						case 65:
							col.r = wires._034_ ? 1 : 0;
							break;
						case 66:
							col.r = wires._035_ ? 1 : 0;
							break;
						case 67:
							col.r = wires._036_ ? 1 : 0;
							break;
						case 68:
							col.r = wires._037_ ? 1 : 0;
							break;
						case 69:
							col.r = wires._038_ ? 1 : 0;
							break;
						case 70:
							col.r = wires._039_ ? 1 : 0;
							break;
						case 71:
							col.r = wires._040_ ? 1 : 0;
							break;
						case 72:
							col.r = wires._041_ ? 1 : 0;
							break;
						case 73:
							col.r = wires._042_ ? 1 : 0;
							break;
						case 74:
							col.r = wires._043_ ? 1 : 0;
							break;
						case 75:
							col.r = wires._044_ ? 1 : 0;
							break;
						case 76:
							col.r = wires._045_ ? 1 : 0;
							break;
						case 77:
							col.r = wires._046_ ? 1 : 0;
							break;
						case 78:
							col.r = wires._047_ ? 1 : 0;
							break;
						case 79:
							col.r = wires._048_ ? 1 : 0;
							break;
						case 80:
							col.r = wires._049_ ? 1 : 0;
							break;
						case 81:
							col.r = wires._050_ ? 1 : 0;
							break;
						case 82:
							col.r = wires._051_ ? 1 : 0;
							break;
						case 83:
							col.r = wires._052_ ? 1 : 0;
							break;
						case 84:
							col.r = wires._053_ ? 1 : 0;
							break;
						case 85:
							col.r = wires._054_ ? 1 : 0;
							break;
						case 86:
							col.r = wires._055_ ? 1 : 0;
							break;
						case 87:
							col.r = wires._056_ ? 1 : 0;
							break;
						case 88:
							col.r = wires._057_ ? 1 : 0;
							break;
						case 89:
							col.r = wires._058_ ? 1 : 0;
							break;
						case 90:
							col.r = wires._059_ ? 1 : 0;
							break;
						case 91:
							col.r = wires._060_ ? 1 : 0;
							break;
						case 92:
							col.r = wires._061_ ? 1 : 0;
							break;
						case 93:
							col.r = wires._062_ ? 1 : 0;
							break;
						case 94:
							col.r = wires._063_ ? 1 : 0;
							break;
						case 95:
							col.r = wires._064_ ? 1 : 0;
							break;
						case 96:
							col.r = wires._065_ ? 1 : 0;
							break;
						case 97:
							col.r = wires._066_ ? 1 : 0;
							break;
						case 98:
							col.r = wires._067_ ? 1 : 0;
							break;
						case 99:
							col.r = wires._068_ ? 1 : 0;
							break;
						case 100:
							col.r = wires._069_ ? 1 : 0;
							break;
						case 101:
							col.r = wires._070_ ? 1 : 0;
							break;
						case 102:
							col.r = wires._071_ ? 1 : 0;
							break;
						case 103:
							col.r = wires._072_ ? 1 : 0;
							break;
						case 104:
							col.r = wires._073_ ? 1 : 0;
							break;
						case 105:
							col.r = wires._074_ ? 1 : 0;
							break;
						case 106:
							col.r = wires._075_ ? 1 : 0;
							break;
						case 107:
							col.r = wires._076_ ? 1 : 0;
							break;
						case 108:
							col.r = wires._077_ ? 1 : 0;
							break;
						case 109:
							col.r = wires._078_ ? 1 : 0;
							break;
						case 110:
							col.r = wires._079_ ? 1 : 0;
							break;
						case 111:
							col.r = wires._080_ ? 1 : 0;
							break;
						case 112:
							col.r = wires._081_ ? 1 : 0;
							break;
						case 113:
							col.r = wires._082_ ? 1 : 0;
							break;
						case 114:
							col.r = wires._083_ ? 1 : 0;
							break;
						case 115:
							col.r = wires._084_ ? 1 : 0;
							break;
						case 116:
							col.r = wires._085_ ? 1 : 0;
							break;
						case 117:
							col.r = wires._086_ ? 1 : 0;
							break;
						case 118:
							col.r = wires._087_ ? 1 : 0;
							break;
						case 119:
							col.r = wires._088_ ? 1 : 0;
							break;
						case 120:
							col.r = wires._089_ ? 1 : 0;
							break;
						case 121:
							col.r = wires._090_ ? 1 : 0;
							break;
						case 122:
							col.r = wires._091_ ? 1 : 0;
							break;
						case 123:
							col.r = wires._092_ ? 1 : 0;
							break;
						case 124:
							col.r = wires._093_ ? 1 : 0;
							break;
						case 125:
							col.r = wires._094_ ? 1 : 0;
							break;
						case 126:
							col.r = wires._095_ ? 1 : 0;
							break;
						case 127:
							col.r = wires._096_ ? 1 : 0;
							break;
						case 128:
							col.r = wires._097_ ? 1 : 0;
							break;
						case 129:
							col.r = wires._098_ ? 1 : 0;
							break;
						case 130:
							col.r = wires._099_ ? 1 : 0;
							break;
						case 131:
							col.r = wires._100_ ? 1 : 0;
							break;
						case 132:
							col.r = wires._101_ ? 1 : 0;
							break;
						case 133:
							col.r = wires._102_ ? 1 : 0;
							break;
						case 134:
							col.r = wires._103_ ? 1 : 0;
							break;
						case 135:
							col.r = wires._104_ ? 1 : 0;
							break;
						case 136:
							col.r = wires._105_ ? 1 : 0;
							break;
						case 137:
							col.r = wires._106_ ? 1 : 0;
							break;
						case 138:
							col.r = wires._107_ ? 1 : 0;
							break;
						case 139:
							col.r = wires._108_ ? 1 : 0;
							break;
						case 140:
							col.r = wires._109_ ? 1 : 0;
							break;
						case 141:
							col.r = wires._110_ ? 1 : 0;
							break;
						case 142:
							col.r = wires._111_ ? 1 : 0;
							break;
						case 143:
							col.r = wires._112_ ? 1 : 0;
							break;
						case 144:
							col.r = wires._113_ ? 1 : 0;
							break;
						case 145:
							col.r = wires._114_ ? 1 : 0;
							break;
						case 146:
							col.r = wires._115_ ? 1 : 0;
							break;
						case 147:
							col.r = wires._116_ ? 1 : 0;
							break;
						case 148:
							col.r = wires._117_ ? 1 : 0;
							break;
						case 149:
							col.r = wires._118_ ? 1 : 0;
							break;
						case 150:
							col.r = wires._119_ ? 1 : 0;
							break;
						case 151:
							col.r = wires._120_ ? 1 : 0;
							break;
						case 152:
							col.r = wires._121_ ? 1 : 0;
							break;
						case 153:
							col.r = wires._122_ ? 1 : 0;
							break;
						case 154:
							col.r = wires._123_ ? 1 : 0;
							break;
						case 155:
							col.r = wires._124_ ? 1 : 0;
							break;
						case 156:
							col.r = wires._125_ ? 1 : 0;
							break;
						case 157:
							col.r = wires._126_ ? 1 : 0;
							break;
						case 158:
							col.r = wires._127_ ? 1 : 0;
							break;
						case 159:
							col.r = wires._128_ ? 1 : 0;
							break;
						case 160:
							col.r = wires._129_ ? 1 : 0;
							break;
						case 161:
							col.r = wires._130_ ? 1 : 0;
							break;
						case 162:
							col.r = wires._131_ ? 1 : 0;
							break;
						case 163:
							col.r = wires._132_ ? 1 : 0;
							break;
						case 164:
							col.r = wires._133_ ? 1 : 0;
							break;
						case 165:
							col.r = wires._134_ ? 1 : 0;
							break;
						case 166:
							col.r = wires._135_ ? 1 : 0;
							break;
						case 167:
							col.r = wires._136_ ? 1 : 0;
							break;
						case 168:
							col.r = wires._137_ ? 1 : 0;
							break;
						case 169:
							col.r = wires._138_ ? 1 : 0;
							break;
						case 170:
							col.r = wires._139_ ? 1 : 0;
							break;
						case 171:
							col.r = wires._140_ ? 1 : 0;
							break;
						case 172:
							col.r = wires._141_ ? 1 : 0;
							break;
						case 173:
							col.r = wires._142_ ? 1 : 0;
							break;
						case 174:
							col.r = wires._143_ ? 1 : 0;
							break;
						case 175:
							col.r = wires._144_ ? 1 : 0;
							break;
						case 176:
							col.r = wires._145_ ? 1 : 0;
							break;
						case 177:
							col.r = wires._146_ ? 1 : 0;
							break;
						case 178:
							col.r = wires._147_ ? 1 : 0;
							break;
						case 179:
							col.r = wires._148_ ? 1 : 0;
							break;
						case 180:
							col.r = wires._149_ ? 1 : 0;
							break;
						case 181:
							col.r = wires._150_ ? 1 : 0;
							break;
						case 182:
							col.r = wires._151_ ? 1 : 0;
							break;
						case 183:
							col.r = wires._152_ ? 1 : 0;
							break;
						case 184:
							col.r = wires._153_ ? 1 : 0;
							break;
						case 185:
							col.r = wires._154_ ? 1 : 0;
							break;
						case 186:
							col.r = wires._155_ ? 1 : 0;
							break;
						case 187:
							col.r = wires._156_ ? 1 : 0;
							break;
						case 188:
							col.r = wires._157_ ? 1 : 0;
							break;
						case 189:
							col.r = wires._158_ ? 1 : 0;
							break;
						case 190:
							col.r = wires._159_ ? 1 : 0;
							break;
						case 191:
							col.r = wires._160_ ? 1 : 0;
							break;
						case 192:
							col.r = wires._161_ ? 1 : 0;
							break;
						case 193:
							col.r = io.CLK ? 1 : 0;
							col.g = io.clk_prev_CLK ? 1 : 0;
							col.b = io.CLK ? 1 : 0;
							break;
						case 194:
							col.r = io.LEDS[0] ? 1 : 0;
							col.b = io.LEDS[0] ? 1 : 0;
							break;
						case 195:
							col.r = io.LEDS[1] ? 1 : 0;
							col.b = io.LEDS[1] ? 1 : 0;
							break;
						case 196:
							col.r = io.LEDS[2] ? 1 : 0;
							col.b = io.LEDS[2] ? 1 : 0;
							break;
						case 197:
							col.r = io.LEDS[3] ? 1 : 0;
							col.b = io.LEDS[3] ? 1 : 0;
							break;
						case 198:
							col.r = io.LEDS[4] ? 1 : 0;
							col.b = io.LEDS[4] ? 1 : 0;
							break;
						case 199:
							col.r = io.LEDS[5] ? 1 : 0;
							col.b = io.LEDS[5] ? 1 : 0;
							break;
						case 200:
							col.r = io.LEDS[6] ? 1 : 0;
							col.b = io.LEDS[6] ? 1 : 0;
							break;
						case 201:
							col.r = io.LEDS[7] ? 1 : 0;
							col.b = io.LEDS[7] ? 1 : 0;
							break;
						case 202:
							col.r = io.ROLL ? 1 : 0;
							col.b = io.ROLL ? 1 : 0;
							break;
						case 203:
							col.r = io.RST ? 1 : 0;
							col.b = io.RST ? 1 : 0;
							break;
						case 204:
							col.r = wires.lfsr[0] ? 1 : 0;
							break;
						case 205:
							col.r = wires.lfsr[1] ? 1 : 0;
							break;
						case 206:
							col.r = wires.lfsr[2] ? 1 : 0;
							break;
						case 207:
							col.r = wires.lfsr[3] ? 1 : 0;
							break;
						case 208:
							col.r = wires.lfsr[4] ? 1 : 0;
							break;
						case 209:
							col.r = wires.lfsr[5] ? 1 : 0;
							break;
						case 210:
							col.r = wires.lfsr[6] ? 1 : 0;
							break;
						case 211:
							col.r = wires.lfsr[7] ? 1 : 0;
							break;
						case 212:
							col.r = wires.lfsr[8] ? 1 : 0;
							break;
						case 213:
							col.r = wires.lfsr[9] ? 1 : 0;
							break;
						case 214:
							col.r = wires.lfsr[10] ? 1 : 0;
							break;
						case 215:
							col.r = wires.lfsr[11] ? 1 : 0;
							break;
						case 216:
							col.r = wires.lfsr[12] ? 1 : 0;
							break;
						case 217:
							col.r = wires.lfsr[13] ? 1 : 0;
							break;
						case 218:
							col.r = wires.lfsr[14] ? 1 : 0;
							break;
						case 219:
							col.r = wires.lfsr[15] ? 1 : 0;
							break;
						case 220:
							col.r = wires.segments[0] ? 1 : 0;
							break;
						case 221:
							col.r = wires.segments[1] ? 1 : 0;
							break;
						case 222:
							col.r = wires.segments[2] ? 1 : 0;
							break;
						case 223:
							col.r = wires.segments[3] ? 1 : 0;
							break;
						case 224:
							col.r = wires.segments[4] ? 1 : 0;
							break;
						case 225:
							col.r = wires.segments[5] ? 1 : 0;
							break;
						case 226:
							col.r = wires.segments[6] ? 1 : 0;
							break;
						case 16383:
							col.r = regs.bcd[0] ? 1 : 0;
							break;
						case 16382:
							col.r = regs.bcd[1] ? 1 : 0;
							break;
						case 16381:
							col.r = regs.bcd[2] ? 1 : 0;
							break;
						case 16380:
							col.r = regs.clkdiv[0] ? 1 : 0;
							break;
						case 16379:
							col.r = regs.clkdiv[1] ? 1 : 0;
							break;
						case 16378:
							col.r = regs.clkdiv[2] ? 1 : 0;
							break;
						case 16377:
							col.r = regs.clkdiv[3] ? 1 : 0;
							break;
						case 16376:
							col.r = regs.clkdiv[4] ? 1 : 0;
							break;
						case 16375:
							col.r = regs.clkdiv[5] ? 1 : 0;
							break;
						case 16374:
							col.r = regs.clkdiv[6] ? 1 : 0;
							break;
						case 16373:
							col.r = regs.clkdiv[7] ? 1 : 0;
							break;
						case 16372:
							col.r = regs.counter[0] ? 1 : 0;
							break;
						case 16371:
							col.r = regs.counter[1] ? 1 : 0;
							break;
						case 16370:
							col.r = regs.counter[2] ? 1 : 0;
							break;
						case 16369:
							col.r = regs.counter[3] ? 1 : 0;
							break;
						case 16368:
							col.r = regs.counter[4] ? 1 : 0;
							break;
						case 16367:
							col.r = regs.counter[5] ? 1 : 0;
							break;
						case 16366:
							col.r = regs.counter[6] ? 1 : 0;
							break;
						case 16365:
							col.r = regs.counter[7] ? 1 : 0;
							break;
						case 16364:
							col.r = regs.dp ? 1 : 0;
							break;
						case 16363:
							col.r = regs._lfsr_reg__0__ ? 1 : 0;
							break;
						case 16362:
							col.r = regs._lfsr_reg__1__ ? 1 : 0;
							break;
						case 16361:
							col.r = regs._lfsr_reg__2__ ? 1 : 0;
							break;
						case 16360:
							col.r = regs._lfsr_reg__3__ ? 1 : 0;
							break;
						case 16359:
							col.r = regs._lfsr_reg__4__ ? 1 : 0;
							break;
						case 16358:
							col.r = regs._lfsr_reg__5__ ? 1 : 0;
							break;
						case 16357:
							col.r = regs._lfsr_reg__6__ ? 1 : 0;
							break;
						case 16356:
							col.r = regs._lfsr_reg__7__ ? 1 : 0;
							break;
						case 16355:
							col.r = regs._lfsr_reg__8__ ? 1 : 0;
							break;
						case 16354:
							col.r = regs._lfsr_reg__9__ ? 1 : 0;
							break;
						case 16353:
							col.r = regs._lfsr_reg__10__ ? 1 : 0;
							break;
						case 16352:
							col.r = regs._lfsr_reg__11__ ? 1 : 0;
							break;
						case 16351:
							col.r = regs._lfsr_reg__12__ ? 1 : 0;
							break;
						case 16350:
							col.r = regs._lfsr_reg__13__ ? 1 : 0;
							break;
						case 16349:
							col.r = regs._lfsr_reg__14__ ? 1 : 0;
							break;
					}
					return col;
				}
			ENDCG
		}
	}
}
