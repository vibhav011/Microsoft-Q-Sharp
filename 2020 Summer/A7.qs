namespace Solution {    
    open Microsoft.Quantum.Intrinsic;

    operation Solve (unitary : (Qubit => Unit is Adj+Ctl)) : Int {
        mutable ans = 1;
        mutable type = 0;
        using (qs = Qubit[2]) {
            H(qs[0]);
            CNOT(qs[0], qs[1]);
            Controlled unitary ([qs[1]], qs[0]);
            Controlled unitary ([qs[1]], qs[0]);
            CNOT(qs[0], qs[1]);
            H(qs[0]);
            let res = M(qs[0]);
            if (res == One) {
                set type = 1;
            }
            ResetAll(qs);
            H(qs[0]);
            CNOT(qs[0], qs[1]);
            Controlled unitary ([qs[1]], qs[0]);
            if (type == 0) {
                S(qs[1]);
                set ans -= 1;
            }
            H(qs[1]);
            let res2 = M(qs[1]);
            if (res2 == One) {
                set ans += 2;
            }
            ResetAll(qs);
        }
        return ans;
    }
}