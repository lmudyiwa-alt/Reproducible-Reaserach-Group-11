# Car Insurance Claims Prediction

## Authors
Jakub Tomczak, Jakub Ryłow, Mudyiwa Loveness, Reproducible Research - Group 11

## Project description
This project focuses on predicting insurance claims for vehicle insurance policies using machine learning models. It is a rewrite of an existing Python-based project into the R programming language, aiming to reproduce the full analytical and modeling workflow. The project includes data preprocessing, feature engineering, model training, and evaluation.

## Requirements
- R >= 4.3
- Python >= 3.10 (Optional - only for the original version)

## Setup
1. Clone the repository and restore the R environment:
   
git clone <repository-url>
cd <repository-name

2. Open R in the project directory and run:

install.packages("renv")
renv::restore()

## How to run
Run the project step by step using notebooks from the new_project_r/notebooks directory in recommended order:

1. Data loading and preprocessing - data_analysis.Rmd
2. Feature engineering and feature selection - feature_engineering.Rmd 
3. Model training:
- Random Forest - Random_Forest.Rmd
- XGBoost - XGBoost.Rmd
4. Model ensembling using stacking - Stacking.Rmd
5. Model evaluation and comparison - model_evaluation.Rmd

## Expected output
Trained models saved in new_project_r/outputs/
Processed datasets saved in data/
Visualizations saved in new_project_r/plots/
Performance metrics comparing models in model_evaluation.Rmd

Estimated runtime: 
?

## Data
The dataset comes from Kaggle:
Insurance Claims Dataset
https://www.kaggle.com/datasets/litvinenko630/insurance-claims

~60,000 observations
Each row represents an insurance policy
Includes vehicle features (e.g., engine power, fuel type), driver attributes, and policy details

Data is stored locally in the data/ folder - file: Insurance_claims_data.csv
it can be also downloaded manually from Kaggle before running the project

## Repository structure

data/
    Input data and intermediate datasets (cleaned, processed)

original_project_python/
    Original implementation in Python (reference version)

new_project_r/
R implementation of the project
- functions/   # reusable helper functions
- notebooks/   # main analysis pipeline (R scripts/notebooks)
- outputs/     # saved models and results
- plots/       # generated visualizations

renv.lock
    Dependency lockfile for reproducibility

.Rprofile
    R environment configuration

.Rproject
    RStudio project file

renv/
    Environment management files (ignored in git except lockfile)

