namespace Solution {	
	open Microsoft.Quantum.Intrinsic;

	operation Solve (qs : Qubit[]) : Unit {
		X(qs[0]); X(qs[1]);
		using (q = Qubit()) {
			repeat {
				X(qs[0]); X(qs[1]);
				H(qs[0]); H(qs[1]);
				Controlled X(qs, q);
				let res = M(q);
				X(q);
			} until (res == Zero);
			X(qs[0]); X(qs[1]);

			Reset(q);
		}
	}
	operation Main(): Unit {
		using (qs = Qubit[2]) {
			Solve(qs);
			DumpMachine();
			ResetAll(qs);
		}
	}
}