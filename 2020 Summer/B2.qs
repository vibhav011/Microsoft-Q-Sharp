namespace Solution {    
    open Microsoft.Quantum.Intrinsic;

    operation incr (qs : Qubit[]) : Unit is Adj+Ctl {
        CNOT(qs[0], qs[1]);
		CNOT(qs[1], qs[0]);
    }

    operation Solve (inputs : Qubit[], output : Qubit) : Unit is Adj+Ctl {
        using (qs = Qubit[2]) {
            X(qs[0]);X(qs[1]);
            for (i in 0 .. Length(inputs)-1) {
                if (i%2 == 0) {
                    Controlled incr ([inputs[i]], qs);
                }
                else {
                    Controlled Adjoint incr ([inputs[i]], qs);
                }
            }
            Controlled X (qs, output);
            for (i in 0 .. Length(inputs)-1) {
                if (i%2 == 0) {
                    Adjoint Controlled incr ([inputs[i]], qs);
                }
                else {
                    Controlled incr ([inputs[i]], qs);
                }
            }
            X(qs[0]);X(qs[1]);
        }
    }
}