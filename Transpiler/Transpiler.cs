using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace TholinStuff {
	class Transpiler {
		struct Clock {
			public string name;
			public bool edge;
			public string action;
			public Wire signal;
		}

		struct Reg {
			public string name;
			public string code_name;
			public int size;
		}

		struct Wire {
			public string name;
			public string code_name;
			public int size;
			public bool isIO;
			public bool isInput;
			public bool isClock;
		}

		static void Main(string[] args) {
			if(args.Length < 1) {
				Console.WriteLine("Must specify an input file");
				return;
			}
			string filename = args[0];
			string[] lines = File.ReadAllLines(filename);
			List<Reg> regDefs = new List<Reg>();
			List<Wire> wireDefs = new List<Wire>();
			List<Clock> clockedDefs = new List<Clock>();
			List<string> assigns = new List<string>();
			for(int i = 0; i < lines.Length; i++) {
				string line = lines[i].Trim();

				if(line.StartsWith("assign") && !line.Contains("<=")) assigns.Add(line);
				else if(line.StartsWith("reg") || line.StartsWith("wire") || line.StartsWith("output") || line.StartsWith("input")) {
					bool isReg = line.StartsWith("reg");
					bool isIO = line.StartsWith("output") || line.StartsWith("input");
					bool isInput = isIO && line.StartsWith("input");
					line = line.Substring(isReg ? 4 : (line.StartsWith("wire") ? 5 : (line.StartsWith("output") ? 7 : 6)));
					int size;
					string name;
					string code_name;
					if(line[0] == '[') {
						string[] s1 = line.Substring(1).Split("]");
						string[] s2 = s1[0].Split(":");
						line = s1[1].Trim();
						int end = int.Parse(s2[0]);
						int start = int.Parse(s2[1]);
						if(start != 0) Console.WriteLine("Warning: found reg not starting at 0. Resulting C code may be broken.");
						size = end + 1;
					}else size = 1;
					name = line.Split(";")[0].Trim();
					code_name = name;
					if(name.Contains("[")) {
						code_name = name.Replace("[", "__").Replace("]", "__").Replace("\\", "_");
					}
					if(isReg) {
						Reg r = new Reg();
						r.size = size;
						r.name = name;
						r.code_name = code_name;
						regDefs.Add(r);
					}else {
						Wire w = new Wire();
						w.size = size;
						w.name = name;
						w.code_name = code_name;
						w.isIO = isIO;
						w.isInput = isInput;
						w.isClock = false;
						wireDefs.Add(w);
					}
				}
				else if(line.StartsWith("always @(")) {
					line = line.Substring(9);
					Clock c = new Clock();
					if(line.StartsWith("posedge")) c.edge = true;
					else c.edge = false;
					line = line.Substring(8).Split(")")[0];
					c.name = line;
					c.action = lines[i + 1].Trim();
					clockedDefs.Add(c);
				}
			}

			List<Wire> clockSignals = new List<Wire>();
			for(int i = 0; i < clockedDefs.Count; i++) {
				Clock c = clockedDefs[i];
				for(int j = 0; j < wireDefs.Count; j++) {
					Wire w = wireDefs[j];
					if(w.name.Equals(c.name)) {
						w.isClock = true;
						wireDefs[j] = w;
						c.signal = w;
						clockedDefs[i] = c;
						bool found = false;
						for(int k = 0; k < clockSignals.Count; k++) {
							if(clockSignals[k].name.Equals(w.name)) {
								found = true;
								break;
							}
						}
						if(found) break;
						clockSignals.Add(w);
						break;
					}
				}
			}

			Console.WriteLine("File parsed. Regs are:");
			for(int i = 0; i < regDefs.Count; i++) Console.WriteLine($"{regDefs[i].name} ({regDefs[i].code_name}) - {regDefs[i].size}");
			Console.WriteLine("Wire defs:");
			for(int i = 0; i < wireDefs.Count; i++) if(!wireDefs[i].isIO) Console.WriteLine($"{wireDefs[i].name} ({wireDefs[i].code_name}) - {wireDefs[i].size}");
			Console.WriteLine("I/O defs:");
			for(int i = 0; i < wireDefs.Count; i++) if(wireDefs[i].isIO) Console.WriteLine($"{wireDefs[i].name} ({wireDefs[i].code_name}) - {wireDefs[i].size}");
			if(clockSignals.Count != 0) {
				Console.WriteLine("The following signals are valid clocks:");
				for(int i = 0; i < clockSignals.Count; i++) Console.WriteLine(clockSignals[i].name);
			}

			Console.WriteLine("Generating shader program");
			StreamWriter wr = new StreamWriter("verilog.shader", append: false);
			wr.WriteLine("Shader \"Tholin/Generated/Verilog\"");
			wr.WriteLine("{");
			wr.WriteLine("\tProperties");
			wr.WriteLine("\t{");
			for(int i = 0; i < wireDefs.Count; i++) {
				Wire w = wireDefs[i];
				if(w.isInput && w.isIO) {
					if(w.size != 1) Console.WriteLine("Wires of size > 1 are not supported as inputs yet");
					else wr.WriteLine($"\t\t[Toggle] _{w.code_name} (\"{w.name}\", Int) = 0");
				}
			}
			wr.WriteLine("\t\t_Iters (\"Iterations per frame\", Int) = 2");
			wr.WriteLine("\t}");
			wr.WriteLine("\tSubShader");
			wr.WriteLine("\t{");
			wr.WriteLine("\t\tTags { \"RenderType\"=\"Opaque\" }");
			wr.WriteLine("\t\tLighting Off");
			wr.WriteLine("\t\tBlend One Zero");
			wr.WriteLine("\t\tZTest Always");
			wr.WriteLine("\t\tLOD 100");
			wr.WriteLine("\t\t");
			wr.WriteLine("\t\tPass");
			wr.WriteLine("\t\t{");
			wr.WriteLine("\t\t\tCGPROGRAM");
			wr.WriteLine("\t\t\t\t#define _SelfTexture2D _JunkTexture");
			wr.WriteLine("\t\t\t\t#include \"UnityCustomRenderTexture.cginc\"");
			wr.WriteLine("\t\t\t\t#undef _SelfTexture2D");
			wr.WriteLine("\t\t\t\tTexture2D<uint4> _SelfTexture2D;");
			wr.WriteLine("\t\t\t\t#include \"UnityCG.cginc\"");
			wr.WriteLine("\t\t\t\t#pragma vertex CustomRenderTextureVertexShader");
			wr.WriteLine("\t\t\t\t#pragma fragment frag");
			wr.WriteLine("\t\t\t\t#pragma target 3.0");
			wr.WriteLine("\t\t\t\t");
			wr.WriteLine("\t\t\t\tstruct appdata");
			wr.WriteLine("\t\t\t\t{");
			wr.WriteLine("\t\t\t\t\tfloat2 uv : TEXCOORD0;");
			wr.WriteLine("\t\t\t\t};");
			wr.WriteLine("\t\t\t\t");

			wr.WriteLine("\t\t\t\tstruct verilog_regs {");
			for(int i = 0; i < regDefs.Count; i++) {
				if(regDefs[i].size == 1) wr.WriteLine($"\t\t\t\t\tuint {regDefs[i].code_name};");
				else {
					wr.WriteLine($"\t\t\t\t\tuint {regDefs[i].code_name}[{regDefs[i].size}];");
				}
			}
			wr.WriteLine("\t\t\t\t};");
			wr.WriteLine("\t\t\t\t");

			wr.WriteLine("\t\t\t\tstruct verilog_wires {");
			for(int i = 0; i < wireDefs.Count; i++) {
				Wire w = wireDefs[i];
				if(w.isIO) continue;
				if(w.size == 1) {
					wr.WriteLine($"\t\t\t\t\tuint {w.code_name};");
					if(w.isClock) wr.WriteLine($"\tuint clk_prev_{w.code_name};");
				}else {
					wr.WriteLine($"\t\t\t\t\tuint {w.code_name}[{w.size}];");
				}
			}
			wr.WriteLine("\t\t\t\t};");
			wr.WriteLine("\t\t\t\t");

			wr.WriteLine("\t\t\t\tstruct verilog_io {");
			for(int i = 0; i < wireDefs.Count; i++) {
				Wire w = wireDefs[i];
				if(!w.isIO) continue;
				if(w.size == 1) {
					wr.WriteLine($"\t\t\t\t\tuint {w.code_name}; // {(w.isInput ? "INPUT" : "OUTPUT")}");
					if(w.isClock) wr.WriteLine($"\t\t\t\t\tuint clk_prev_{w.code_name};");
				}else {
					wr.WriteLine($"\t\t\t\t\tuint {w.code_name}[{w.size}]; // {(w.isInput ? "INPUT" : "OUTPUT")}");
				}
			}
			wr.WriteLine("\t\t\t\t};");
			wr.WriteLine("\t\t\t\t");

			for(int i = 0; i < wireDefs.Count; i++) {
				Wire w = wireDefs[i];
				if(w.isInput && w.isIO) {
					if(w.size != 1) Console.WriteLine("Wires of size > 1 are not supported as inputs yet");
					else wr.WriteLine($"\t\t\t\tuint _{w.code_name};");
				}
			}
			wr.WriteLine("\t\t\t\tuint _Iters;");
			wr.WriteLine("\t\t\t\t");
			int crtDim = 128;

			wr.WriteLine($"\t\t\t\t#define get_wire(address) (_SelfTexture2D[uint2((address) % {crtDim}, (address) / {crtDim})].r)");
			wr.WriteLine($"\t\t\t\t#define get_wire_prev(address) (_SelfTexture2D[uint2((address) % {crtDim}, (address) / {crtDim})].g)");
			wr.WriteLine($"\t\t\t\t#define get_reg(address) (get_wire({crtDim * crtDim - 1} - (address)))");
			wr.WriteLine("\t\t\t\t#define MAX_ITERS 256");
			wr.WriteLine("\t\t\t\t");
			wr.WriteLine("\t\t\t\tuint4 frag (v2f_customrendertexture i) : COLOR");
			wr.WriteLine("\t\t\t\t{");
			wr.WriteLine($"\t\t\t\t\tuint idxx = (uint)(i.globalTexcoord.x * {crtDim}.0);");
			wr.WriteLine($"\t\t\t\t\tuint idxy = (uint)(i.globalTexcoord.y * {crtDim}.0);");
			wr.WriteLine($"\t\t\t\t\tuint idx = idxy * {crtDim} + idxx;");
			wr.WriteLine("\t\t\t\t\tuint4 col = _SelfTexture2D[uint2(idxx, idxy)]; //Return this if unchanged");
			int countWires = 0;
			int countRegs = 0;
			foreach(Wire w in wireDefs) countWires += w.size;
			foreach(Reg r in regDefs) countRegs += r.size;

			wr.WriteLine($"\t\t\t\t\tif(idx > {countWires} && idx < {crtDim * crtDim - 1} - {countRegs}) return col;");
			wr.WriteLine("\t\t\t\t\tverilog_regs regs;");
			wr.WriteLine("\t\t\t\t\tverilog_wires wires;");
			wr.WriteLine("\t\t\t\t\tverilog_io io;");
			wr.WriteLine("\t\t\t\t\t");
			wr.WriteLine("\t\t\t\t\t//Load regs");
			int addr = 0;
			for(int i = 0; i < regDefs.Count; i++) {
				Reg r = regDefs[i];
				if(r.size == 1) {
					wr.WriteLine($"\t\t\t\t\tregs.{r.code_name} = get_reg({addr}) ? 1 : 0;");
					addr++;
				}else {
					wr.WriteLine($"\t\t\t\t\tfor(int i = 0; i < {r.size}; i++) regs.{r.code_name}[i] = get_reg({addr} + i);");
					addr += r.size;
				}
			}
			wr.WriteLine("\t\t\t\t\t");
			wr.WriteLine("\t\t\t\t\t//Load wires");
			addr = 0;
			for(int i = 0; i < wireDefs.Count; i++) {
				Wire w = wireDefs[i];
				string s = w.isIO ? "io" : "wires";
				if(w.size == 1) {
					if(w.isIO && w.isInput) wr.WriteLine($"\t\t\t\t\t{s}.{w.code_name} = _{w.code_name};");
					else wr.WriteLine($"\t\t\t\t\t{s}.{w.code_name} = get_wire({addr}) ? 1 : 0;");
					if(w.isClock) {
						wr.WriteLine($"\t\t\t\t\t{s}.clk_prev_{w.code_name} = get_wire_prev({addr}) ? 1 : 0;");
					}
					addr++;
				}else {
					wr.WriteLine($"\t\t\t\t\tfor(int i = 0; i < {w.size}; i++) {s}.{w.code_name}[i] = get_wire({addr} + i);");
					addr += w.size;
				}
			}
			wr.WriteLine("\t\t\t\t\t");
			wr.WriteLine("\t\t\t\t\tuint changed;");
			wr.WriteLine("\t\t\t\t\tuint iter_count = 0;");
			wr.WriteLine("\t\t\t\t\tverilog_wires compare;");
			wr.WriteLine("\t\t\t\t\tverilog_io compare_io;");
			wr.WriteLine("\t\t\t\t\tfor(int jjj = 0; jjj < _Iters; jjj++) {");
			wr.WriteLine("\t\t\t\t\tfor(int iii = 0; iii < MAX_ITERS; iii++) {");
			for(int i = 0; i < assigns.Count; i++) {
				string line = assigns[i].Substring(7);
				line = line.Replace("&", "&&").Replace("|", "||").Replace("^", "!=").Replace("~", "!"); //Fix operators
				if(Regex.Match(line, "[0-9]:[0-9]").Success) {
					//These are a pain to deal with
					int left_i = -1;
					int right_i = -1;
					int start = 0;
					int end = 1;
					for(int j = 0; j < wireDefs.Count; j++) {
						Wire w = wireDefs[j];
						if(w.size == 1) continue;
						string regex = $"^{w.name} +=";
						if(Regex.Match(line, regex).Success) left_i = j;
						regex = $"= {w.name}\\[[0-9]+:[0-9]+\\];$";
						if(Regex.Match(line, regex).Success) {
							right_i = j;
							string[] s = line.Split("[")[1].Split(":");
							end = int.Parse(s[0]);
							start = int.Parse(s[1].Split("]")[0]);
						}
					}
					Wire left = wireDefs[left_i];
					Wire right = wireDefs[right_i];
					wr.WriteLine($"\t\t\t\t\t\tfor(int i = {start}; i < {end}; i++) {"{"}");
					wr.WriteLine($"\t\t\t\t\t\t\t{(left.isIO ? "io" : "wires")}.{left.code_name}[i] = {(right.isIO ? "io" : "wires")}.{right.code_name}[i];");
					line = "}";
				}
				for(int j = 0; j < wireDefs.Count; j++) {
					Wire w = wireDefs[j];
					string regex = w.size > 1 ? $"([( !])({w.name})(\\[[0-9]+\\][) ;])" : $"([( !])({w.name})([) ;])";
					Match m = Regex.Match(line, regex);
					if(m.Success) line = Regex.Replace(line, regex, $"$1{(w.isIO ? "io" : "wires")}.{w.code_name}$3");

					regex = w.size > 1 ? $"^({w.name})(\\[[0-9]+\\] =)" : $"^({w.name})( =)";
					m = Regex.Match(line, regex);
					if(m.Success) line = Regex.Replace(line, regex, $"{(w.isIO ? "io" : "wires")}.{w.code_name}$2");
				}
				for(int j = 0; j < regDefs.Count; j++) {
					Reg r = regDefs[j];
					string s = r.name.Replace("\\", "\\\\").Replace("[", "\\[").Replace("]", "\\]");
					string regex = r.size > 1 ? $"([( !])({s})(\\[[0-9]+\\][) ;])" : $"([( !])({s})([) ;])";
					Match m = Regex.Match(line, regex);
					if(m.Success) line = Regex.Replace(line, regex, $"$1regs.{r.code_name}$3");
				}
				
				wr.WriteLine($"\t\t\t\t\t\t{line}");
			}
			wr.WriteLine($"\t\t\t\t\t\t");
			wr.WriteLine($"\t\t\t\t\t\titer_count++;");
			wr.WriteLine($"\t\t\t\t\t\tchanged = 0;");
			for(int i = 0; i < wireDefs.Count; i++) {
				Wire w = wireDefs[i];
				string s1 = w.isIO ? "compare_io" : "compare";
				string s2 = w.isIO ? "io" : "wires";
				if(w.size == 1) {
					wr.WriteLine($"\t\t\t\t\t\tif({s1}.{w.code_name} != {s2}.{w.code_name}) changed = 1;");
					wr.WriteLine($"\t\t\t\t\t\t{s1}.{w.code_name} = {s2}.{w.code_name};");
				}else {
					wr.WriteLine($"\t\t\t\t\t\tfor(int i = 0; i < {w.size}; i++) {"{"}");
					wr.WriteLine($"\t\t\t\t\t\t\tif({s1}.{w.code_name}[i] != {s2}.{w.code_name}[i]) changed = 1;");
					wr.WriteLine($"\t\t\t\t\t\t\t{s1}.{w.code_name}[i] = {s2}.{w.code_name}[i];");
					wr.WriteLine("\t\t\t\t\t\t}");
				}
			}
			wr.WriteLine($"\t\t\t\t\t\t");
			wr.WriteLine($"\t\t\t\t\t\tif(!changed && iter_count > 1) break;");
			wr.WriteLine("\t\t\t\t\t}");

			wr.WriteLine("\t\t\t\t\t");
			for(int i = 0; i < clockedDefs.Count; i++){
				Clock c = clockedDefs[i];
				string s1 = c.signal.isIO ? "io." : "wires.";
				string s2 = $"{s1}{c.signal.code_name}";
				wr.WriteLine($"\t\t\t\t\tif({s2} != {s1}clk_prev_{c.signal.code_name} && {(c.edge ? "" : "!")}{s2})");
				string line = c.action.Replace("<=", "=");
				//Luckily, these seem to always be a wire to register assignment, so the regexes become pretty straight-forward
				for(int j = 0; j < wireDefs.Count; j++) {
					Wire w = wireDefs[j];
					string regex = w.size > 1 ? $"(= )({w.name})(\\[[0-9]+\\];)" : $"(= )({w.name})(;)";

					Match m = Regex.Match(line, regex);
					if(m.Success) line = Regex.Replace(line, regex, $"$1{(w.isIO ? "io" : "wires")}.{w.code_name}$3");
				}
				for(int j = 0; j < regDefs.Count; j++) {
					Reg r = regDefs[j];
					string s = r.name.Replace("\\", "\\\\").Replace("[", "\\[").Replace("]", "\\]");
					string regex = r.size > 1 ? $"^({s})(\\[[0-9]+\\] +=)" : $"^({s})( +=)";
					Match m = Regex.Match(line, regex);
					if(m.Success) line = Regex.Replace(line, regex, $"regs.{r.code_name}$2");
				}
				wr.WriteLine($"\t\t\t\t\t\t{line}");
			}
			wr.WriteLine("\t\t\t\t\t}");
			wr.WriteLine("\t\t\t\t\t");
			for(int i = 0; i < clockSignals.Count; i++) {
				Wire w = clockSignals[i];
				if(!w.isClock) continue;
				string s = w.isIO ? "io." : "wires.";
				wr.WriteLine($"\t\t\t\t\t{s}clk_prev_{w.code_name} = {s}{w.code_name};");
			}
			wr.WriteLine("\t\t\t\t\t");
			wr.WriteLine("\t\t\t\t\t//Oh my god, this part sucks");
			wr.WriteLine("\t\t\t\t\tswitch(idx) {");
			addr = 0;
			int startAddr = -1;
			for(int i = 0; i < wireDefs.Count; i++) {
				Wire w = wireDefs[i];
				string s = w.isIO ? "io" : "wires";
				if(w.size == 1) {
					wr.WriteLine($"\t\t\t\t\t\tcase {addr}:");
					wr.WriteLine($"\t\t\t\t\t\t\tcol.r = {s}.{w.code_name} ? 1 : 0;");
					if(w.isClock) {
						wr.WriteLine($"\t\t\t\t\t\t\tcol.g = {s}.clk_prev_{w.code_name} ? 1 : 0;");
					}
					if(w.isIO) {
						wr.WriteLine($"\t\t\t\t\t\t\tcol.b = {s}.{w.code_name} ? 1 : 0;");
					}
					wr.WriteLine("\t\t\t\t\t\t\tbreak;");
					addr++;
				}else {
					if(addr - startAddr == w.size) {
						startAddr = -1;
						continue;
					}
					if(startAddr == -1) {
						startAddr = addr;
					}else {
						wr.WriteLine($"\t\t\t\t\t\tcase {addr}:");
						wr.WriteLine($"\t\t\t\t\t\t\tcol.r = {s}.{w.code_name}[{addr - startAddr}] ? 1 : 0;");
						if(w.isIO) {
							wr.WriteLine($"\t\t\t\t\t\t\tcol.b = {s}.{w.code_name}[{addr - startAddr}] ? 1 : 0;");
						}
						wr.WriteLine("\t\t\t\t\t\t\tbreak;");
						addr++;
					}
					i--;
					continue;
				}
			}

			addr = 0;
			startAddr = -1;
			for(int i = 0; i < regDefs.Count; i++) {
				Reg r = regDefs[i];
				if(r.size == 1) {
					wr.WriteLine($"\t\t\t\t\t\tcase {crtDim * crtDim - 1 - addr}:");
					wr.WriteLine($"\t\t\t\t\t\t\tcol.r = regs.{r.code_name} ? 1 : 0;");
					wr.WriteLine("\t\t\t\t\t\t\tbreak;");
					addr++;
				}else {
					if(addr - startAddr == r.size) {
						startAddr = -1;
						continue;
					}
					if(startAddr == -1) {
						startAddr = addr;
					}else {
						wr.WriteLine($"\t\t\t\t\t\tcase {crtDim * crtDim - 1 - addr}:");
						wr.WriteLine($"\t\t\t\t\t\t\tcol.r = regs.{r.code_name}[{addr - startAddr}] ? 1 : 0;");
						wr.WriteLine("\t\t\t\t\t\t\tbreak;");
						addr++;
					}
					i--;
					continue;
				}
			}
			wr.WriteLine("\t\t\t\t\t}");

			wr.WriteLine("\t\t\t\t\treturn col;");
			wr.WriteLine("\t\t\t\t}");
			wr.WriteLine("\t\t\tENDCG");
			wr.WriteLine("\t\t}");
			wr.WriteLine("\t}");
			wr.WriteLine("}");

			wr.Flush();
			wr.Close();

			Console.WriteLine("Done!");
		}
	}
}
