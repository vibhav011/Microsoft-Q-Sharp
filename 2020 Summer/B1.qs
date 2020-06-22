namespace Solution {    
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    operation addone (qs : Qubit[]) : Unit is Adj+Ctl {
        let n = Length(qs);
        if (n == 1) {X(qs[0]);}
        else {
            Controlled addone ([qs[0]], qs[1..n-1]);
            X(qs[0]);
        }
    }

    operation helper (inputs : Qubit[], qs : Qubit[]) : Unit is Adj+Ctl {
        for (i in 0 .. Length(inputs)-1) {
            Controlled addone ([inputs[i]], qs);
        }
    }

    operation Solve (inputs : Qubit[], output : Qubit) : Unit is Adj+Ctl {
        let n = Length(inputs);
        using (qs = Qubit[n]) {
            helper(inputs, qs);
            (ControlledOnInt(n/2, X)) (qs, output);
            Adjoint helper(inputs, qs);
        }
    }
}