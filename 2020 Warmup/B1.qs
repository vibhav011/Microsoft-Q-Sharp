namespace Solution {	
	open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;

	operation Solve (register : LittleEndian) : Unit is Adj+Ctl {
		mutable n = Length(register!);
        if (n == 1) {
            X(register![0]);
        }
        else {
            Controlled Solve([register![0]], LittleEndian(register![1..n-1]));
            X(register![0]);
        }
	}
}