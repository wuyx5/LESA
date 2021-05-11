#  Longitudinal Elastic Shape Analysis of Brain Subcortical Structures

## Introduction
Longitudinal neuroimaging data plays a critical role in mapping the neural developmental profile ofmajor neuropsychiatric and neurodegenerative disorders, and in characterizing normal brain development.Among all features that one can extract from the brain image data, the shape of certain region is probablyone of the most interesting and useful ones.  However, longitudinal analysis of shapes is still at itsinfancy given the challenges of shape extraction, representation and modeling. This paper presents anend to end solution for analyzing longitudinal subcortical shapes extracted from human brain images.From the raw image data, subcortial regions are segmented, extracted and represented as parameterized3D surfaces.  We then develop a longitudinal elastic shape analysis (LESA) framework to accuratelydelineate the developmental trajectories of subcortical shapes. LESA integrates ideas from an elastic shaperepresentation for analyzing static surfaces, a principal component analysis (PCA) model for dimensionalreduction of shapes, and efficient statistical models for handling sparse longitudinal data, all into a singleframework. The key novelties of LESA include that: (i) it can efficiently capture complex subcorticalstructures using small number of basis, and (ii) it can accurately predict spatiotemporal changes incortical shapes using statistical models.  We adopt LESA to analyze three longitudinal datasets forbabies, young adults and older adults and show the applications of LESA on inferring the continuousdevelopment trajectory for any subcrotical region for any individual, building life-span growth trajectoriesfor subcortical regions, and comparing shape difference between healthy controls and degenerated brains

## Data

In this research, we include ADNI 2 and ADNI GO dataset. We mainly focus on ventricle and left hippocampus surfaces.

<figure>
  <img src="./Figures/age-scan_distribution.png" width="400" alt="Age-scan distribution" title="Age-scan distribution">
  <figcaption>Age-scan distribution</figcaption>
</figure> 

<img src="./Figures/hist_scan_times.png" width="300" alt="hist_scan_times" title="hist_scan_times"> <img src="./Figures/hist_scan_ages.png" width="300" alt="hist_scan_ages" title="hist_scan_ages">

## Elastic Shape Analysis

First, we compute the global mean for ventricle surfaces and left hippocampus surfaces.

<img src="./Figures/ventricle_mean.png" width="300" alt="Ventricle mean surface" title="Ventricle mean"> <img src="./Figures/hippocampus_mean.png" width="300" alt="Hippocampus mean surface" title="Hippocampus mean">

Then, with global mean surfaces and aligned individual surfaces, we run PCA. For ventricle surfaces, 33 principal components can explain over 95% shape variabilities. Meanwhile, left hippocampus surfaces need 61 principal components to explain over 95% shape variabilities.

1) Ventricle\
<img src="./Figures/ventricle_variability_explained.png" width="300" alt="Ventricle_variability_explained" title="Ventricle_variability_explained"> <img src="./Figures/ventricle_1st_sparse.png" width="300" alt="ventricle_1st_sparse" title="ventricle_1st_sparse"> <img src="./Figures/ventricle_2nd_sparse.png" width="300" alt="ventricle_2nd_sparse" title="ventricle_2nd_sparse">

2) Left hippocampus\
<img src="./Figures/hippocampus_variability_explained.png" width="300" alt="Hippocampus_variability_explained" title="Hippocampus_variability_explained"> <img src="./Figures/hippocampus_1st_sparse.png" width="300" alt="hippocampus_1st_sparse" title="ventricle_1st_sparse"> <img src="./Figures/ventricle_2nd_sparse.png" width="300" alt="hippocampus_2nd_sparse" title="hippocampus_2nd_sparse">

## Densely Fitting
We densely fit area trajectories and principal coefficients trajectories with two methods: PACE and MGCV, and we compare the performance under two methods.
1) Ventricle area trajectories:\
   <img src="./Figures/ventricle_area_sparse.png" width="250" alt="ventricle_area_sparse" title="ventricle_area_sparse"> <img src="./Figures/ventricle_area_PACE.png" width="250" alt="ventricle_area_PACE" title="ventricle_area_PACE"> <img src="./Figures/ventricle_area_MGCV.png" width="250" alt="ventricle_area_MGCV" title="ventricle_area_MGCV">

2) Left hippocampus area trajectories:\
   <img src="./Figures/hippocampus_area_sparse.png" width="250" alt="hippocampus_area_sparse" title="hippocampus_area_sparse"> <img src="./Figures/hippocampus_area_PACE.png" width="250" alt="hippocampus_area_PACE" title="hippocampus_area_PACE"> <img src="./Figures/hippocampus_area_MGCV.png" width="250" alt="hippocampus_area_MGCV" title="hippocampus_area_MGCV">

3) Ventricle principal coefficients trajectories:\
   <img src="./Figures/ventricle_1st_sparse.png" width="250" alt="ventricle_1st_sparse" title="ventricle_1st_sparse"> <img src="./Figures/ventricle_1st_PACE.png" width="250" alt="ventricle_1st_PACE" title="ventricle_1st_PACE"> <img src="./Figures/ventricle_1st_MGCV.png" width="250" alt="ventricle_1st_MGCV" title="ventricle_1st_MGCV">
   <img src="./Figures/ventricle_2nd_sparse.png" width="250" alt="ventricle_2nd_sparse" title="ventricle_2nd_sparse"> <img src="./Figures/ventricle_2nd_PACE.png" width="250" alt="ventricle_2nd_PACE" title="ventricle_2nd_PACE"> <img src="./Figures/ventricle_2nd_MGCV.png" width="250" alt="ventricle_2nd_MGCV" title="ventricle_2nd_MGCV">
   
   
## Results
1) Global ventricle surface trajectories:\
   <img src="./Figures/PACE_mean_trajectory.gif" width="300" alt="ventricle_PACE_mean_trajectory" title="ventricle_PACE_mean_trajectory"> <img src="./Figures/MGCV_mean_trajectory.gif" width="300" alt="ventricle_MGCV_mean_trajectory" title="ventricle_MGCV_mean_trajectory">
2) Global left hippocampus surface trajectories:\
   <img src="./Figures/hipp_PACE_mean_trajectory.gif" width="300" alt="hipp_PACE_mean_trajectory" title="hipp_PACE_mean_trajectory"> <img src="./Figures/hipp_MGCV_mean_trajectory.gif" width="300" alt="hipp_MGCV_mean_trajectory" title="hipp_MGCV_mean_trajectory">
3) AD, MCI and NL ventricle surface trajectories:\
   <img src="./Figures/AD_mean.gif" width="250" alt="ventricle_AD_mean_trajectory" title="ventricle_AD_mean_trajectory"> <img src="./Figures/MCI_mean.gif" width="250" alt="ventricle_MCI_mean_trajectory" title="ventricle_MCI_mean_trajectory"> <img src="./Figures/NL_mean.gif" width="250" alt="ventricle_NL_mean_trajectory" title="ventricle_NL_mean_trajectory">
4) AD, MCI and NL left hippocampus surface trajectories:\
   <img src="./Figures/hipp_AD_mean.gif" width="250" alt="hippocampus_AD_mean_trajectory" title="hippocampus_AD_mean_trajectory"> <img src="./Figures/hipp_MCI_mean.gif" width="250" alt="hippocampus_MCI_mean_trajectory" title="hippocampus_MCI_mean_trajectory"> <img src="./Figures/hipp_NL_mean.gif" width="250" alt="hippocampus_NL_mean_trajectory" title="hippocampus_NL_mean_trajectory">
