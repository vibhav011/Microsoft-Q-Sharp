namespace Solution {
	open Microsoft.Quantum.Primitive;
	open Microsoft.Quantum.Canon;

	operation Solve (N : Int, Uf : ((Qubit[], Qubit) => ())) : Int[] {
		body {
			mutable b = new Int[N];
			using (qs = Qubit[N+1] ) {
				X(qs[N]);
				for (i in 0..N) {
					H(qs[i]);
				}
				Uf(qs[0..N-1], qs[N]);
				for (i in 0..N-1) {
					H(qs[i]);
				}
				
				for (i in 0..N-1) {
					let res = M(qs[i]);
					if (res == Zero) {set b w/= i <- 0;}
					else {set b w/= i <- 1;}
				}
				ResetAll(qs);
			}
			return b;
		}
	}
}
