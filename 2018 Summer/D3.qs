namespace Solution {
	open Microsoft.Quantum.Primitive;
	open Microsoft.Quantum.Canon;

	operation Solve (x : Qubit[], y : Qubit) : () {
		body {
			(ControlledOnInt(7, X)) (x, y);
			(ControlledOnInt(6, X)) (x, y);
			(ControlledOnInt(5, X)) (x, y);
			(ControlledOnInt(3, X)) (x, y);
		}
	}
}