namespace Solution {
    open Microsoft.Quantum.Intrinsic;

    operation Solve (unitary : (Qubit => Unit is Adj+Ctl)) : Int {
    	mutable ans = 0;
        using (qs = Qubit[2]) {
            H(qs[0]);
            CNOT(qs[0], qs[1]);
            Controlled unitary([qs[0]], qs[1]);
            CNOT(qs[0], qs[1]);
            H(qs[0]);
            let res = M(qs[0]);
            if (res == Zero) {
                set ans = 1;
            }
            ResetAll(qs);
        }
        return ans;
    }
}