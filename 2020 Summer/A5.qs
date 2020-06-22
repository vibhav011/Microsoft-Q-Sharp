namespace Solution {    
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;

    operation Solve (theta : Double, unitary : (Qubit => Unit is Adj+Ctl)) : Int {
        let n = Floor(PI() / theta);
        mutable ans = 0;
        using (q = Qubit()) {
            for (j in 0 .. 7) {
                for (i in 1 .. n) {
                    unitary(q);
                }
                let res = M(q);
                Reset(q);
                if (res == One) {
                    set ans = 1;
                }
            }
            Reset(q);
        }
        return ans;
    }
}