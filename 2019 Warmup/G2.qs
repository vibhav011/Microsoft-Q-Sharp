namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve (x : Qubit[], y : Qubit) : Unit {
        body (...) {
        	X(y);
            let n = Length(x);
            (ControlledOnInt(0, X))(x, y);
        }
        adjoint auto;
    }
}