namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Helper (qs : Qubit[]) : Unit is Ctl {
    	for (i in 0 .. Length(qs)-1) {
    		X(qs[i]);
    	}
    }

    operation Solve (qs : Qubit[]) : Unit {
        let n = Length(qs);
    	Controlled Helper ([qs[n-1]], qs[0..n-2]);
        H(qs[n-1]);
        Controlled Helper ([qs[n-1]], qs[0..n-2]);
        Helper(qs);
        using (q = Qubit()) {
            (ControlledOnInt(2^(n-1), X)) (qs, q);
            (ControlledOnInt(2^(n-1)-1, X)) (qs, q);
            Controlled Helper ([q], qs);
            (ControlledOnInt(2^(n-1), X)) (qs, q);
            (ControlledOnInt(2^(n-1)-1, X)) (qs, q);
        }
    }
}