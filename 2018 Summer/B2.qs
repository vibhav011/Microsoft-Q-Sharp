namespace Solution {
	open Microsoft.Quantum.Primitive;
	open Microsoft.Quantum.Canon;

	operation Solve (qs : Qubit[]) : Int {
        body {
            let n = Length(qs);
            mutable ones = 0;
            for (i in 0 .. n-1) {
                let res = M(qs[i]);
                if (res == One) {
                    set ones += 1;
                }
            }
            if (ones == 1) {return 1;}
            return 0;
        }
    }
}
