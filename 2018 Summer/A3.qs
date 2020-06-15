namespace Solution {
	open Microsoft.Quantum.Primitive;
	open Microsoft.Quantum.Canon;

	operation Solve (qs : Qubit[], bits0 : Bool[], bits1 : Bool[]) : () {
		body {
			mutable ind = 0;
			while (bits0[ind] == bits1[ind]) {
				set ind+= 1;
			}
			H(qs[ind]);
			for (i in 0 .. Length(qs)-1) {
				if (i != ind) {
					if (bits0[i]) {
						if (bits1[i]) {
							X(qs[i]);
						}
						else {
							if (bits0[i] == bits0[ind]) {
								CNOT(qs[ind], qs[i]);
							}
							else {
								X(qs[i]);
								CNOT(qs[ind], qs[i]);
							}
						}
					}
					else {
						if (bits1[i]) {
							if (bits0[i] == bits0[ind]) {
								CNOT(qs[ind], qs[i]);
							}
							else {
								X(qs[i]);
								CNOT(qs[ind], qs[i]);
							}
						}
					}
				}
			}
		}
	}
}
