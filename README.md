#  Longitudinal Elastic Shape Analysis of Brain Subcortical Structures

figcaption {
  background-color: black;
  color: white;
  font-style: italic;
  padding: 2px;
  text-align: center;
}

## Introduction
Longitudinal neuroimaging data plays a critical role in mapping the neural developmental profile ofmajor neuropsychiatric and neurodegenerative disorders, and in characterizing normal brain development.Among all features that one can extract from the brain image data, the shape of certain region is probablyone of the most interesting and useful ones.  However, longitudinal analysis of shapes is still at itsinfancy given the challenges of shape extraction, representation and modeling. This paper presents anend to end solution for analyzing longitudinal subcortical shapes extracted from human brain images.From the raw image data, subcortial regions are segmented, extracted and represented as parameterized3D surfaces.  We then develop a longitudinal elastic shape analysis (LESA) framework to accuratelydelineate the developmental trajectories of subcortical shapes. LESA integrates ideas from an elastic shaperepresentation for analyzing static surfaces, a principal component analysis (PCA) model for dimensionalreduction of shapes, and efficient statistical models for handling sparse longitudinal data, all into a singleframework. The key novelties of LESA include that: (i) it can efficiently capture complex subcorticalstructures using small number of basis, and (ii) it can accurately predict spatiotemporal changes incortical shapes using statistical models.  We adopt LESA to analyze three longitudinal datasets forbabies, young adults and older adults and show the applications of LESA on inferring the continuousdevelopment trajectory for any subcrotical region for any individual, building life-span growth trajectoriesfor subcortical regions, and comparing shape difference between healthy controls and degenerated brains

## Data

In this research, we include ADNI 2 and ADNI GO dataset. We mainly focus on ventricle and left hippocampus surfaces.

<figure>
  <img src="./Figures/Picture1.jpg" width="250" alt="Age-scan distribution" title="Age-scan distribution">
  <figcaption>Age-scan distribution</figcaption>
</figure> 
<figure>
  <img src="./Figures/hipp_AD_mean.gif" width="250" alt="hipp_AD_mean" title="hipp_AD_mean">
  <figcaption>Mean hippocampus surface with AD</figcaption>
</figure>

