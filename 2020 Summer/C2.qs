namespace Solution {
    open Microsoft.Quantum.Intrinsic;

    operation Solve (qs : Qubit[], parity : Int) : Unit is Ctl {
        let n = Length(qs);

        if (parity == 1) {
            if (n == 1) {
                X(qs[0]);
            }
            else {
                H(qs[0]);
                Controlled Solve([qs[0]], (qs[1..n-1], 1-parity));
                X(qs[0]);
                Controlled Solve([qs[0]], (qs[1..n-1], parity));
                X(qs[0]);
            }
        }
        else {
            if (n != 1) {
                H(qs[0]);
                Controlled Solve([qs[0]], (qs[1..n-1], 1-parity));
                X(qs[0]);
                Controlled Solve([qs[0]], (qs[1..n-1], parity));
                X(qs[0]);
            }
        }
        
    }
}