namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve (qs : Qubit[], bits : Bool[][]) : Unit {
        using (anc = Qubit[2]) {
            H(anc[0]); H(anc[1]);

            for (i in 0 .. Length(qs)-1) {
                for (j in 0..3) {
                    if (bits[j][i]) {
                        (ControlledOnInt(j, X))(anc, qs[i]);
                    }
                }
            }
            (ControlledOnBitString(bits[1], X))(qs, anc[0]);
            (ControlledOnBitString(bits[2], X))(qs, anc[1]);
            (ControlledOnBitString(bits[3], X))(qs, anc[0]);
            (ControlledOnBitString(bits[3], X))(qs, anc[1]);
            ResetAll(anc);
        }
    }
}