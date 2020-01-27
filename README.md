# Murder-Rate-Analysis
This repository has been created to analyze a dataset consisting of geographical, social and economic data points for a population to determine which factors play a role in contributing to the murder rate and crime index of a geographic region.

# Problem Statement
Crime data is stored in crime.csv. The goal is to understand how murder rate is related to the other variables in the dataset. Note that 'state' is the "subject" here; it's not a predictor, and 'region' is a qualitative variable.

(a) Fit a multiple linear regression model to predict murder rate based on the other variables. Perform model diagnostics to check assumptions and perform any transformations needed to obtain a model that is reasonable with respect to the standard assumptions for linear models.

(b) Reduce your model by removing any unimportant variables (if such variables exist). Interpret the reduced model, including coefficients and r-squared. Perform a statistical test that compares the full model to the reduced model. Clearly state the hypotheses associated with this test and interpret the results.

(c) Use your final model to predict murder rate of a state whose predictor values are set at the average in the data for a quantitative predictor and the most frequent category for a qualitative predictor.

# Analysis
By looking at the correlation values, we can conclude to a certain extent that ‘High School’ and ‘College’ are not very significant contributors due to the negative rate of correlation. The highest correlation with murder rate is ‘Single Parent’, followed by ‘Metropolitan’. They are closely followed by ‘Poverty’ and ‘Unemployed’.

To decide which predictors must be used to predict murder rate, we have looked at the correlation values, the boxplots, Q-Q plots and Residual plots. Based on these, we have first tried a fit between murder rate and ‘Single Parent’. Successively, we have added to the fit the other predictors in succession – ‘Metropolitan’, ‘Poverty’ and ‘Unemployed’. For the full model, we also include ‘High School’ and ‘College’.

After all these computations, the final model we have arrived at to predict murder rate is - Single Parent + Metropolitan + Region.

Final Model = Reduced Model = Single Parent + Metropolitan + Region.

R-squared Comparison between the two models/fits:
The Adjusted R-squared value for the Reduced Model = 0.6296
The Adjusted R-squared value for the Full Model = 0.5688

R-squared is the percentage of the response variable that is explained by a linear model. The higher the value of R-squared, the better the model fits the data.

Inference: The Reduced Model explains 62.96% of the response variable accurately whereas, the Full Model explains 56.88% of the response variable accurately. 

CONCLUSION:
Therefore, this further proves that the Reduced Model is a better fit for the data of the response variable than the Full Model.


