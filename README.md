#  LESA: Longitudinal Elastic Shape Analysis of Brain Subcortical Structures

## Introduction

<div align="justify"> Longitudinal neuroimaging plays a critical role in mapping the neural developmental profile of the brain. Among all features in a brain image, shapes of the subcortical regions are probably among the most interesting and useful ones since they characterize these vital structures in the brain. However, statistical analysis of longitudinal subcortical shapes is still in its infancy due to challenges in shape extraction, representation, and modeling. This paper develops a simple and efficient framework for longitudinal elastic shape analysis (LESA) of subcortical shapes. In LESA, subcortical regions are segmented, extracted, and represented as parameterized 3D surfaces. Integrating ideas from elastic shape analysis of static surfaces, principal component analysis (PCA) of shapes, and statistical modeling of sparse longitudinal data, LESA provides a fundamental toolbox for systematically studying sparse longitudinal surface shapes. The key novelties of LESA include: (i) it can efficiently capture complex subcortical structures using a small basis, and (ii) it can accurately predict spatiotemporal changes using simple statistical models. We applied LESA to analyze three longitudinal datasets and showcase its applications in estimating continuous surface trajectories, building life-span growth patterns, and comparing shape differences among different groups.</div>

## Pipeline

<img src="./Figures/Pipeline plot.png" width="1000" alt="pipeline" title="Pipeline">

## Data

We have applied LESA to study three different longitudinal brain imaging datasets: the Alzheimer’s Disease Neuroimaging Initiative (ADNI) dataset, the Human Connectome Project test-retest dataset and the OpenPain dataset. For simplicity, we mainly focus on the lateral ventricle and left hippocampus surfaces.
  
<img src="./Figures/Dataset_summary_0823-1.png" width="600" alt="dataset summary" title="dataset summary"><br/>
  *Panel (a) shows age distributions in the three datasets. The rest panels show the temporal information on scans for each subject.*


## PCA results

Then, with global mean surfaces and aligned individual surfaces, we run PCA. For ventricle surfaces, 33 principal components can explain over 95% shape variabilities. Meanwhile, left hippocampus surfaces need 61 principal components to explain over 95% shape variabilities.

1) **Ventricle**\
   <img src="./Figures/ADNI_LV_PC1_narrow.png" width="600" alt="Ventricle_PCA_result" title="Ventricle_PCA_result"> <br/>
  *PCA results of the ADNI’s lateral ventricle surfaces. (a) Karcher mean of all LV surfaces. (b) Cumulative percentage of variance explained by the number of PCs. (c) First dominant PC direction reconstructed as f_{\mu}&plus;t\sqrt{\lambda_{1}}PC_{1}
  <a href="https://www.codecogs.com/eqnedit.php?latex=f_{\mu}&plus;t\sqrt{\lambda_{1}}PC_{1}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?f_{\mu}&plus;t\sqrt{\lambda_{1}}PC_{1}" title="f_{\mu}+t\sqrt{\lambda_{1}}PC_{1}" /></a>. The five shapes in the front view, from left to right, correspond to t = {−1; −0:5; 0; 0:5; 1}. (c) Surface area trajectories. (e) PC1 score trajectories.*

2) **Left hippocampus**\
   <img src="./Figures/hippocampus_variability_explained.png" width="250" alt="Hippocampus_variability_explained" title="Hippocampus_variability_explained"> <img src="./Figures/hippocampus_1st_sparse.png" width="250" alt="hippocampus_1st_sparse" title="ventricle_1st_sparse"> <img src="./Figures/ventricle_2nd_sparse.png" width="250" alt="hippocampus_2nd_sparse" title="hippocampus_2nd_sparse"> <br/>
  *(a) Cumulative variability explained* &nbsp; &nbsp; &nbsp; *(b) Sparse 1st PCs* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *(c) Sparse 2nd PCs*

## Densely Fitting

We densely fit area trajectories and principal coefficients trajectories with two methods: PACE and MGCV, and we compare the performance under two methods.
1) **Ventricle area trajectories:**\
   <img src="./Figures/ventricle_area_sparse.png" width="250" alt="ventricle_area_sparse" title="ventricle_area_sparse"> <img src="./Figures/ventricle_area_PACE.png" width="250" alt="ventricle_area_PACE" title="ventricle_area_PACE"> <img src="./Figures/ventricle_area_MGCV.png" width="250" alt="ventricle_area_MGCV" title="ventricle_area_MGCV"><br/>
  *(a) Sparse area trajectories* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *(b) PACE fitting* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *(c) MGCV fitting*
  
