namespace Solution {
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    operation Solve (p : Int, inputRegister : LittleEndian) : Unit is Adj+Ctl {
        let n = p%4;
        if (n > 0) {
        	for (i in 1 .. n) {
        		QFTLE(inputRegister);
        	}
        }
    }
}