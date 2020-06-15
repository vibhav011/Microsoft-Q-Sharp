namespace Solution {
	open Microsoft.Quantum.Primitive;
	open Microsoft.Quantum.Canon;

	operation Solve (qs : Qubit[]) : () {
		body {
			let n = Length(qs);
	        if (n == 1) {
	            X(qs[0]);
	        }
	        else {
	            Solve (qs[0..n/2-1]);
	            using (flag = Qubit()) {
	                H(flag);
	                for (i in 0..n/2-1) {
	                    Controlled SWAP([flag], (qs[i], qs[i + n/2]));
	                }
	                for (i in n/2 .. n-1) {
	                    CNOT(qs[i], flag);
	                }
	                Reset(flag);
	            }
	        }
	    }
	}
}