2) **Left hippocampus area trajectories:**\
   <img src="./Figures/hippocampus_area_sparse.png" width="250" alt="hippocampus_area_sparse" title="hippocampus_area_sparse"> <img src="./Figures/hippocampus_area_PACE.png" width="250" alt="hippocampus_area_PACE" title="hippocampus_area_PACE"> <img src="./Figures/hippocampus_area_MGCV.png" width="250" alt="hippocampus_area_MGCV" title="hippocampus_area_MGCV"><br/>
  *(a) Sparse area trajectories* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *(b) PACE fitting* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *(c) MGCV fitting*
  
3) **Ventricle principal coefficients trajectories:**\
   <img src="./Figures/ventricle_1st_sparse.png" width="250" alt="ventricle_1st_sparse" title="ventricle_1st_sparse"> <img src="./Figures/ventricle_1st_PACE.png" width="250" alt="ventricle_1st_PACE" title="ventricle_1st_PACE"> <img src="./Figures/ventricle_1st_MGCV.png" width="250" alt="ventricle_1st_MGCV" title="ventricle_1st_MGCV"><br/>
   *(a) Sparse 1st PC trajectories* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *(b) PACE fitting* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *(c) MGCV fitting*
   
   <img src="./Figures/ventricle_2nd_sparse.png" width="250" alt="ventricle_2nd_sparse" title="ventricle_2nd_sparse"> <img src="./Figures/ventricle_2nd_PACE.png" width="250" alt="ventricle_2nd_PACE" title="ventricle_2nd_PACE"> <img src="./Figures/ventricle_2nd_MGCV.png" width="250" alt="ventricle_2nd_MGCV" title="ventricle_2nd_MGCV"><br/>
   *(a) Sparse 2nd PC trajectories* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *(b) PACE fitting* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *(c) MGCV fitting*
   
4) **Left hippocampus principal coefficients trajectories:**\
   <img src="./Figures/hippocampus_1st_sparse.png" width="250" alt="hippocampus_1st_sparse" title="hippocampus_1st_sparse"> <img src="./Figures/hippocampus_1st_PACE.png" width="250" alt="hippocampus_1st_PACE" title="hippocampus_1st_PACE"> <img src="./Figures/hippocampus_1st_MGCV.png" width="250" alt="hippocampus_1st_MGCV" title="hippocampus_1st_MGCV"><br/>
   *(a) Sparse 1st PC trajectories* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *(b) PACE fitting* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *(c) MGCV fitting*
   
   <img src="./Figures/hippocampus_2nd_sparse.png" width="250" alt="hippocampus_2nd_sparse" title="hippocampus_2nd_sparse"> <img src="./Figures/hippocampus_2nd_PACE.png" width="250" alt="hippocampus_2nd_PACE" title="hippocampus_2nd_PACE"> <img src="./Figures/hippocampus_2nd_MGCV.png" width="250" alt="hippocampus_2nd_MGCV" title="hippocampus_2nd_MGCV"><br/>
   *(a) Sparse 2nd PC trajectories* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *(b) PACE fitting* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *(c) MGCV fitting*
   
5) **Some individual fitting examples:**\
   <img src="./Figures/ventricle_indexample_1.png" width="250" alt="ventricle_indexample_1" title="ventricle_indexample_1"> <img src="./Figures/ventricle_indexample_2.png" width="250" alt="ventricle_indexample_2" title="ventricle_indexample_2"> <img src="./Figures/ventricle_indexample_3.png" width="250" alt="ventricle_indexample_3" title="ventricle_indexample_3">
   <img src="./Figures/hippocampus_indexample_1.png" width="250" alt="hippocampus_indexample_1" title="hippocampus_indexample_1"> <img src="./Figures/hippocampus_indexample_2.png" width="250" alt="hippocampus_indexample_2" title="hippocampus_indexample_2"> <img src="./Figures/hippocampus_indexample_3.png" width="250" alt="hippocampus_indexample_3" title="hippocampus_indexample_3">

