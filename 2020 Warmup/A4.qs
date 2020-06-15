namespace Solution {
    open Microsoft.Quantum.Intrinsic;

    operation Solve (unitary : (Qubit[] => Unit is Adj+Ctl)) : Int {
    	mutable ans = 0;
        using ((q0, q1) = (Qubit(), Qubit())) {
            unitary([q0, q1]);

        	let res = M(q1);

        	if (res == Zero) {
        		set ans = 1;
        	}
        	Reset(q0);
            Reset(q1);
        }
        return ans;
    }
}