namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve (x : Qubit[], y : Qubit) : Unit {
        body (...) {
            let n = Length(x);
            (ControlledOnInt(2^n-1, X))(x, y);
        }
        adjoint auto;
    }
}