# Monte Carlo Method for Calculating the Probability of Monoclonality of Cell Lines

## Plot Generation Script for Article

**Authors:** S. S. Timonova, V. I. Pavelko, I. A. Kiric, V. N. Bade, A. A. Piskunov, and R. A. Khamitov

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

The script uses ClonePix colony data that can be provided in two formats:

1. **CSV format** (recommended): `data/clonepix_essential_data.csv` - Contains only the 5 essential columns needed for analysis (250KB)
2. **Excel format** (fallback): `data/clonepix_data.xlsx` - Full dataset with all 32 columns (1.6MB, excluded from git)

The script automatically detects which file is available and uses the appropriate loader. The CSV version contains the same data but is much smaller and faster to load.

**Essential columns used:**

- `Picked` - Whether colony was selected (True/False)
- `RadiusAverageRMS` - Average colony radius measurements
- `AxisRatio` - Colony shape measurement
- `Compactness` - Colony density measurement  
- `TotalArea` - Colony area measurement