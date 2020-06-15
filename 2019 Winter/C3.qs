namespace Solution {
	open Microsoft.Quantum.Primitive;
	open Microsoft.Quantum.Canon;

	operation Incr (qs : Qubit[]) : Unit is Adj+Ctl {
		CNOT(qs[0], qs[1]);
		CNOT(qs[1], qs[0]);
	}

	operation Helper (x : Qubit[], qs : Qubit[]) : Unit {
		body (...) {
			let n = Length(x);
			
			for (i in 0..n-1) {
				Controlled Incr ([x[i]], qs);
			}
		}
		adjoint auto;
	}

	operation Solve (x : Qubit[], y : Qubit) : Unit {
		body (...) {
			let n = Length(x);
			using (qs = Qubit[2]) {
				X(qs[0]); X(qs[1]);
				Helper (x, qs);
				Controlled X (qs, y);
				Adjoint Helper (x, qs);
				X(qs[0]); X(qs[1]);
			}
		}
		adjoint auto;
	}
}