namespace Solution {
	open Microsoft.Quantum.Primitive;
	open Microsoft.Quantum.Canon;

	operation Solve (q : Qubit) : Int {
        body {
            mutable toss = 0;
            using (qub = Qubit()) {
                H(qub);
                if (M(qub) == One) {
                    set toss = 1;
                }
                Reset(qub);
            }
            if (toss == 0) {
                if (M(q) == One) {return 1;}
                return -1;
            }
            else {
                H(q);
                if (M(q) == One) {return 0;}
                return -1;
            }

        }
    }
}
