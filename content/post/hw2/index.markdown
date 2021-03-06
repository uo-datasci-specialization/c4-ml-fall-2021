---
title: Homework Assignment 2
author: Cengiz Zopluoglu
date: '2021-10-24'
assigned: '2020-10-27'
due: '2020-11-10'
slug: lab-1
categories:
  - Assignment
tags: [Lab, Assignments]
toc: true
---





## Overview

The purpose of this assignment is to get you working with the `caret` package and `glmnet` engine to fit regularized linear and logistic regression models for predicting a continuous and a categorical outcome.  Please prepare your assignment using RMarkdown. There are alternative ways to submit your assignment depending on your preference.

1. You knit the R Markdown document to a PDF document and then submit both the .Rmd and PDF files by uploading them on Canvas. 

2. You knit the R Markdown document to an html document and host it on your website/blog or any publicly available platform. Then, you can submit the .Rmd file by uploading it on Canvas and put the link for the html document as a comment.

3. If you have a Github repo and store all your work for this class in a Github repo, you can create a folder for this assignment in that repo, and put the .Rmd file and PDF document under a specific folder. Then, you can submit the link for the Github repo on Canvas.

To receive full credit, you must complete the following tasks. Please make sure that all the R code you wrote for completing these tasks and any associated output are explicitly printed in your submitted document. If the task asks you to submit the data files you created, please upload these datasets along with your submission.

If you have any questions, please do not hesitate to reach out to me.

## Part 1: Predicting a Categorical Outcome using Regularized Logistic Regression

For this assignment you will work with the twitter dataset and try to predict the sentiment of a given tweet. I uploaded the datasets on the website for convenience and to make sure everyone works on the same dataset. Download the tweet dataset using the R code below. Then, also create the blueprint as shown below.


```{.r .fold-show}
# Load the following packages needed for modeling in this assignment
  
  require(caret)
  require(recipes)
  require(finalfit)
  require(glmnet)

# Import the tweet dataset with embeddings

tweet <- read.csv('https://raw.githubusercontent.com/uo-datasci-specialization/c4-ml-fall-2021/main/content/post/hw2/data/hw1_tweet_final.csv',header=TRUE)

# Recipe for the tweet dataset

blueprint_tweet <- recipe(x  = tweet,
                          vars  = colnames(tweet),
                          roles = c('outcome',rep('predictor',772))) %>%
  step_dummy('month',one_hot=TRUE) %>% 
  step_harmonic('day',frequency=1,cycle_size=7, role='predictor') %>%
  step_harmonic('date',frequency=1,cycle_size=31,role='predictor') %>%
  step_harmonic('hour',frequency=1,cycle_size=24,role='predictor') %>%
  step_normalize(paste0('Dim',1:768)) %>%
  step_normalize(c('day_sin_1','day_cos_1',
                   'date_sin_1','date_cos_1',
                   'hour_sin_1','hour_cos_1')) %>%
  step_num2factor(sentiment,
                  transform = function(x) x + 1,
                  levels=c('Negative','Positive'))

  
    # Notice that I explicitly specified role=predictor when using
    # step_harmonic function. This assures that the newly derived sin and cos
    # variables has a defined role.
    # You need to do this otherwise caret::train function breaks.
    # caret_train requires every variable in the recipe to have a role
    
    # You can run the following code and make sure every variable has a defined 
    # role. If you want to experiment, remove the role=predictor argument
    # in the step_harmonic function, create the recipe again, and run the following
    # you will see that the new sin and cos variables have NA in the column role
    # and this breaks the caret::train function later.
  
    # Also, in the last line, we transform the outcome variable 'sentiment' to 
    # a factor with labels. 
    # This seems necessary for fitting logistic regression via caret::train

    View(blueprint_tweet %>% prep() %>% summary)
```

**Task 1.1.** Split the original data into two subsets: training and test. Let the training data have the 80% of cases and the test data have the  20% of the cases. 

**Task 1.2.** Use the `caret::train()` function to train a model with 10-fold cross-validation for predicting the probability of sentiment being positive using logistic regression without any regularization. Evaluate and report the performance of the model on the test dataset. 

**Task 1.3.** Use the `caret::train()` function to train a model with 10-fold cross-validation for predicting the probability of sentiment being positive using logistic regression with ridge penalty. Try different values of ridge penalty to decide the optimal value. Use `logLoss` as a metric for optimization. Plot the results, and report the optimal value of ridge penalty.

