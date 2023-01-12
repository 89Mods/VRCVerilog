using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

[UdonBehaviourSyncMode(BehaviourSyncMode.None)]
public class VerilogDriver : UdonSharpBehaviour {
	public Material verilogMat;
	public Material btnOffMat,btnOnMat;

	private bool CLK;
	private bool RST;
	private bool ROLL;
	private int counter = 0;
	private MeshRenderer mr;

	void Start() {
		CLK = false;
		RST = true;
		ROLL = false;
		mr = GetComponent<MeshRenderer>();
		mr.material = btnOffMat;
	}

	void Update() {
		CLK = !CLK;
		verilogMat.SetInt("_CLK", CLK ? 1 : 0);
		verilogMat.SetInt("_RST", RST ? 1 : 0);
		verilogMat.SetInt("_ROLL", ROLL ? 1 : 0);
		if(RST) {
			counter++;
			if(counter == 16) RST = false;
		}
		if(ROLL) {
			counter++;
			if(counter == 16) {
				ROLL = false;
				mr.material = btnOffMat;
			}
		}
	}

	void Interact() {
		ROLL = true;
		counter = 0;
		mr.material = btnOnMat;
	}
}
