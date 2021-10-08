---
title: Homework Assignment 1
author: Cengiz Zopluoglu
date: '2021-10-07'
assigned: '2020-10-11'
due: '2020-10-25'
slug: lab-1
categories:
  - Assignment
tags: [Lab, Assignments]
toc: true
---
<script src="{{< blogdown/postref >}}index_files/kePrint/kePrint.js"></script>
<link href="{{< blogdown/postref >}}index_files/lightable/lightable.css" rel="stylesheet" />





## Overview

The purpose of this assignment is to get you working with the `recipes` package and preprocessing the variables in two different datasets. You will use the same datasets with processed variables to build models in the next assignments.

Please prepare your assignment using RMarkdown. There are alternative ways to submit your assignment depending on your preference.

1. You knit the R Markdown document to a PDF document and then submit both the .Rmd and PDF files by uploading them on Canvas. 

2. You knit the R Markdown document to an html document and host it on your website/blog or any publicly available platform. Then, you can submit the .Rmd file by uploading it on Canvas and put the link for the html document as a comment.

3. If you have a Github repo and store all your work for this class in a Github repo, you can create a folder for this assignment in that repo, and put the .Rmd file and PDF document under a specific folder. Then, you can submit the link for the Github repo on Canvas.

To receive full credit, you must complete the following tasks. Please make sure that all the R code you wrote for completing these tasks and any associated output are explicitly printed in your submitted document. If the task asks you to submit the data files you created, please upload these datasets along with your submission.

If you have any questions, please do not hesitate to reach out to me.

## Part 1: Preprocessing Text Data

For this part of the assignment, you will work with a Twitter dataset which is randomly sampled from a larger dataset on the Kaggle platform [(see this link for the original data)](https://www.kaggle.com/matyasmacudzinski/sentiment-analysis-using-bert/data). In this subset data, there are 1,500 tweets and three variables.

- **sentiment**: a character string variable with two values (Positive and Negative) for the outcome variable to predict. 
- **time**: a character string variable indicating time of a tweet (e.g.,Thu Jun 18 07:35:01 PDT 2009)
- **tweet**: a character string variable that provides the full text of a tweet.

Our ultimate goal is to build a model to predict whether or not a tweet has a positive sentiment by using the information from time of the tweet and text of the tweet. We will do this in the following assignments. For this assignment, we will only engineer features to use them later for building our models and prepare the dataset for model development. 

Please complete the following tasks. Provide the R code you wrote and any associated output for each task.

**Task 1.1.** Import the tweet data from [this link](https://raw.githubusercontent.com/uo-datasci-specialization/c4-ml-fall-2021/main/data/tweet_sub.csv).

**Task 1.2.** The `time` variable in this dataset is a character string such as *Thu Jun 18 07:35:01 PDT 2009*. Create four new columns in the dataset using this time variable to show the day, date, month, and hour of a tweet. The table below provides some examples of how these four new columns would look like given time as a character string. Make sure that `day` column is a numeric variable from 1 to 7 (Monday = 1, Sunday =7), `date` column is a numeric variable from 1 to 31, and `hour` column is a numeric variable from 0 to 23, and `month` column is a factor variable.

<table class=" lightable-minimal table table-striped table-hover table-condensed table-responsive" style='font-family: "Trebuchet MS", verdana, sans-serif; margin-left: auto; margin-right: auto; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;"> time </th>
   <th style="text-align:right;"> day </th>
   <th style="text-align:left;"> month </th>
   <th style="text-align:right;"> date </th>
   <th style="text-align:right;"> hour </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Thu Jun 18 07:35:01 PDT 2009 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> Jun </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sun May 10 00:31:52 PDT 2009 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> May </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sun May 31 09:15:19 PDT 2009 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> May </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Fri May 22 07:25:52 PDT 2009 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> May </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sun May 31 02:09:52 PDT 2009 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> May </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sun Jun 07 09:13:08 PDT 2009 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> Jun </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
</tbody>
</table>

Calculate and print the frequencies for each new column (day, month, date, and hour). 

**Task 1.3.** Recode the outcome variable (`sentiment`) into a binary variable such that Positive is equal to 1 and Negative is equal to 0. Calculate and print the frequencies for tweets with positive and negative sentiments.

**Task 1.4** Load the `reticulate` package and Python libraries (`torch`, `numpy`, `transformers`, `nltk`, and `tokenizers`). Then, load the `text` package. Using these packages, generate tweet embeddings for each tweet in this dataset using the `roberta-base` model, a pre-trained NLP model. Tweet embeddings for each tweet should be a vector of numbers with length 768. Append these embeddings to the original data. 

**Task 1.5** Remove the two columns `time` and `tweet` from the dataset as you do not need them anymore.

**Task 1.6** Prepare a recipe using the `recipe()` and `prep()` functions from the `recipes` package for final transformation of the variables in this dataset. 

First, make sure you have the most recent developer version of the `recipes` package from Github. If not, install it from Github.


```{.r .fold-show}
devtools::install_github("tidymodels/recipes")
```

Your recipe should have the following specifications:

- each cyclic variable (`day`, `date`, and `hour`) is recoded into two new variables of sin and cos terms (`?step_harmonic()`). 
- `month` variable is recoded into dummy variables using one-hot encoding (`?step_dummy`)
- all numerical embeddings (Dim1 - Dim768) are standardized (`?step_normalize`)

Print the blueprint. Your blueprint should look like the following.


```
Recipe

Inputs:

      role #variables
   outcome          1
 predictor        772

Training data contained 1500 data points and no missing data.

Operations:

Dummy variables from month [trained]
Harmonic numeric variables for <none> [trained]
Harmonic numeric variables for <none> [trained]
Harmonic numeric variables for <none> [trained]
Centering and scaling for Dim1, Dim2, Dim3, Dim4, Dim5, Dim6, Dim7, Dim8,... [trained]
```

**Task 1.7** Finally, apply this recipe to the whole dataset and obtain the final version of the dataset with transformed variables. The final dataset should have 1500 rows and 781 columns as the following:

- one column representing the outcome variable, `sentiment`,
- one column representing the original `day` variable,
- one column representing the original `date` variable,
- one column representing the original `hour` variable,
- 768 columns for tweet embeddings,
- three columns for dummy variables representing the variable `month`,
- two columns for the sin and cos terms representing the variable `day`,
- two columns for the sin and cos terms representing the variable `date`,  
- two columns for the sin and cos terms representing the variable `hour`.

**Task 1.8** Remove the original `day`,`date`, and `hour` variables from the dataset as we do not need them anymore because we already created sin and cos terms for each one of them.

**Task 1.9** Export the final dataset (1500 x 778) as a .csv file and upload it to Canvas along your submission.









## Part 2: Preprocessing Continuous and Categorical Variables

