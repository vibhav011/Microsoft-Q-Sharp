namespace Solution {
	open Microsoft.Quantum.Primitive;
	open Microsoft.Quantum.Canon;

	operation Solve (qs : Qubit[]) : Int {
        body {
            let n = Length(qs);
            for (i in 1 .. n-1) {
                CNOT(qs[i], qs[0]);
            }
            let res = M(qs[0]);
            if (res == Zero) {return 0;}
            return 1;
        }
    }
}
