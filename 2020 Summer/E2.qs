namespace Solution {
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;

    operation rotateAncilla (qs : Qubit[], inp : Qubit[]) : Unit is Adj+Ctl {
        H(qs[0]); H(qs[1]);
        Controlled QFTLE([qs[0]], LittleEndian(inp));
        Controlled QFTLE([qs[1]], LittleEndian(inp));
        Controlled QFTLE([qs[1]], LittleEndian(inp));
        Adjoint QFTLE(LittleEndian(qs));
    }
    operation Solve (p : Int, inputRegister : LittleEndian) : Unit is Adj+Ctl {
        let p1 = IntAsDouble(p);
        let inp = inputRegister!;
        using (qs = Qubit[2]) {
            rotateAncilla(qs, inp);
            R1 (PI()/p1, qs[1]);
            R1 (0.5*PI()/p1, qs[0]);
            Adjoint rotateAncilla(qs, inp);
        }
    }
}