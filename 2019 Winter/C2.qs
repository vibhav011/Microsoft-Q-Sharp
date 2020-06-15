namespace Solution {
	open Microsoft.Quantum.Primitive;
	open Microsoft.Quantum.Canon;

	operation Helper (x : Qubit[], anc : Qubit[]) : Unit {
		body (...) {
			let n = Length(x);
			
			for (p in 2 .. n-1) {
				for (i in 0 .. n-p-1) {
					CNOT(x[i+p], x[i]);
				}
				(ControlledOnInt(0, X)) (x[0..n-p-1], anc[p-2]);
				for (i in n-p-1 .. -1 .. 0) {
					CNOT(x[i+p], x[i]);
				}
			}
		}
		adjoint auto;
	}

	operation Solve (x : Qubit[], y : Qubit) : Unit {
		body (...) {
			let n = Length(x);
			if (n == 2) {
				X(y);
				CNOT(x[0], y);
				CNOT(x[1], y);
			}
			else {
				using (anc = Qubit[n-2]) {
					Helper (x, anc);
					X(y);
					(ControlledOnInt(0, X)) (anc, y);
					Adjoint Helper (x, anc);
				}
			}
		}
		adjoint auto;
	}
}