6) **Performance comparison:**\
    Mean squared error
    <table>
   
    |          |     PACE    |      MGCV    |     PACE    |      MGCV    |
    | -------- | ----------- | ------------ | ----------- | ------------ |
    | **Area** |   454.1950  | **266.7515** |    87.7912  |  **69.9117** |
    | **PC1**  |  **0.0898** |    0.1072    |  **0.0427** |    0.0443    |
    | **PC2**  |  **0.1122** |    0.1280    |  **0.0815** |    0.0865    |
    | **PC4**  | **0.1298**  |    0.1351    |  **0.0554** |    0.0584    |
    | **PC5**  | **0.0944**  |    0.0987    |  **0.1034** |    0.1106    |
    | **PC6**  | **0.1835**  |    0.1967    |  **0.1068** |    0.1125    | 
    | **PC7**  | **0.1728**  |    0.1800    |  **0.2110** |    0.2254    |
    | **PC8**  | **0.1453**  |    0.1443    |  **0.1337** |    0.1380    |
    | **PC9**  | **0.0591**  |    0.0591    |  **0.1475** |    0.1557    |
    | **PC10** | **0.1290**  |    0.1406    |  **0.0675** |    0.0688    |
    | **....** |    ....     |      ....    |     ....    |      ....    |
    | **Average PC MSE** | **0.1233** | 0.1301 |  **0.0943**  |  0.0984  |
  
    </table>

## Results

1) **Global ventricle surface trajectories:**\
   <img src="./Figures/PACE_mean_trajectory.gif" width="300" alt="ventricle_PACE_mean_trajectory" title="ventricle_PACE_mean_trajectory"> <img src="./Figures/MGCV_mean_trajectory.gif" width="300" alt="ventricle_MGCV_mean_trajectory" title="ventricle_MGCV_mean_trajectory">
   
2) **Global left hippocampus surface trajectories:**\
   <img src="./Figures/hipp_PACE_mean_trajectory.gif" width="300" alt="hipp_PACE_mean_trajectory" title="hipp_PACE_mean_trajectory"> <img src="./Figures/hipp_MGCV_mean_trajectory.gif" width="300" alt="hipp_MGCV_mean_trajectory" title="hipp_MGCV_mean_trajectory">
   
3) **AD, MCI and NL ventricle surface trajectories:**\
   <img src="./Figures/AD_mean.gif" width="250" alt="ventricle_AD_mean_trajectory" title="ventricle_AD_mean_trajectory"> <img src="./Figures/MCI_mean.gif" width="250" alt="ventricle_MCI_mean_trajectory" title="ventricle_MCI_mean_trajectory"> <img src="./Figures/NL_mean.gif" width="250" alt="ventricle_NL_mean_trajectory" title="ventricle_NL_mean_trajectory">
   
4) **AD, MCI and NL left hippocampus surface trajectories:**\
   <img src="./Figures/hipp_AD_mean.gif" width="250" alt="hippocampus_AD_mean_trajectory" title="hippocampus_AD_mean_trajectory"> <img src="./Figures/hipp_MCI_mean.gif" width="250" alt="hippocampus_MCI_mean_trajectory" title="hippocampus_MCI_mean_trajectory"> <img src="./Figures/hipp_NL_mean.gif" width="250" alt="hippocampus_NL_mean_trajectory" title="hippocampus_NL_mean_trajectory">

5) **AD, MCI and NL area trajectories comparison:**\
   <img src="./Figures/ventricle_area_trajectory_comparison.png" width="300" alt="ventricle_area_trajectory_comparison" title="ventricle_area_trajectory_comparison"> <img src="./Figures/ventricle_area_difference_comparison.png" width="300" alt="ventricle_area_difference_comparison" title="ventricle_area_difference_comparison">
   
   <img src="./Figures/hippocampus_area_trajectory_comparison.png" width="300" alt="hippocampus_area_trajectory_comparison" title="hippocampus_area_trajectory_comparison"> <img src="./Figures/hippocampus_area_difference_comparison.png" width="300" alt="hippocampus_area_difference_comparison" title="hippocampus_area_difference_comparison">
