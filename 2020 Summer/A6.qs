namespace Solution {    
    open Microsoft.Quantum.Intrinsic;

    operation Solve (unitary : (Qubit => Unit is Adj+Ctl)) : Int {
        mutable ans = 0;
        using (q = Qubit[2]) {
            H(q[0]);
            CNOT(q[0], q[1]);
            unitary(q[0]);
            CNOT(q[0], q[1]);
            let res1 = M(q[1]);
            H(q[0]);
            let res2 = M(q[0]);
            if (res1 == Zero) {
                if (res2 == One) {
                    set ans = 3;
                }
            }
            else {
                if (res2 == One) {
                    set ans = 2;
                }
                else {
                    set ans = 1;
                }
            }
            ResetAll(q);
        }
        return ans;
    }
}