namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve (x : Qubit[], y : Qubit) : Unit {
        body (...) {
        	let n = Length(x);
            using (qs = Qubit[n/2]) {
                for (i in 0 .. n/2-1) {
                    CNOT(x[i], qs[i]);
                    CNOT(x[n-i-1], qs[i]);
                }
                (ControlledOnInt(0, X))(qs[0 .. n/2-1], y);
                for (i in 0 .. n/2-1) {
                    CNOT(x[n-i-1], qs[i]);
                    CNOT(x[i], qs[i]);
                }
            }
        }
        adjoint auto;
    }
}