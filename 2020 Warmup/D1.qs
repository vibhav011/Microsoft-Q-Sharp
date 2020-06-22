namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.MachineLearning;
 
    
    operation Solve () : (ControlledRotation[], (Double[], Double)) {
        return ([ControlledRotation((0, new Int[0]), PauliY, 0)],
            	([3.1415], 0.0));
    }
 
}