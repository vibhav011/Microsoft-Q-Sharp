namespace Solution {
    open Microsoft.Quantum.Intrinsic;

    operation Solve (qs : Qubit[]) : Unit {
        let n = Length(qs);
        for (i in 0 .. n-1) {
            X(qs[i]);
        }
        
        using (q = Qubit()) {
            repeat {
                for (i in 0 .. n-1) {
                    X(qs[i]);
                }
                for (i in 0 .. n-1) {
                    H(qs[i]);
                }
                Controlled X(qs, q);
                let res = M(q);
                X(q);
            } until (res == Zero);
            Reset(q);
        }
    }
}