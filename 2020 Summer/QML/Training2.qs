namespace Microsoft.Quantum.Problem {

	open Microsoft.Quantum.Arithmetic;
	open Microsoft.Quantum.Arrays;
	open Microsoft.Quantum.Intrinsic;
	open Microsoft.Quantum.Canon;
	open Microsoft.Quantum.Convert;
	open Microsoft.Quantum.Math;
	open Microsoft.Quantum.Diagnostics;
	open Microsoft.Quantum.MachineLearning;
		
	// ------------------------------------------------------
	// input is the array of original features
	// output is the array of engineered features, that might be larger than the original one

	// mode 0 is no engineering: we return exactly the same features as the ones we started with
	// the parameters array is ignored
	function RawFeatures (auxil : Double[], input : Double[]) : Double[] {
		return input;
	}


	// mode 1 is feature padding: the parameters array is appended to the features array (padding on the left)
	// the length of the result is len(auxil) + len(input)
	function LeftPaddedFeatures (auxil : Double[], input : Double[]) : Double[] {
		return auxil + input;
	}


	// mode 2 is tensor product of the parameters array with input:
	// [auxil[0] * input[0], auxil[0] * input[1], auxil[1] * input[0], auxil[1] * input[1]]
	// the length of the result is len(auxil) * len(input)
	function FeaturesTensorWithAncilla (auxil : Double[], input : Double[]) : Double[] {
		mutable ret = new Double[Length(auxil) * Length(input)];
		for (j in 0 .. Length(auxil) - 1) {
			for (k in 0 .. Length(input) - 1) {
				set ret w/= (j * Length(input) + k) <- (auxil[j] * input[k]);   
			}
		}
		return ret;
	}

	// mode 3 is feature fanout: tensor product of the parameters array with input with input
	// the length of the result is len(auxil) * len(input)^2
	function FeaturesFanout (auxil : Double[], input : Double[]) : Double[] {
		mutable ret = new Double[Length(auxil)*Length(input)*Length(input)];
		for (j in 0..Length(auxil)-1) {
			for (k in 0..Length(input)-1) {
				for (m in 0..Length(input)-1) {
					set ret w/= (j*Length(input)*Length(input)+k*Length(input)+m) <- (auxil[j] * input[k] * input[m]);   
				}
			}
		}
		return ret;	
	}

	// mode 4 is tensor product of (concatenation of left halves of parameters and input) and (concatenation of right halves)
	// [auxil[0] * auxil[1], auxil[0] * input[1], input[0] * auxil[1], input[0] * input[1]]
	// the length of the result is len(auxil) * len(input)
	function FeaturesSplitFanout (auxil : Double[], input : Double[]) : Double[] {
		let halfLa = Length(auxil)/2;
		let halfLi = Length(input)/2;
		let left = auxil[...(halfLa-1)] + input[...(halfLi-1)];
		let right = auxil[halfLa...] + input[halfLi...];
		return FeaturesTensorWithAncilla(left, right);
	}


	// a helper function to choose and apply the necessary feature engineering mode
	function FeaturesPreprocess (mode : Int, auxil : Double[], input : Double[]) : Double[] {
		if (mode == 1) { return LeftPaddedFeatures(auxil, input); }
		if (mode == 2) { return FeaturesTensorWithAncilla(auxil, input); }
		if (mode == 3) { return FeaturesFanout(auxil, input); }
		if (mode == 4) { return FeaturesSplitFanout(auxil, input); }
		// in case of unsupported mode, return the raw features
		return input;
	}

	function DefaultSchedule(samples : Double[][]) : SamplingSchedule {
        return SamplingSchedule([
            0..Length(samples) - 1
        ]);
    }

	operation Solve () : ((Int, Double[]), ControlledRotation[], (Double[], Double)) {
        return ((1, [1.0]), 
                [
            ControlledRotation((0, new Int[0]), PauliX, 4),
            ControlledRotation((0, new Int[0]), PauliZ, 5),
            ControlledRotation((1, new Int[0]), PauliX, 6),
            ControlledRotation((1, new Int[0]), PauliZ, 7),
            ControlledRotation((0, [1]), PauliX, 0),
            ControlledRotation((1, [0]), PauliX, 1),
            ControlledRotation((1, new Int[0]), PauliZ, 2),
            ControlledRotation((1, new Int[0]), PauliX, 3)
        ],
                ([0.06122739640097666,3.125680673633861,1.9661489902400997,0.5002328930920451,0.8266058739006388,1.0559063644413702,4.035123440379326,5.768965473078123], 0.15739031080092059));
    }

	// ------------------------------------------------------
	// Call this operation from the classical driver which reads the data
	operation TestOperation (features : Double[][], labels : Int[]) : Double {
		// get the solution's model (don't pass any parameters to the solution)
		let ((engineeringMode, engineeringParameters), classifierStructure, (modelParameters, bias)) = Solve();

		// apply the necessary engineering to our original data
		let engineeredData = Mapped(FeaturesPreprocess(engineeringMode, engineeringParameters, _), features);

		// get the final data and combine it with labels
		let data = Mapped(
			LabeledSample,
			Zip(engineeredData, labels)
		);
		let N = Length(data);

		let model = SequentialModel(classifierStructure, modelParameters, bias);

		let defaultSchedule = SamplingSchedule([0..N - 1]);
        let (optimizedModel, nMisses) = TrainSequentialClassifier(
            [model],
            data,
            DefaultTrainingOptions()
                w/ LearningRate <- 0.05
                w/ MinibatchSize <- 15
                w/ MaxEpochs <- 8
                w/ Tolerance <- 0.000001
                w/ VerboseMessage <- Message,
            defaultSchedule,
            defaultSchedule
        );
        Message($"Training complete, found optimal parameters: {optimizedModel::Parameters}, {optimizedModel::Bias} with {nMisses} misses");

		// classify the data using the model/parameters provided by the solution
		
		let tolerance = 0.000001;
		let nMeasurements = 10000;
		let results = ValidateSequentialClassifier(
			model,
			data,
			tolerance,
			nMeasurements,
			defaultSchedule
		);

		// Message($"Misclassifications: {results::NMisclassifications}");

		let errorRate = IntAsDouble(results::NMisclassifications) / IntAsDouble(N);

		// we don't require perfect results, but a low enough error rate
		// let threshold = 0.05;
		// if (errorRate > threshold) {
		// 	// we can offer debug message here, since we know the test will fail regardless of it
		// 	Message($"Error rate {errorRate} above threshold {threshold}");
		// }
		return errorRate;
	}
}