namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.MachineLearning;

    operation Solve () : ((Int, Double[]), ControlledRotation[], (Double[], Double)) {
        return ((4, [1.0, 1.0]), 
                [ControlledRotation((0, [1]), PauliX, 0),
                 ControlledRotation((1, [0]), PauliX, 0),
                 ControlledRotation((0, [1]), PauliX, 0)],
                ([3.14], 0.14));
    }
}