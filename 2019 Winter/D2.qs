namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Helper (qs : Qubit[]) : Unit is Ctl {
    	for (i in 0 .. Length(qs)-1) {
    		H(qs[i]);
    	}
    }

    operation Solve (qs : Qubit[]) : Unit is Ctl {
        let n = Length(qs);
        if (n > 1) {
        	X(qs[n-1]);
        	Controlled Solve ([qs[n-1]], qs[0..n-2]);
        	X(qs[n-1]);
        	Controlled Helper ([qs[n-1]], qs[0..n-2]);
        }
    }
}