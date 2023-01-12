/* Generated by Yosys 0.9 (git sha1 1979e0b) */

(* src = "dice.v:1" *)
module dice(CLK, RST, ROLL, LEDS);
  (* src = "dice.v:24" *)
  wire [2:0] _000_;
  (* src = "dice.v:24" *)
  wire [7:0] _001_;
  (* src = "dice.v:24" *)
  wire [7:0] _002_;
  (* src = "dice.v:24" *)
  wire _003_;
  (* src = "dice.v:24" *)
  wire [15:0] _004_;
  wire _005_;
  wire _006_;
  wire _007_;
  wire _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  wire _063_;
  wire _064_;
  wire _065_;
  wire _066_;
  wire _067_;
  wire _068_;
  wire _069_;
  wire _070_;
  wire _071_;
  wire _072_;
  wire _073_;
  wire _074_;
  wire _075_;
  wire _076_;
  wire _077_;
  wire _078_;
  wire _079_;
  wire _080_;
  wire _081_;
  wire _082_;
  wire _083_;
  wire _084_;
  wire _085_;
  wire _086_;
  wire _087_;
  wire _088_;
  wire _089_;
  wire _090_;
  wire _091_;
  wire _092_;
  wire _093_;
  wire _094_;
  wire _095_;
  wire _096_;
  wire _097_;
  wire _098_;
  wire _099_;
  wire _100_;
  wire _101_;
  wire _102_;
  wire _103_;
  wire _104_;
  wire _105_;
  wire _106_;
  wire _107_;
  wire _108_;
  wire _109_;
  wire _110_;
  wire _111_;
  wire _112_;
  wire _113_;
  wire _114_;
  wire _115_;
  wire _116_;
  wire _117_;
  wire _118_;
  wire _119_;
  wire _120_;
  wire _121_;
  wire _122_;
  wire _123_;
  wire _124_;
  wire _125_;
  wire _126_;
  wire _127_;
  wire _128_;
  wire _129_;
  wire _130_;
  wire _131_;
  wire _132_;
  wire _133_;
  wire _134_;
  wire _135_;
  wire _136_;
  wire _137_;
  wire _138_;
  wire _139_;
  wire _140_;
  wire _141_;
  wire _142_;
  wire _143_;
  wire _144_;
  wire _145_;
  wire _146_;
  wire _147_;
  wire _148_;
  wire _149_;
  wire _150_;
  wire _151_;
  wire _152_;
  wire _153_;
  wire _154_;
  wire _155_;
  wire _156_;
  wire _157_;
  wire _158_;
  wire _159_;
  wire _160_;
  wire _161_;
  (* src = "dice.v:1" *)
  input CLK;
  (* src = "dice.v:1" *)
  output [7:0] LEDS;
  (* src = "dice.v:1" *)
  input ROLL;
  (* src = "dice.v:1" *)
  input RST;
  (* src = "dice.v:2" *)
  reg [2:0] bcd;
  (* src = "dice.v:19" *)
  reg [7:0] clkdiv;
  (* src = "dice.v:20" *)
  reg [7:0] counter;
  (* src = "dice.v:21" *)
  reg dp;
  (* src = "dice.v:18" *)
  wire [15:0] lfsr;
  (* src = "dice.v:3" *)
  wire [6:0] segments;
  assign _059_ = ~lfsr[2];
  assign _060_ = ~(lfsr[2] ^ lfsr[1]);
  assign _061_ = _013_ ? _059_ : _060_;
  assign _062_ = _055_ ? _058_ : _061_;
  assign _063_ = _010_ ? _058_ : _062_;
  assign _000_[1] = _149_ & ~(_063_);
  assign _064_ = ~bcd[2];
  assign _065_ = ~(lfsr[2] & lfsr[1]);
  assign _066_ = _065_ ^ lfsr[3];
  assign _067_ = _013_ ? lfsr[3] : _066_;
  assign _068_ = _055_ ? _064_ : _067_;
  assign _069_ = _010_ ? _064_ : _068_;
  assign _000_[2] = _149_ & ~(_069_);
  assign _070_ = ~(_055_ ^ _153_);
  assign _071_ = _010_ ? _153_ : _070_;
  assign _001_[0] = _149_ & ~(_071_);
  assign _072_ = ~(_154_ ^ _153_);
  assign _073_ = _055_ ? _154_ : _072_;
  assign _074_ = _010_ ? _154_ : _073_;
  assign _001_[1] = _149_ & ~(_074_);
  assign _075_ = ~_156_;
  assign _076_ = _154_ | _153_;
  assign _077_ = _076_ ^ _075_;
  assign _078_ = _055_ ? _156_ : _077_;
  assign _079_ = _010_ ? _156_ : _078_;
  assign _001_[2] = _149_ & ~(_079_);
  assign _080_ = _075_ & ~(_076_);
  assign _081_ = _080_ ^ _157_;
  assign _082_ = _055_ ? _157_ : _081_;
  assign _083_ = _010_ ? _157_ : _082_;
  assign _001_[3] = _149_ & ~(_083_);
  assign _084_ = ~_160_;
  assign _085_ = _157_ | _156_;
  assign _086_ = _085_ | _076_;
  assign _087_ = _086_ ^ _160_;
  assign _088_ = _055_ ? _084_ : _087_;
  assign _089_ = _010_ ? _084_ : _088_;
  assign _001_[4] = _149_ & ~(_089_);
  assign _090_ = _160_ & ~(_086_);
  assign _091_ = _090_ ^ _161_;
  assign _092_ = _055_ ? _161_ : _091_;
  assign _093_ = _010_ ? _161_ : _092_;
  assign _001_[5] = _093_ | RST;
  assign _094_ = ~(_161_ & _160_);
  assign _095_ = _094_ | _086_;
  assign _096_ = _095_ ^ _006_;
  assign _097_ = _055_ ? _043_ : _096_;
  assign _098_ = _010_ ? _043_ : _097_;
  assign _001_[6] = _149_ & ~(_098_);
  assign _099_ = _006_ & ~(_095_);
  assign _100_ = _099_ ^ _007_;
  assign _101_ = _055_ ? _007_ : _100_;
  assign _102_ = _010_ ? _007_ : _101_;
  assign _001_[7] = _102_ | RST;
  assign _103_ = ~_015_;
  assign _104_ = _055_ & ~(_103_);
  assign _105_ = _010_ ? _103_ : _104_;
  assign _002_[0] = RST ? counter[0] : _105_;
  assign _106_ = ~_017_;
  assign _107_ = _055_ & ~(_018_);
  assign _108_ = _010_ ? _106_ : _107_;
  assign _002_[1] = RST ? counter[1] : _108_;
  assign _109_ = _055_ & ~(_024_);
  assign _110_ = _010_ ? _022_ : _109_;
  assign _002_[2] = RST ? counter[2] : _110_;
  assign _111_ = ~_026_;
  assign _112_ = _055_ & ~(_028_);
  assign _113_ = _010_ ? _111_ : _112_;
  assign _002_[3] = RST ? counter[3] : _113_;
  assign _114_ = _055_ & ~(_036_);
  assign _115_ = _010_ ? _033_ : _114_;
  assign _002_[4] = RST ? counter[4] : _115_;
  assign _116_ = ~_038_;
  assign _117_ = _055_ & ~(_040_);
  assign _118_ = _010_ ? _116_ : _117_;
  assign _002_[5] = RST ? counter[5] : _118_;
  assign _119_ = _055_ & ~(_047_);
  assign _120_ = _010_ ? _044_ : _119_;
  assign _002_[6] = RST ? counter[6] : _120_;
  assign _121_ = ~_049_;
  assign _122_ = _055_ & ~(_051_);
  assign _123_ = _010_ ? _121_ : _122_;
  assign _002_[7] = RST ? counter[7] : _123_;
  assign _004_[15] = lfsr[1] & ~(RST);
  assign _004_[1] = lfsr[2] | RST;
  assign _004_[2] = lfsr[3] & ~(RST);
  assign _004_[3] = lfsr[4] | RST;
  assign _004_[4] = lfsr[5] | RST;
  assign _004_[5] = lfsr[6] & ~(RST);
  assign _004_[6] = lfsr[7] | RST;
  assign _004_[7] = lfsr[8] | RST;
  assign _124_ = bcd[1] & bcd[0];
  assign _125_ = _124_ & ~(_064_);
  assign _126_ = bcd[1] & ~(bcd[0]);
  assign _127_ = _126_ & ~(_064_);
  assign _128_ = _127_ | _125_;
  assign _129_ = bcd[1] | ~(bcd[0]);
  assign _130_ = bcd[1] | bcd[0];
  assign _131_ = ~((_130_ & _129_) | _064_);
  assign _132_ = _131_ | _128_;
  assign _133_ = ~bcd[0];
  assign _134_ = ~((_058_ & _133_) | bcd[2]);
  assign _135_ = ~(_134_ | _132_);
  assign _136_ = bcd[2] ? _133_ : _058_;
  assign LEDS[0] = _135_ | ~(_136_);
  assign _137_ = ~_124_;
  assign _138_ = ~((_130_ & _137_) | _064_);
  assign _139_ = ~(_138_ | _134_);
  assign LEDS[1] = _135_ | ~(_139_);
  assign _140_ = ~((_129_ & _137_) | bcd[2]);
  assign _141_ = _140_ | _132_;
  assign LEDS[2] = _141_ | _135_;
  assign _142_ = ~((_126_ | _124_) & _064_);
  assign _143_ = bcd[2] & ~(_129_);
  assign _144_ = _143_ | _127_;
  assign _145_ = _142_ & ~(_144_);
  assign LEDS[3] = _135_ | ~(_145_);
  assign LEDS[4] = ~((bcd[2] & _058_) | bcd[0]);
  assign _146_ = ~(_131_ | _127_);
  assign LEDS[5] = _135_ | ~(_146_);
  assign LEDS[6] = ~((_146_ & _142_) | _135_);
  assign _147_ = dp & ~(ROLL);
  assign _148_ = _147_ | _010_;
  assign _003_ = _148_ | RST;
  assign _149_ = ~RST;
  assign _150_ = ~(lfsr[13] ^ lfsr[1]);
  assign _004_[12] = _149_ & ~(_150_);
  assign _004_[14] = lfsr[0] & ~(RST);
  assign _151_ = ~(lfsr[14] ^ lfsr[1]);
  assign _004_[13] = _149_ & ~(_151_);
  assign _004_[8] = lfsr[9] & ~(RST);
  assign _004_[9] = lfsr[10] & ~(RST);
  assign _004_[11] = lfsr[12] & ~(RST);
  assign _152_ = ~(lfsr[11] ^ lfsr[1]);
  assign _004_[10] = _149_ & ~(_152_);
  assign _153_ = ROLL | ~(clkdiv[0]);
  assign _154_ = ~(clkdiv[1] | ROLL);
  assign _155_ = _154_ & _153_;
  assign _156_ = ROLL | ~(clkdiv[2]);
  assign _157_ = ROLL | ~(clkdiv[3]);
  assign _158_ = ~(_157_ & _156_);
  assign _159_ = _155_ & ~(_158_);
  assign _160_ = clkdiv[4] & ~(ROLL);
  assign _161_ = clkdiv[5] & ~(ROLL);
  assign _005_ = _160_ | ~(_161_);
  assign _006_ = clkdiv[6] & ~(ROLL);
  assign _007_ = clkdiv[7] & ~(ROLL);
  assign _008_ = _006_ | ~(_007_);
  assign _009_ = _008_ | _005_;
  assign _010_ = _159_ & ~(_009_);
  assign _011_ = ~((lfsr[2] | lfsr[1]) & lfsr[3]);
  assign _012_ = lfsr[3] & ~(lfsr[2]);
  assign _013_ = ~((_012_ & lfsr[1]) | _011_);
  assign _014_ = ~(_013_ ^ lfsr[1]);
  assign _015_ = ROLL | ~(counter[0]);
  assign _016_ = _015_ ^ _153_;
  assign _017_ = ROLL | ~(counter[1]);
  assign _018_ = ~(_017_ ^ _015_);
  assign _019_ = _018_ ^ _154_;
  assign _020_ = _016_ & ~(_019_);
  assign _021_ = ROLL | ~(counter[2]);
  assign _022_ = ~_021_;
  assign _023_ = _017_ | _015_;
  assign _024_ = _023_ ^ _022_;
  assign _025_ = _024_ ^ _156_;
  assign _026_ = ROLL | ~(counter[3]);
  assign _027_ = _022_ & ~(_023_);
  assign _028_ = _027_ ^ _026_;
  assign _029_ = _028_ ^ _157_;
  assign _030_ = _029_ | _025_;
  assign _031_ = _020_ & ~(_030_);
  assign _032_ = ROLL | ~(counter[4]);
  assign _033_ = ~_032_;
  assign _034_ = _026_ | _021_;
  assign _035_ = _034_ | _023_;
  assign _036_ = _035_ ^ _033_;
  assign _037_ = _036_ ^ _160_;
  assign _038_ = ROLL | ~(counter[5]);
  assign _039_ = _033_ & ~(_035_);
  assign _040_ = _039_ ^ _038_;
  assign _041_ = ~(_040_ ^ _161_);
  assign _042_ = _037_ & ~(_041_);
  assign _043_ = ~_006_;
  assign _044_ = counter[6] & ~(ROLL);
  assign _045_ = _038_ | _032_;
  assign _046_ = _045_ | _035_;
  assign _047_ = _046_ ^ _044_;
  assign _048_ = _047_ ^ _043_;
  assign _049_ = ROLL | ~(counter[7]);
  assign _050_ = _044_ & ~(_046_);
  assign _051_ = _050_ ^ _049_;
  assign _052_ = ~(_051_ ^ _007_);
  assign _053_ = _052_ | _048_;
  assign _054_ = _042_ & ~(_053_);
  assign _055_ = ~(_054_ & _031_);
  assign _056_ = _055_ ? bcd[0] : _014_;
  assign _057_ = _010_ ? bcd[0] : _056_;
  assign _000_[0] = _057_ | RST;
  assign _058_ = ~bcd[1];
  reg \lfsr_reg[0] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[0]  <= _004_[15];
  assign lfsr[0] = \lfsr_reg[0] ;
  reg \lfsr_reg[1] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[1]  <= _004_[1];
  assign lfsr[1] = \lfsr_reg[1] ;
  reg \lfsr_reg[2] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[2]  <= _004_[2];
  assign lfsr[2] = \lfsr_reg[2] ;
  reg \lfsr_reg[3] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[3]  <= _004_[3];
  assign lfsr[3] = \lfsr_reg[3] ;
  reg \lfsr_reg[4] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[4]  <= _004_[4];
  assign lfsr[4] = \lfsr_reg[4] ;
  reg \lfsr_reg[5] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[5]  <= _004_[5];
  assign lfsr[5] = \lfsr_reg[5] ;
  reg \lfsr_reg[6] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[6]  <= _004_[6];
  assign lfsr[6] = \lfsr_reg[6] ;
  reg \lfsr_reg[7] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[7]  <= _004_[7];
  assign lfsr[7] = \lfsr_reg[7] ;
  reg \lfsr_reg[8] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[8]  <= _004_[8];
  assign lfsr[8] = \lfsr_reg[8] ;
  reg \lfsr_reg[9] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[9]  <= _004_[9];
  assign lfsr[9] = \lfsr_reg[9] ;
  reg \lfsr_reg[10] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[10]  <= _004_[10];
  assign lfsr[10] = \lfsr_reg[10] ;
  reg \lfsr_reg[11] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[11]  <= _004_[11];
  assign lfsr[11] = \lfsr_reg[11] ;
  reg \lfsr_reg[12] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[12]  <= _004_[12];
  assign lfsr[12] = \lfsr_reg[12] ;
  reg \lfsr_reg[13] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[13]  <= _004_[13];
  assign lfsr[13] = \lfsr_reg[13] ;
  reg \lfsr_reg[14] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      \lfsr_reg[14]  <= _004_[14];
  assign lfsr[14] = \lfsr_reg[14] ;
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      clkdiv[0] <= _001_[0];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      clkdiv[1] <= _001_[1];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      clkdiv[2] <= _001_[2];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      clkdiv[3] <= _001_[3];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      clkdiv[4] <= _001_[4];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      clkdiv[5] <= _001_[5];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      clkdiv[6] <= _001_[6];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      clkdiv[7] <= _001_[7];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      counter[0] <= _002_[0];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      counter[1] <= _002_[1];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      counter[2] <= _002_[2];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      counter[3] <= _002_[3];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      counter[4] <= _002_[4];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      counter[5] <= _002_[5];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      counter[6] <= _002_[6];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      counter[7] <= _002_[7];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      bcd[0] <= _000_[0];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      bcd[1] <= _000_[1];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      bcd[2] <= _000_[2];
  (* src = "dice.v:24" *)
  always @(posedge CLK)
      dp <= _003_;
  assign _004_[0] = _004_[15];
  assign LEDS[7] = dp;
  assign lfsr[15] = lfsr[0];
  assign segments = LEDS[6:0];
endmodule
