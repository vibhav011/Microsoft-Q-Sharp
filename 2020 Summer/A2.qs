namespace Solution {
    open Microsoft.Quantum.Intrinsic;

    operation Solve (unitary : (Qubit[] => Unit is Adj+Ctl)) : Int {
        mutable ans = 0;
        using (qs = Qubit[2]) {
            X(qs[0]);
            unitary(qs);
            let res1 = M(qs[0]);
            let res2 = M(qs[1]);
            if (res1 == Zero and res2 == One) {
                set ans = 3;
            }
            elif (res1 == One and res2 == One) {
                set ans = 1;
            }
            else {
                X(qs[1]);
                unitary(qs);
                let res = M(qs[0]);
                if (res == Zero) {
                    set ans = 2;
                }
            }
            ResetAll(qs);
        }
        return ans;
    }
}