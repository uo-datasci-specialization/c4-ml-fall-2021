---
title: Homework Assignment 3
author: Cengiz Zopluoglu
date: '2021-11-24'
assigned: '2021-11-24'
due: '2021-12-10'
slug: lab-1
categories:
  - Assignment
tags: [Lab, Assignments]
toc: true
---





## Overview

The purpose of this assignment is to get you working with the `caret` package and `ranger` engine to fit the Bagged Trees and Random Forests models for predicting a continuous and a categorical outcome.  Please prepare your assignment using RMarkdown. There are alternative ways to submit your assignment depending on your preference.

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
  require(ranger)

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
  step_rm(c('day','date','hour')) %>%
  step_num2factor(sentiment,
                  transform = function(x) x + 1,
                  levels=c('Negative','Positive'))
```

**Task 1.1.** Split the original data into two subsets: training and test. Let the training data have the 80% of cases and the test data have the  20% of the cases. 

**Task 1.2.** Use the `caret::train()` function and `ranger` engine to train a model with 10-fold cross-validation for predicting the probability of sentiment being positive using a Bagged Trees model with 500 trees. 

**Task 1.3.** Use the `caret::train()` function and `ranger` engine to train a model with 10-fold cross-validation for predicting the probability of sentiment being positive using a Random Forest model with 500 trees. Set the number of predictors to consider to 250 for each tree while growing a random forest. 

**Task 1.4** Evaluate the performance of the Bagged Tree models (1.2) and Random Forest Model (1.3) on the test dataset. Calculate and report logLoss (LL), area under the reciever operating characteristic curver (AUC), overall accuracy (ACC), true positive rate (TPR), true negative rate (TNR), and precision (PRE) for three models. When calculating ACC, TPR, TNR, and PRE, assume that we use a cut-off value of 0.5 for the predicted probabilities. Summarize these numbers in a table like the following. Decide and comment on which model you would use to predict sentiment of a tweet moving forward.

|                                         | LL  | AUC | ACC | TPR | TNR | PRE |
|-----------------------------------------|:---:|:---:|:---:|:---:|:---:|:---:|
| Bagged Trees Model                      |     |     |     |     |     |     |
| Random Forest Model                     |     |     |     |     |     |     |

**Task 1.5** Compare the performance of the Bagged Trees Model and Random Forest Model in this assignment to the performance of logistic regression models from the previous assignment. Comment on what you observe. Did Bagged Trees or Random Forest Models perform better than Logistic Regression Models?

<br/>


## Part 2: Predicting a Continous Outcome using Regularized Linear Regression

For this assignment you will work with the Oregon dataset and try to predict the scores.I uploaded the datasets on the website for convenience and to make sure everyone works on the same dataset. Download the Oregon testing dataset using the R code below. Then, also create the blueprint as shown below.


```{.r .fold-show}
# Load the following packages needed for modeling in this assignment
  
  require(caret)
  require(recipes)
  require(ranger)

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

**Task 2.1.** Split the original data into two subsets: training and test. Let the training data have the 80% of cases and the test data have the  20% of the cases. 

**Task 2.2.** Use the `caret::train()` function and `ranger` engine to train a model with 10-fold cross-validation for predicting the scores using a Bagged Trees model with 500 trees. 

**Task 2.3.** Use the `caret::train()` function and `ranger` engine to train a model with 10-fold cross-validation for predicting the scores using a Random Forest model with 500 trees. Set the number of predictors to consider to 25 for each tree while growing a random forest. 

**Task 2.4** Evaluate the performance of the Bagged Tree models (2.2) and Random Forest Model (2.3) on the test dataset. Calculate and report the root mean squared error (RMSE), mean absolute error (MAE), and R-square. Summarize these numbers in a table like the following. 

|                                         |RMSE | MAE |R-sq | 
|-----------------------------------------|:---:|:---:|:---:|
| Bagged Trees Model                      |     |     |     |
| Random Forest Model                     |     |     |     |

<br/>

**Task 1.5** Compare the performance of the Bagged Trees Model and Random Forest Model in this assignment to the performance of linear regression models from the previous assignment. Comment on what you observe. Did Bagged Trees or Random Forest Models perform better than Linear Regression Models in predicting the test scores?





