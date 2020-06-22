namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.MachineLearning;

    operation Solve () : ((Int, Double[]), ControlledRotation[], (Double[], Double)) {
        return ((1, [0.25]), 
                [ControlledRotation((0, new Int[0]), PauliI, 0)],
                ([0.0], -0.013694568470321623));
    }
}