**Task 1.4.** Use the `caret::train()` function to train a model with 10-fold cross-validation for predicting the probability of sentiment being positive using logistic regression with lasso penalty. Try different values of lasso penalty to decide optimal value. Use `logLoss` as a metric for optimization. Plot the results, and report the optimal value of lasso penalty.

**Task 1.5** Evaluate the performance of the models in 1.2, 1.3, and 1.4 on the test dataset. Calculate and report logLoss (LL), area under the reciever operating characteristic curver (AUC), overall accuracy (ACC), true positive rate (TPR), true negative rate (TNR), and precision (PRE) for three models. When calculating ACC, TPR, TNR, and PRE, assume that we use a cut-off value of 0.5 for the predicted probabilities. Summarize these numbers in a table like the following. Decide and comment on which model you would use to predict sentiment of a tweet moving forward.

|                                         | LL  | AUC | ACC | TPR | TNR | PRE |
|-----------------------------------------|:---:|:---:|:---:|:---:|:---:|:---:|
| Logistic Regression                     |     |     |     |     |     |     |
| Logistic Regression with Ridge Penalty  |     |     |     |     |     |     |
| Logistic Regression with Lasso Penalty  |     |     |     |     |     |     |

<br/>


**Task 1.6** For the model you decided in 1.5, find and report the most important 10 predictors of sentiment and their coefficients. Briefly comment which variables seem to be the most important predictors. 

**Task 1.7.** Below are the two tweets I picked from my timeline. Use the model you decided in Task 1.5 to predict a probability that the sentiment being positive for these tweets. You are welcome to extract the word embeddings for these tweets by yourself (model: roberta-base, layer=12). Assume that all these tweets are posted on Saturday, May 1, 2021 at 12pm. For convenience, you can also download the dataset from the link below in case you have trouble in extracting the word embeddings. 


```{.r .fold-show}
tweet1  <- "You are not getting displaced you decide to sell your $800k townhome because a 12-story apartment goes up next door, and then can't find another $800k townhome in Arlington."

tweet2  <- "One cold morning and I'm in holiday mode. Bought gifts for students."
```


```{.r .fold-show}
new_tweets <- read.csv('https://raw.githubusercontent.com/uo-datasci-specialization/c4-ml-fall-2021/main/content/post/hw2/data/toy_tweet_embeddings.csv',header=TRUE)
```

**Task 1.8.** Let's do an experiment and test whether or not the model is biased against certain groups when detecting sentiment of a given text. Below you will find 10 hypothetical tweets with an identical structure. The only thing that changes from tweet to tweet is the subject. 

You are welcome to extract the word embeddings for these tweets by yourself (model: roberta-base, layer=12). Assume that all these tweets are posted on Saturday, May 1, 2021 at 12pm. For convenience, you can also download the dataset from the link below in case you have trouble in extracting the word embeddings. 


```{.r .fold-show}
text1  <- 'Muslims are so annoying!'
text2  <- 'Jews are so annoying!'
text3  <- 'Christians are so annoying!'
text4  <- 'Atheists are so annoying!'
text5  <- 'Buddhists are so annoying!'

text6  <- 'Turkish people are so annoying!'
text7  <- 'French people are so annoying!'
text8  <- 'American people are so annoying!'
text9  <- 'Japanese people are so annoying!'
text10 <- 'Russian people are so annoying!'
```


```{.r .fold-show}
bias_check <- read.csv('https://raw.githubusercontent.com/uo-datasci-specialization/c4-ml-fall-2021/main/content/post/hw2/data/bias_check_tweet_embeddings.csv',header=TRUE)
```

Use your model from Task 1.5 to predict the probability of these hypothetical tweets having a positive sentiment, and report these numbers in a table.

|                 | |                  | Probability(Sentiment=Positive)|
|-----------------|-|------------------|:------------------------------:|
| Muslims         | |are so annoying! |                                |
| Jews            | |are so annoying! |                                |
| Christians      | |are so annoying! |                                |
| Atheists        | |are so annoying! |                                | 
| Buddhists       | |are so annoying! |                                |
| Turkish people  | |are so annoying! |                                |
| French people   | |are so annoying! |                                |
| American people | |are so annoying! |                                |      
| Japanese people | |are so annoying! |                                |
| Russian people  | |are so annoying! |                                |

<br/>

What do you think? Does your model favor any group or seem to be biased against any group? Provide a brief commentary (not more than 500 words).

## Part 2: Predicting a Continous Outcome using Regularized Linear Regression

