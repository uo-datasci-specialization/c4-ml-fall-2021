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
<script src="{{< blogdown/postref >}}index_files/kePrint/kePrint.js"></script>
<link href="{{< blogdown/postref >}}index_files/lightable/lightable.css" rel="stylesheet" />
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

### Description

For this part of the assignment, you will work with a Twitter dataset which is randomly sampled from a larger dataset on the Kaggle platform [(see this link for the original data)](https://www.kaggle.com/matyasmacudzinski/sentiment-analysis-using-bert/data). In this subset data, there are 1,500 tweets and three variables.

- **sentiment**: a character string variable with two values (Positive and Negative) for the outcome variable to predict. 
- **time**: a character string variable indicating time of a tweet (e.g.,Thu Jun 18 07:35:01 PDT 2009)
- **tweet**: a character string variable that provides the full text of a tweet.

Our ultimate goal is to build a model to predict whether or not a tweet has a positive sentiment by using the information from time of the tweet and text of the tweet. We will do this in the following assignments. For this assignment, we will only engineer features to use them later for building our models and prepare the dataset for model development. 

Please complete the following tasks. Provide the R code you wrote and any associated output for each task.

### Tasks

**Task 1.1** Import the tweet data from [this link](https://raw.githubusercontent.com/uo-datasci-specialization/c4-ml-fall-2021/main/data/tweet_sub.csv).

**Task 1.2** The `time` variable in this dataset is a character string such as *Thu Jun 18 07:35:01 PDT 2009*. Create four new columns in the dataset using this time variable to show the day, date, month, and hour of a tweet. The table below provides some examples of how these four new columns would look like given time as a character string. Make sure that `day` column is a numeric variable from 1 to 7 (Monday = 1, Sunday =7), `date` column is a numeric variable from 1 to 31, and `hour` column is a numeric variable from 0 to 23, and `month` column is a factor variable. Calculate and print the frequencies for each new column (day, month, date, and hour). 


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


```{.r .fold-show}
# Hint: suppose x is a vector of strings in format like 'Sun May 10 00:31:52 PDT 2009'

x <- c("Thu Jun 18 07:35:01 PDT 2009",
       "Sun May 10 00:31:52 PDT 2009",
       "Sun May 31 09:15:19 PDT 2009", 
       "Fri May 22 07:25:52 PDT 2009")

x
```

```
[1] "Thu Jun 18 07:35:01 PDT 2009" "Sun May 10 00:31:52 PDT 2009"
[3] "Sun May 31 09:15:19 PDT 2009" "Fri May 22 07:25:52 PDT 2009"
```

```{.r .fold-show}
# You can extract the days by subsetting from character 1 to 3

substr(x,1,3)
```

```
[1] "Thu" "Sun" "Sun" "Fri"
```

```{.r .fold-show}
# You can extract the months by subsetting from character 5 to 7

substr(x,5,7)
```

```
[1] "Jun" "May" "May" "May"
```

```{.r .fold-show}
# You can extract the dates by subsetting from character 9 to 10

substr(x,9,10)
```

```
[1] "18" "10" "31" "22"
```

```{.r .fold-show}
# You can extract the hours by subsetting from character 12 to 13

substr(x,12,13)
```

```
[1] "07" "00" "09" "07"
```

**Task 1.3** Recode the outcome variable (`sentiment`) into a binary variable such that Positive is equal to 1 and Negative is equal to 0. Calculate and print the frequencies for tweets with positive and negative sentiments.

**Task 1.4** Load the `reticulate` package and Python libraries (`torch`, `numpy`, `transformers`, `nltk`, and `tokenizers`). Then, load the `text` package. Using these packages, generate tweet embeddings for each tweet in this dataset using the last layer (layer = 12) from the `roberta-base` model, a pre-trained NLP model. Tweet embeddings for each tweet should be a vector of numbers with length 768. Append these embeddings to the original data. 

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

### Description

For the second part of the assignment, we are going to use a dataset compiled by Dr. Daniel Anderson. These specific data are **simulated** from an actual statewide testing administration across the state of Oregon, but the overall distributions are highly similar. The dataset has 189,426 observations and 29 variables. Below is a table of data dictionary for the variables in this dataset.

<table class=" lightable-minimal table table-striped table-hover table-condensed table-responsive" style='font-family: "Trebuchet MS", verdana, sans-serif; margin-left: auto; margin-right: auto; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:right;"> Variable </th>
   <th style="text-align:left;"> name </th>
   <th style="text-align:left;"> description </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> id </td>
   <td style="text-align:left;"> Student identifier </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> sex </td>
   <td style="text-align:left;"> Code indicating the biological sex of the student (F = Female; M = Male) </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> ethnic_cd </td>
   <td style="text-align:left;"> Code representing the racial/ethnic reporting subgroup category for the student
     A = Asian race, non-Hispanic
     B = Black/African American race, non-Hispanic
     H = Hispanic ethnicity
      I = American Indian/Alaskan Native race, non-Hispanic
     M = Multi-racial, non-Hispanic
     P = Pacific Islander race, non-Hispanic
     W = White race, non-Hispanic </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> enrl_grd </td>
   <td style="text-align:left;"> Code indicating the enrolled grade level of the student; or a grade level assigned to an ungraded student based on student age. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> tst_bnch </td>
   <td style="text-align:left;"> Code indicating the benchmark level of the administered test
     1B = Benchmark 1 (grade 3)
     2B = Benchmark 2 (grade 5)
     3B = Benchmark 3 (grade 8)
     G4 = Grade 4 benchmark
     G6 = Grade 6 benchmark
     G7 = Grade 7 benchmark
     X3 = Extended Grade 3
     X4 = Extended Grade 4
     X5 = Extended Grade 5
     X6 = Extended Grade 6
     X7 = Extended Grade 7
     X8 = Extended Grade 8 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> tst_dt </td>
   <td style="text-align:left;"> Date the test was taken (mm/dd/yyyy) </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> migrant_ed_fg </td>
   <td style="text-align:left;"> Indicates student participation in a program designed to assure that migratory children receive full and appropriate opportunity to meet the state academic content and student academic achievement standards. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> ind_ed_fg </td>
   <td style="text-align:left;"> Indicates student participation in a program designed to meet the unique educational and culturally related academic needs of American Indians. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> sp_ed_fg </td>
   <td style="text-align:left;"> Indicates student participation in an Individualized Education Plan (IEP/IFSP). </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> tag_ed_fg </td>
   <td style="text-align:left;"> Indicates student participation in a Talented and Gifted program. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> econ_dsvntg </td>
   <td style="text-align:left;"> Indicates student eligibility for a Free or Reduced Lunch program. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> ayp_lep </td>
   <td style="text-align:left;"> Indicates a student who received services or was eligible to receive services in a Limited English Proficient program.
     Blank = Not eligible or served by an LEP program
     A = First year LEP student without ELPA
     B = First year LEP student with ELPA
     E = Experienced LEP student (more than 5 years)
     F = Former LEP (student exited LEP program more than two years ago)   --- new in 2016-17
     M = Monitored Year 1 (student exited LEP program in the prior year)   --- new in 2016-17
     N = Not eligible or served by an LEP program
     S = Monitored Year 2 (student exited LEP program two years ago)   --- new in 2016-17
     T = Transitioning (student exited LEP program in the prior year or two years ago)   --- discontinued in 2016-17
     W = Student exited an LEP program on or before May 1 of the current year
     X = Student exited an LEP program after May 1 of the current year
     Y = Student in LEP program between 2 and 5 years </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:left;"> stay_in_dist </td>
   <td style="text-align:left;"> Indicates that the student has been enrolled for more than 50% of the days in the school year as of the first school day in May at the district where the student is resident on the first school day in May. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:left;"> stay_in_schl </td>
   <td style="text-align:left;"> Indicates that the student has been enrolled for more than 50% of the days in the school year as of the first school day in May at the school where the student is resident on the first school day in May. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:left;"> dist_sped </td>
   <td style="text-align:left;"> Indicates that the student was enrolled in a district special education program during the school year and received general education classroom instruction for less than 40% of the time as of the first school day in May. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:left;"> trgt_assist_fg </td>
   <td style="text-align:left;"> Flag indicating the record is included in Title 1 Targeted Assistance for the Adequate Yearly Progress (AYP) school performance calculations. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:left;"> ayp_dist_partic </td>
   <td style="text-align:left;"> Flag indicating the record is included in the denominator of Adequate Yearly Progress (AYP) district participation calculations. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:left;"> ayp_schl_partic </td>
   <td style="text-align:left;"> Flag indicating the record is included in the denominator of Adequate Yearly Progress (AYP) school participation calculations. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> ayp_dist_prfrm </td>
   <td style="text-align:left;"> Flag indicating the record is included in the denominator of Adequate Yearly Progress (AYP) district performance calculations. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:left;"> ayp_schl_prfrm </td>
   <td style="text-align:left;"> Flag indicating the record is included in the denominator of Adequate Yearly Progress (AYP) school performance calculations. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:left;"> rc_dist_partic </td>
   <td style="text-align:left;"> Flag indicating the record is included in the denominator of Report Card (RC) district participation calculations. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:left;"> rc_schl_partic </td>
   <td style="text-align:left;"> Flag indicating the record is included in the denominator of Report Card (RC) school participation calculations. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:left;"> rc_dist_prfrm </td>
   <td style="text-align:left;"> Flag indicating the record is included in the denominator of Report Card (RC) district performance calculations. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> rc_schl_prfrm </td>
   <td style="text-align:left;"> Flag indicating the record is included in the denominator of Report Card (RC) school participation calculations. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:left;"> grp_rpt_dist_partic </td>
   <td style="text-align:left;"> Flag indicating the record is included in the denominator of Group Report district participation calculations. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:left;"> grp_rpt_schl_partic </td>
   <td style="text-align:left;"> Flag indicating the record is included in the denominator of Group Report school participation calculations. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:left;"> grp_rpt_dist_prfrm </td>
   <td style="text-align:left;"> Flag indicating the record is included in the denominator of Group Report district performance calculations. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:left;"> grp_rpt_schl_prfrm </td>
   <td style="text-align:left;"> Flag indicating the record is included in the denominator of Group Report school participation calculations. </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:left;"> score </td>
   <td style="text-align:left;"> Scale Score for Total test </td>
  </tr>
</tbody>
</table>

### Tasks

**Task 2.1** Import the Oregon testing data from [this link](https://raw.githubusercontent.com/uo-datasci-specialization/c4-ml-fall-2021/main/data/oregon.csv).

**Task 2.2** The `tst_dt` variable is a character string such as *5/14/2018 0:00*. Create two new columns in the dataset using this variable to show the date and month the test was taken. The table below provides some examples of how these two new columns would look like given `tsd_dt` as a character string. Make sure that both `date` and `month` columns are a numeric variables. Once you create these two new columns, remove the colun `tst_dt` from the dataset as you do not it anymore. Calculate and print the frequencies for the new columns (`date` and `month`)

<table class=" lightable-minimal table table-striped table-hover table-condensed table-responsive" style='font-family: "Trebuchet MS", verdana, sans-serif; margin-left: auto; margin-right: auto; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;"> tst_dt </th>
   <th style="text-align:right;"> month </th>
   <th style="text-align:right;"> date </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 5/14/2018 0:00 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 14 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6/5/2018 0:00 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5/1/2018 0:00 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5/1/2018 0:00 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5/22/2018 0:00 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5/25/2018 0:00 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 25 </td>
  </tr>
</tbody>
</table>



```{.r .fold-show}
# Hint: suppose x is a vector of strings in format of MM/DD/YYYY H:MM

x <- c("5/14/2018 0:00","6/5/2018 0:00","5/1/2018 0:00","5/1/2018 0:00","5/22/2018 0:00","5/25/2018 0:00")

x
```

```
[1] "5/14/2018 0:00" "6/5/2018 0:00"  "5/1/2018 0:00"  "5/1/2018 0:00" 
[5] "5/22/2018 0:00" "5/25/2018 0:00"
```

```{.r .fold-show}
# You can extract the date and month using the following code

strsplit(x,'/') # returns a list of vectors with each element of x splitted by /
```

```
[[1]]
[1] "5"         "14"        "2018 0:00"

[[2]]
[1] "6"         "5"         "2018 0:00"

[[3]]
[1] "5"         "1"         "2018 0:00"

[[4]]
[1] "5"         "1"         "2018 0:00"

[[5]]
[1] "5"         "22"        "2018 0:00"

[[6]]
[1] "5"         "25"        "2018 0:00"
```

```{.r .fold-show}
sapply(strsplit(x,'/'),`[`,1) # calls the first element of each list element
```

```
[1] "5" "6" "5" "5" "5" "5"
```

```{.r .fold-show}
as.numeric(sapply(strsplit(x,'/'),`[`,1)) # makes them numeric
```

```
[1] 5 6 5 5 5 5
```

```{.r .fold-show}
as.numeric(sapply(strsplit(x,'/'),`[`,2)) # calls the second element of each list element
```

```
[1] 14  5  1  1 22 25
```

**Task 2.3** Using the `ff_glimpse()` function from the `finalfit` package, provide a snapshot of missingness in this dataset. This function also returns the number of levels for categorical variables. If there is any variable with large amount of missingness (e.g. more than 75%), remove this variable from the dataset.

**Task 2.4** Most of the variables in this dataset are categorical, and particularly a binary variable with a Yes and No response. Check the frequency of unique values for all categorical variables. If there is any inconsistency (e.g., Yes is coded as both 'y' and 'Y') for any of these variables in terms of how values are coded, fix them. Also, check the distribution of numeric variables and make sure there is no anomaly.

**Task 2.5** Prepare a recipe using the `recipe()` and `prep()` functions from the `recipes` package for final transformation of the variables in this dataset. 

Suppose that we categorize the variables in this datasets as the following:

- `id` is the ID variable
- `score` is the outcome variable
- `enrl_grd` is a numeric predictor
- `date` and `month` are cyclic predictors
- `sex`,`ethnic_cd`,`tst_bnch`,`migrant_ed_fg`,`ind_ed_fg`,`sp_ed_fg`,`tag_ed_fg`,`econ_dsvntg`,`stay_in_dist`,`stay_in_schl`,`dist_sped`,`trgt_assist_fg`,`ayp_dist_partic`,`ayp_schl_partic`,`ayp_dist_prfrm`,`ayp_schl_prfrm`,`rc_dist_partic`,`rc_schl_partic`,`rc_dist_prfrm`,`rc_schl_prfrm`,`grp_rpt_dist_partic`,`grp_rpt_schl_partic`,`grp_rpt_dist_prfrm`,`grp_rpt_schl_prfrm` are all categorical predictors.

Your recipe should have the following specifications in the order below:

- create an indicator variable for missingness for all predictors,
- remove the numeric predictors with zero variance,
- replace missing values with mean for numeric predictors,
- replace missing values with mode for categorical predictors,
- recode cyclic predictors into two new variables of sin and cos terms,
- expand numeric predictors using using natural splines with three degrees of freedom and standardize,
- recode categorical predictors into dummy variables using one-hot encoding.

Print the blueprint. Your blueprint should look like the following.


```
Recipe

Inputs:

      role #variables
        id          1
   outcome          1
 predictor         27

Training data contained 189426 data points and 538 incomplete rows. 

Operations:

Creating missing data variable indicators for sex, ethnic_cd, tst_bnch, migrant_ed_fg, ind_ed... [trained]
Zero variance filter removed na_ind_sex, na_ind_ethnic_cd, na_ind_ts... [trained]
Mean Imputation for enrl_grd, month, date [trained]
Mode Imputation for sex, ethnic_cd, tst_bnch, migrant_ed_fg, ind_ed... [trained]
Harmonic numeric variables for <none> [trained]
Harmonic numeric variables for <none> [trained]
Natural Splines on enrl_grd [trained]
Centering and scaling for enrl_grd_ns_1, enrl_grd_ns_2, enrl_grd_ns_3 [trained]
Dummy variables from sex, ethnic_cd, tst_bnch, migrant_ed_fg, ind_ed_fg, sp_ed... [trained]
```

**Task 2.6** Finally, apply this recipe to the whole dataset and obtain the final version of the dataset with transformed variables. The final dataset should have 189,426 rows and 76 columns as the following:

- one column representing the ID variable, `id`,
- one column representing the outcome variable, `score`,
- one column representing the original `date` variable,
- one column representing the original `month` variable,
- eight columns representing missing indicator variables,
- two columns for the sin and cos terms representing the variable `date`,  
- two columns for the sin and cos terms representing the variable `month`,
- three columns for natural splines of `enrl_grd_ns`,
- two columns for dummy variables representing `sex`,
- seven columns for dummy variables representing `ethnic_cd_W`,
- six columns for dummy variables representing `tst_bnch`,
- two columns for dummy variables representing `migrant_ed_fg`,
- two columns for dummy variables representing `ind_ed_fg`,
- two columns for dummy variables representing `sp_ed_fg`,
- two columns for dummy variables representing `tag_ed_fg`,
- two columns for dummy variables representing `econ_dsvntg`,
- two columns for dummy variables representing `stay_in_dist_N`,
- two columns for dummy variables representing `stay_in_schl`,
- two columns for dummy variables representing `dist_sped`,
- two columns for dummy variables representing `trgt_assist_fg`,
- two columns for dummy variables representing `ayp_dist_partic`,
- two columns for dummy variables representing `ayp_schl_partic`,
- two columns for dummy variables representing `ayp_dist_prfrm`,
- two columns for dummy variables representing `ayp_schl_prfrm`
- two columns for dummy variables representing `rc_dist_partic`,
- two columns for dummy variables representing `rc_schl_partic`,
- two columns for dummy variables representing `rc_dist_prfrm`,
- two columns for dummy variables representing `rc_schl_prfrm`,
- two columns for dummy variables representing `grp_rpt_dist_partic`,
- two columns for dummy variables representing `grp_rpt_schl_partic`,
- two columns for dummy variables representing `grp_rpt_dist_prfrm`,
- two columns for dummy variables representing `grp_rpt_schl_prfrm`,

**Task 2.7** Remove the original `date` and `month` variables from the dataset as we do not need them anymore because we already created sin and cos terms for each one of them.

**Task 2.8** Export the final dataset (189,426 x 74) as a .csv file and upload it to Canvas along your submission.








