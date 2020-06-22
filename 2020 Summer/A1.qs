namespace Solution {
    open Microsoft.Quantum.Intrinsic;

    operation Solve (unitary : (Qubit[] => Unit is Adj+Ctl)) : Int {
    	mutable ans = 0;
        using (qs = Qubit[2]) {
        	X(qs[0]);
        	unitary(qs);
        	let res = M(qs[1]);
        	if (res == Zero) {
        		set ans = 1;
        	}
        	ResetAll(qs);
        }
        return ans;
    }
}