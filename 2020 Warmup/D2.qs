namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.MachineLearning;
 
    
    operation Solve () : (ControlledRotation[], (Double[], Double)) {
        return ([ControlledRotation((0, new Int[0]), PauliY, 0)],
                ([1.05], 0.25095));
    }
 
}