namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation HelperX (qs : Qubit[]) : Unit is Adj+Ctl {
    	let n = Length(qs);
    	for (i in 0 .. n-1) {
    		X(qs[i]);
    	}
    }
    operation HelperH (qs : Qubit[]) : Unit is Adj+Ctl {
    	let n = Length(qs);
    	for (i in 0 .. n-1) {
    		H(qs[i]);
    	}
    }

    operation Solve (qs : Qubit[]) : Unit {
    	let n = Length(qs);
        X(qs[n-1]);
    	Controlled HelperX ([qs[n-1]], qs[0..n-2]);
        X(qs[n-1]);
        Controlled HelperH ([qs[n-1]], qs[0..n-2]);
    }
}