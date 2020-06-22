namespace Solution {	
	open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;

	operation Solve (unitary : ((Double, Qubit) => Unit is Adj+Ctl)) : Int {
    	mutable ans = 0;
        using (q = Qubit[2]) {
        	H(q[0]);
            CNOT(q[0], q[1]);
            Controlled unitary ([q[0]], (2.0*PI(), q[1]));
            CNOT(q[0], q[1]);
            H(q[0]);
            let res = M(q[0]);
            if (res == Zero) {
                set ans = 1;
            }
            ResetAll(q);
        }
        return ans;
    }
}