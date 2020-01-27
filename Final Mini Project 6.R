#Sample Program

#Let's try Multiple Linear Regression

#Reading input file - crime.csv
crime <- read.csv(file="D:/FALL 17 MSCS/CS 6313.002 STATS/MINI PROJECTS/MINI PROJECT 6/crime.csv", header=TRUE, sep=",")


#Viewing the structure of the input file data
str(crime)

#Viewing the names of the columns in the input file 
names(crime)

#Attaching the dataset in R's memory - This enables us to use the variable names directly
attach(crime)


#Q1. (a) and (b)
table(state)
table(murder.rate)
table(poverty)
table(high.school)
table(college)
table(single.parent)
table(unemployed)
table(metropolitan)
table(region)

#Quantifying the qualitative variable 'Region'
reg = split(crime, crime$region)

#Let's analyze the murder rate state-wise
boxplot(reg$`North Central`$murder.rate, reg$Northeast$murder.rate,reg$South$murder.rate, reg$West$murder.rate, main = "Murder Rate region wise (North Central, Northeast, South and West)", names = c("North Central", "Northeast", "South", "West"))

#Let's have a look at murder rate
boxplot(murder.rate, main = c("Murder Rate"))
qqnorm(murder.rate, main = "Murder Rate Q-Q Plot")
qqline(murder.rate)

#Since the murder rate distribution is not approximately normal, we can transform it to make it more normal and get rid of the outliers too.
murder.rate <- sqrt(murder.rate)
qqnorm(murder.rate, main = "Transformed Murder Rate Q-Q Plot")
qqline(murder.rate)
boxplot(murder.rate, main = c("Transformed Murder Rate"))


#Let's try obtaining a fit for murder rate vs all other variables

fit1 <- lm(murder.rate ~ poverty)
summary(fit1)

fit2 <- lm(murder.rate ~ high.school)
summary(fit2)

fit3 <- lm(murder.rate ~ college)
summary(fit3)

fit4 <- lm(murder.rate ~ single.parent)
summary(fit4)

fit5 <- lm(murder.rate ~ unemployed)
summary(fit5)

fit6 <- lm(murder.rate ~ metropolitan)
summary(fit6)

fit7 <- lm(murder.rate ~ region)
summary(fit7)


par(mfrow = c(2,2))

plot(fitted(fit1), resid(fit1), main = c("Residual Plot for Murder Rate vs. Poverty"))
abline(h = 0)
plot(fitted(fit2), resid(fit2), main = c("Residual Plot for Murder Rate vs. High School"))
abline(h = 0)
plot(fitted(fit3), resid(fit3), main = c("Residual Plot for Murder Rate vs. College"))
abline(h = 0)
plot(fitted(fit4), resid(fit4), main = c("Residual Plot for Murder Rate vs. Single Parent"))
abline(h = 0)
plot(fitted(fit5), resid(fit5), main = c("Residual Plot for Murder Rate vs. Unemployed"))
abline(h = 0)
plot(fitted(fit6), resid(fit6), main = c("Residual Plot for Murder Rate vs. Metropolitan"))
abline(h = 0)
plot(fitted(fit7), resid(fit7), main = c("Residual Plot for Murder Rate vs. Region"))
abline(h = 0)



qqnorm(resid(fit1), main = c("Q-Q Plot for Murder Rate vs. Poverty"))
qqline(resid(fit1))
qqnorm(resid(fit2), main = c("Q-Q Plot for Murder Rate vs. High School"))
qqline(resid(fit2))
qqnorm(resid(fit3), main = c("Q-Q Plot for Murder Rate vs. College"))
qqline(resid(fit3))
qqnorm(resid(fit4), main = c("Q-Q Plot for Murder Rate vs. Single Parent"))
qqline(resid(fit4))
qqnorm(resid(fit5), main = c("Q-Q Plot for Murder Rate vs. Unemployed"))
qqline(resid(fit5))
qqnorm(resid(fit6), main = c("Q-Q Plot for Murder Rate vs. Metropolitan"))
qqline(resid(fit6))
qqnorm(resid(fit7), main = c("Q-Q Plot for Murder Rate vs. Region"))
qqline(resid(fit7))



