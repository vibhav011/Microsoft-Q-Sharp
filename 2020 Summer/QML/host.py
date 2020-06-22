import json

import qsharp
qsharp.packages.add("Microsoft.Quantum.MachineLearning::0.11.2006.403")
qsharp.reload()

from Microsoft.Quantum.Problem import (
    TestOperation
)

if __name__ == "__main__":
    with open('data7.json') as f:
        data = json.load(f)

    error = TestOperation.simulate(
        features=data['Features'],
        labels=data['Labels']
    )

    error = error*100.0

    print(f"Error rate: {error}%")