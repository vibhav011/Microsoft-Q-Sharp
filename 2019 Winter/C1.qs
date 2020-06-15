namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve (x : Qubit[], y : Qubit) : Unit {
        body (...) {
            let n = Length(x);
            using (qs = Qubit[n-1]) {
            	for (i in 0 .. n-2) {
            		CNOT(x[i], qs[i]);
            		CNOT(x[i+1], qs[i]);
            	}
            	Controlled X (qs, y);
            	for (i in 0 .. n-2) {
            		CNOT(x[i], qs[i]);
            		CNOT(x[i+1], qs[i]);
            	}
            }
        }
        adjoint auto;
    }
}