#Let's estimate the correlation between murder rate and all other predictors
cor(murder.rate, poverty)
cor(murder.rate, high.school)
cor(murder.rate, college)
cor(murder.rate, single.parent)
cor(murder.rate, unemployed)
cor(murder.rate, metropolitan)


#Let's start the multiple linear regression model by first fitting murder rate against Single Parent

(fit4)
summary(fit4)

#Adding 'Metropolitan' to the fit

fit11 <- update(fit4, . ~ . + metropolitan)
(fit11)
summary(fit11)

#Applying anova to these two fits to see which is better
#Null Hypothesis: Metropolitan is not a significant contributor, i.e. Slope of Metropolitan = 0 while all other variables remain the same.
#Alternate Hypothesis: Metropolitan is a significant contributor, i.e. Slope of Metropolitan is != 0.

anova(fit4, fit11)

#Adding the next predictor to the model - Poverty.

fit12 <- update(fit11, . ~ . + poverty)
(fit12)
summary(fit12)

#Applying anova to these two fits to see which is better
#Null Hypothesis: Poverty is not a significant contributor, i.e. Slope of Poverty = 0 while all other variables remain the same.
#Alternate Hypothesis: Poverty is a significant contributor, i.e. Slope of Poverty is != 0.

anova(fit11, fit12)

#Since p-value for this anova > alpha, we have to accept the Null Hypothesis. This leads us to the conclusion that Poverty is not a significant contributor. 

#Adding the next predictor to the model - Unemployed.

fit13 <- update(fit11, . ~ . + unemployed)
(fit13)
summary(fit13)

#Applying anova to these two fits to see which is better
#Null Hypothesis: Unemployed is not a significant contributor, i.e. Slope of Unemployed = 0 while all other variables remain the same.
#Alternate Hypothesis: Unemployed is a significant contributor, i.e. Slope of Unemployed is != 0.

anova(fit11, fit13)

#Since p-value for this anova > alpha, we have to accept the Null Hypothesis. This leads us to the conclusion that Unemployed is not a significant contributor. 

fit14 <- update(fit11, . ~ . + region)
(fit14)
summary(fit14)

#Applying anova to these two fits to see which is better
#Null Hypothesis: Region is not a significant contributor, i.e. Slope of Region = 0 while all other variables remain the same. 
#Alternate Hypothesis: Region is a significant contributor, i.e. Slope of Region is != 0.

anova(fit11, fit14)

#Since Region is a significant contributor, fit14 becomes the final reduced model.
reduced_fit = fit14

(fit14)
summary(fit14)
boxplot(resid(reduced_fit), main = c("Reduced Model for Murder Rate"))
qqnorm(resid(reduced_fit), main = "Murder Rate Q-Q Plot")
qqline(resid(reduced_fit))
plot(fitted(reduced_fit), resid(reduced_fit))
abline(h = 0)
plot(fitted(reduced_fit), abs(resid(reduced_fit)))
abline(h = 0)
plot(resid(reduced_fit))
abline(h = 0)

#Comparison between Reduced and Full Model

full_model = lm(murder.rate ~ poverty + high.school + college + single.parent + unemployed + region)
(full_model)
summary(full_model)

#Anova
anova(reduced_fit, full_model)

#Summary of the final reduced model

summary(reduced_fit)












#Q1. (c)

#Set the most frequent category for the qualitative predictor - region

(region)
table(region)

#Set predictor values to the average in the data for quantitative predictors - Single Parent, Metropolitan

s1 = mean(single.parent)
m1 = mean(metropolitan)

murder.rate_1 = (0.255974) + (0.038963*s1) + (0.004254*m1) + (-0.192864*0) + (0.050389*0) + (-0.008913*0)

