function calculateBMI() {
    const name = document.getElementById('name').value;
    const age = document.getElementById('age').value;
    const weight = document.getElementById('weight').value;
    const height = document.getElementById('height').value;

    if (name === '' || age === '' || weight === '' || height === '') {
        alert("Please fill all fields");
    } else {
        let bmi = parseFloat(weight) / Math.pow((parseFloat(height) / 100), 2);
        let resultText = "";

        if (bmi < 18.5) {
            resultText = "Underweight";
        } else if (bmi >= 18.5 && bmi <= 24.9) {
            resultText = "Normal Weight";
        } else if (bmi > 24.9 && bmi <= 29.9) {
            resultText = "Overweight";
        } else if (bmi > 30) {
            resultText = "Obese Class I";
        }

        // Display the results in an element with id="result"
        document.getElementById('result').innerHTML = `
            <p>Name: ${name}</p>
            <p>Age: ${age} years old</p>
            <p>BMI: ${bmi.toFixed(2)}</p>
            <p>Category: ${resultText}</p>
        `;
    }
}
