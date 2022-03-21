# EcoWellBeingUS

This repository is a report of changes in economic well-being within the United States between 2018-2021. The dataset used for this paper is the 2021 and 2018 rounds of the United States General Social Survey. The primary focuses of the paper was to determine levels of financial satisfaction, income equality, and opinions on standard of living.

It is organised as follows:

`/scripts/` contains the `R` script used to prepare the data for use within the paper.

`/outputs/paper` contains the Rmarkdown file where the paper is written, as well as the knitted output `paper.pdf`. References are contained within `references.bib` in BibTEX format.


## Reproducing the report
To reproduce this report you must download the individual year GSS datasets of 2021 and 2018 in `.dta` format from [the web portal](https://gss.norc.org/get-the-data/stata) and save the data within the `inputs/data` folder, with the 2021 data file in a subfolder named `2021_stata`. Then, run `scripts/01-data_prep.R` and knit the report `outputs/paper/paper.Rmd` as `pdf_document2`.