For this assignment you will work with the Oregon dataset and try to predict the scores.I uploaded the datasets on the website for convenience and to make sure everyone works on the same dataset. Download the Oregon testing dataset using the R code below. Then, also create the blueprint as shown below.


```{.r .fold-show}
# Load the following packages needed for modeling in this assignment
  
  require(caret)
  require(recipes)
  require(finalfit)
  require(glmnet)

# Import the oregon dataset

oregon <- read.csv('https://raw.githubusercontent.com/uo-datasci-specialization/c4-ml-fall-2021/main/content/post/hw2/data/hw1_oregon_final.csv',header=TRUE)

# Recipe for the oregon dataset

  outcome <- 'score'
  
  id      <- 'id'

  categorical <- c('sex','ethnic_cd','tst_bnch','migrant_ed_fg','ind_ed_fg',
                   'sp_ed_fg','tag_ed_fg','econ_dsvntg','stay_in_dist',
                   'stay_in_schl','dist_sped','trgt_assist_fg',
                   'ayp_dist_partic','ayp_schl_partic','ayp_dist_prfrm',
                   'ayp_schl_prfrm','rc_dist_partic','rc_schl_partic',
                   'rc_dist_prfrm','rc_schl_prfrm','grp_rpt_dist_partic',
                   'grp_rpt_schl_partic','grp_rpt_dist_prfrm',
                   'grp_rpt_schl_prfrm')

  numeric <- c('enrl_grd')

  cyclic <- c('date','month')


blueprint_oregon <- recipe(x     = oregon,
                    vars  = c(outcome,categorical,numeric,cyclic),
                    roles = c('outcome',rep('predictor',27))) %>%
  step_indicate_na(all_of(categorical),all_of(numeric)) %>%
  step_zv(all_numeric()) %>%
  step_impute_mean(all_of(numeric)) %>%
  step_impute_mode(all_of(categorical)) %>%
  step_harmonic('date',frequency=1,cycle_size=31,role='predictor') %>%
  step_harmonic('month',frequency=1,cycle_size=12,role='predictor') %>%
  step_ns('enrl_grd',deg_free=3) %>%
  step_normalize(c(paste0(numeric,'_ns_1'),paste0(numeric,'_ns_2'),paste0(numeric,'_ns_3'))) %>%
  step_normalize(c("date_sin_1","date_cos_1","month_sin_1","month_cos_1")) %>%
  step_dummy(all_of(categorical),one_hot=TRUE) %>%
  step_rm(c('date','month'))
    
  View(blueprint_oregon %>% prep() %>% summary)
```

**Task 2.1.** Check the dataset for missingness. If there is any variable with more than 75% missingness, remove these variables.

**Task 2.2.** Split the original data into two subsets: training and test. Let the training data have the 80% of cases and the test data have the  20% of the cases. 

**Task 2.3.** Use the `caret::train()` function to train a model with 10-fold cross-validation to predict the scores using linear regression without any regularization. Evaluate the performance of the model on both training and test datasets. Evaluate and report RMSE, R-square, and MAE for both training and test datasets. Is there any evidence of overfitting?  
 
**Task 2.4.** Use the `caret::train()` function to train a model with 10-fold cross-validation to predict the scores using ridge regression. Try different values of lambda to decide optimal value. Evaluate the performance of the model on the test dataset, and report RMSE, R-square, and MAE. Does ridge regression provide any improvement over linear regression with no regularization?

**Task 2.5.** Use the `caret::train()` function to train a model with 10-fold cross-validation to predict the scores using lasso regression. Try different values of lambda to decide optimal value. Evaluate the performance of the model on the test dataset, and report RMSE, R-square, and MAE. Does lasso regression provide any improvement over linear regression with no regularization?

**Task 2.6** Evaluate the performance of the models in 2.2, 2.3, and 2.4 on the test dataset. Calculate and report the root mean squared error (RMSE), mean absolute error (MAE), and R-square. Summarize these numbers in a table like the following. Decide and comment on which model you would use to predict scores.

|                                      | RMSE| MAE | R-sq|
|--------------------------------------|:---:|:---:|:---:|
| Linear Regression                    |     |     |     |
| Linear Regression with Ridge Penalty |     |     |     |
| Linear Regression with Lasso Penalty |     |     |     |

<br/>


**Task 2.7** For the model you decided in 2.6, find and report the most important 10 predictors of test scores and their regression coefficients. Briefly comment which variables seem to be the most important predictors.







