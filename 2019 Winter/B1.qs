namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Math;

    operation Solve (qs : Qubit[]) : Int {
        R1(4.0 * PI() / 3.0, qs[1]);
        R1(2.0 * PI() / 3.0, qs[2]);
        (ControlledOnInt(0, X))(qs[0..1], qs[2]);
        (ControlledOnInt(0, H))([qs[0]], qs[1]);
        Ry(-2.0 * ArcSin(1.0 / Sqrt(3.0)), qs[0]);
        mutable ones = 0;
        for (i in 0..2) {
            let res = M(qs[i]);
            if (res == One) {
                set ones += 1;
            }
        }
        if (ones == 0) {return 0;}
        return 1;
    }
}