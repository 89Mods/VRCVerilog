# VRCVerilog
Verilog to Unity shader transpiler, so you can program your shaders/world scripts like it's an FPGA! Why? Because. Because yes. Because I said so! Because reasons. Yeah!

**Note:** Just realized that this breaks with anything but the simplest Verilog code. Wontfix, probably.

# Usage
The transpiler can be found in `Transpiler`. Before you can run it, you need to synthesize your Verilog using yosys. Run `yosys`, and in its shell, run these commands (works in WSL):
```
read_verilog [your_verilog.v]
synth -top [your top-level module name]
write_verilog synthesized.v
```

After that, you can run the transpiler on the synthesized Verilog, which will directly output a Unity shader:
`dotnet run synthesized.v`

All module inputs will become shader properties, but you may need to scroll through the generated shader code to find where in the CRT the outputs are placed. See the `SevenSeg` shader for an example on how to parse module outputs.

# WHY?
Because I had nothing better to do, ig.
