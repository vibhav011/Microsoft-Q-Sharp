namespace Solution {
	open Microsoft.Quantum.Primitive;
	open Microsoft.Quantum.Canon;

	operation Solve (qs : Qubit[]) : () {
		body {
			for (q in qs) {
				H(q);
			}
		}
	}
}
