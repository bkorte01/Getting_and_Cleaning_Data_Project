# Getting_and_Cleaning_Data_Project

## Project description:
The purpose of this project was to practice collecting and working with a data set to produce a tidy data set that can be used in later analysis. The data that was used was collected from accelerometers from the Samsung Galaxy S smartphone and is included in the Codebook. 

## Reading the table in R
```{r}
data <- read.table(file_path, header = TRUE)
view(data)
```
## Description of scripts
run_analysis.R = Step by step code from importing, reading, cleaning, and applying the data with instructions and detailed descriptions.
Codebook.Rmd = Includes raw data source, experimental design and background, data processing steps, and a data dictionary which outlines variable meanings.
