namespace Solution {
	open Microsoft.Quantum.Primitive;
	open Microsoft.Quantum.Canon;

	operation Solve (qs : Qubit[]) : Int {
        body {
            H(qs[0]); H(qs[1]);
            let res1 = M(qs[0]);
            let res2 = M(qs[1]);
            if (res1 == Zero and res2 == Zero) {return 0;}
            elif (res1 == Zero and res2 == One) {return 1;}
            elif (res1 == One and res2 == Zero) {return 2;}
            else {return 3;}
        }
    }
}
