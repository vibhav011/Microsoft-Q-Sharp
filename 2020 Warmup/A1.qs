namespace Solution {
    open Microsoft.Quantum.Intrinsic;

    operation Solve (unitary : (Qubit => Unit is Adj+Ctl)) : Int {
    	mutable ans = 0;
        using (q = Qubit()) {
        	let res = M(q);
        	unitary(q);
        	let res2 = M(q);

        	if (res != res2) {
        		set ans = 1;
        	}
        	Reset(q);
        }
        return ans;
    }
}