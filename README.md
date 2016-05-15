### Getting and Cleaning Data Project Readme

Fendy Huang

### Introduction

This is the course project for the Getting and Cleaning Data course.
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

### R script

The R script, run_analysis.R, does the following:

## Step1: Load data
Load required packages
Read file into data frames including subject, x, y, activity_labels files
Add column names for SubjectID and Activity
Combine data into one dataset

## Step2: Extract only the measures on Mean and std for each measures
Find the columns has Mean() or Std()
Remove unwanted columns

## Step3: Use descriptive activity names to names the activities in the dataset
Convert the activity from integer to factor using the information from the activity_label.txt

## Step4: Label dataset with descriptive variables names
search and Replace abbreviation to be more decrypted text

## Step5: Create tidy dataset with Average of each variable for each activity and subject
Create dataset and write to today.txt file


### The end result is shown in the file tidy.txt.