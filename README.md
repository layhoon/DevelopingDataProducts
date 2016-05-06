# Diabetic Risk Classification

This application provides two classification models, Random Forest and Logistic Regression, to classify an individual female of Pima Indian heritage and living near Phoenix, Arizona as being likely or not likely to be tested positive with diabetic condition based on 7 health variables. It also provides a feature plot to help visualize the relationship among the health variables and the outcome.

<br>
The data used to build both the Random Forest and the Logistic Regression models come from the [Pima datasets](https://vincentarelbundock.github.io/Rdatasets/doc/MASS/Pima.tr.html) in MASS R Package. These data were obtained from the diabetic tests carried out according to World Health Organization (WHO) criteria on a population of women who were at least 21 years old, of Pima Indian heritage and living near Phoenix, Arizona. These data were collected by the US National Institute of Diabetes and Digestive and Kidney Diseases.

<br>
Source code of the application is available at [Github](https://github.com/layhoon/DevelopingDataProducts)


------
### Classification

At the **Classification** panel, you can enter the health variables for a new case. The application auto classifies the outcome based on the Random Forest and the Logistic Regression models.

<br>
The 7 health variables are:
- Number of pregnancies
- Plasma glucose concentration in an oral glucose tolerance test
- Diastolic blood pressure (mm Hg)
- Triceps skin fold thickness (mm)
- Body mass index (weight in kg)/(height in m)^2
- Diabetes pedigree function
- Age in years

<br>
An outcome of **No** indicates that the individual is not likely to be tested positive for diabetic condition, while an outcome of **Yes** indicates that the individual is likely to be tested positive for diabetic condition.

------
### Feature Plot

At the **Feature Plot** panel, you can select the x and y variables to display their relationship.

<br>
Below is the list of variables available for selection.
- Number of pregnancies
- Plasma glucose concentration in an oral glucose tolerance test
- Diastolic blood pressure (mm Hg)
- Triceps skin fold thickness (mm)
- Body mass index (weight in kg)/(height in m)^2
- Diabetes pedigree function
- Age in years
- Type (outcome): No if not diabetic, Yes if diabetic
