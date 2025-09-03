<<<<<<< HEAD
# Monte Carlo Method for Calculating the Probability of Monoclonality of Cell Lines

## Plot Generation Script for Article

**Authors:** S. S. Timonovaa, *, V. I. Pavelko, I. A. Kirica, V. N. Badea, A. A. Piskunova, and R. A. Khamitova

## Overview

This repository contains the R script for generating figures used in the article "Monte Carlo Method for Calculating the Probability of Monoclonality of Cell Lines". The script implements a Monte Carlo simulation to calculate the probability of monoclonality by generating N colonies with centers at (x,y) coordinates and radius r.

The radius distribution of colonies is determined from ClonePix FL statistics. The simulation generates N colonies and tests each colony against all others for overlap. The diagonal elements (self-overlapping) are excluded from the analysis. The sum of the overlap matrix represents the number of overlapped colonies, which when normalized by the total number of colonies gives the probability of monoclonality.

## Generated Figures

Fig. 2. Calculation of the probability of monoclonality of cell lines.
(a) Histogram of radius values of grown colonies;
(b) selection of distribution according to the Cullen and Frey plot;
(c) comparison of the selected distribution and real values of colony radii;
(d) an example of a well with simulated colonies.

## Usage

Run the main script to generate all figures:

```r
Rscript "immulation of colonies.R"
```

The script will generate four figures (Fig2A.png, Fig2B.png, Fig2C.png, Fig2D.png) in the `results/` folder.

## Data

The script uses ClonePix data from `data/clonepix_data.xlsx` containing colony measurements and statistics.
=======
# calculating-probability-of-circle-overlapping-by-Monte-Carlo-simulation
#
#To calculate probability of monoclonality we generate N colonies with center in (x,y) and raduis r. 
Radius of colonies has a distribution determined from ClonePix FL statistics.
Generate N colonies and each of them with each of rest. In diagonal line false poitive overlapping needs to be discounted.
Sum of matrix equal the number of overlaped colonies. Normed on number colonies is a  probability.
>>>>>>> refs/remotes/origin/master
