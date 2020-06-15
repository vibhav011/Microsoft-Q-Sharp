namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve (qs : Qubit[]) : Unit {
        X(qs[0]); X(qs[1]);

        using (q = Qubit()) {
        	repeat {
        		X(qs[0]); X(qs[1]);
        		H(qs[0]); H(qs[1]);
	        	Controlled X(qs, q);
	        	let res = M(q);
	        	X(q);
	        } until (res == Zero);
	        Reset(q);
        }
    }
}