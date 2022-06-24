%% Step 1: Data Download
% Please go to ADNI website http://adni.loni.usc.edu/ to apply and download
% T1 images with image names for subjects aged 60 to 90 in ADNI-GO and 
% ADNI2 datasets. 

%% Step 2: Segmentation
% Please use the FIRST tool inside the FMRIB Software Library (FSL)
% https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FIRST
% to segment the subcortical regions from T1 images downloaded.

%% Step 3: Spherical Parametrization
% Please download the 3D Slicer image computing platform 
% https://www.slicer.org/
% with SPHARM-PDM and ShapePopulationViewer extensions inside the
% application. Then load the FSL outputs .nii binary images 
% (here we focus on left hippocampus and lateral ventricle) and use
% "Modules -> SPHARM -> Shape Analysis Module" to generate spherical
% parametrized surfaces.

%% Step 4: Data Organization
% Please apply and download the ADNIMERGE.csv table from 
% http://adni.loni.usc.edu/;
% Load all surfaces generated as F (50*50*3*N);
% Load image names as subject_name_list, a N*1 cell, where N is the number
% of images.

currentFolder = pwd;
[sub_id,sub_scan_time,sub_scan_id,sub_times,sub_scan_age,sparseF] =...
    data_organization(subject_name_list,F);

%% Step 5: Surface Registration and Computing Karcher Mean with SRNF
% Compute area; rescale and register surfaces; compute Karcher mean
addpath(genpath([currentFolder '\Registration\']));
[sparse_area] = comp_sparse_area(sparseF,sub_times);
[muF,v] = Karcher_mean(F);
cd(currentFolder);

%% Step 6: PCA
[S,U,coef,sparse_coef]=surf_pca(v,muF,sub_times);

%% SPHARM-PDM
[S_SPDM,U_SPDM,coef_SPDM,v_SPDM,muF_SPDM]=spdm_pca(F);

%% Figure 6

[dist_elastic,dist_spdm] = repre_efficiency(U,coef,muF,v,U_SPDM,coef_SPDM,muF_SPDM,v_SPDM);
plot_repre_efficiency(dist_elastic,dist_spdm);

%% Step 7: PACE Fitting
% PACE Package: https://github.com/functionaldata/PACE_matlab
% Yao, F., Müller, H.G., Wang, J.L. (2005). Functional data analysis for sparse longitudinal data. J. American Statistical Association 100, 577-590.

addpath PACE_matlab-master/release2.17/PACE/;
[age_min,age_max,sparse_t,area_pred,area_mean_estimate,outa,coef_pred,...
    pc_mean_estimate,surf_estimate,surf_mean]=...
    pace_fitting(sub_scan_age,sparse_area,sparse_coef,38,muF,U);

%% Figure 4
% (a) Mean Surface
plot_mean(muF);
% (b) Cumulative percentage of variance
pc_num = plot_cumu_var(S);
% (c) 1st dominant PC
sliderplot_PC(muF,U,S);
% (d) Sparse area trajectories
plot_sparse_area(age_min,sparse_area,sparse_t);
% (e) Sparse PC1 trajectories
plot_sparse_PC(age_min,sparse_coef,sparse_t);

%% Figure 7
plot_PACE_area(age_min,age_max,area_pred,area_mean_estimate,outa);
plot_PACE_PC(age_min,age_max,coef_pred,pc_mean_estimate,outa);

%% Figure 8
idx = 95;
plot_individual_area(age_min,age_max,area_pred,area_mean_estimate,outa,sparse_t,sparse_area,idx);
plot_individual_PC(age_min,age_max,coef_pred,pc_mean_estimate,outa,sparse_t,sparse_coef,idx);
sliderplot_individual_ADNI(surf_estimate{idx});

idx = 6;
plot_individual_area(age_min,age_max,area_pred,area_mean_estimate,outa,sparse_t,sparse_area,idx);
plot_individual_PC(age_min,age_max,coef_pred,pc_mean_estimate,outa,sparse_t,sparse_coef,idx);
sliderplot_individual_ADNI(surf_estimate{idx});

%% Step 8: Group Camparison (Figure 10)
% Please apply and download the DXSUM_PDXCONV_ADNIALL.csv table from 
% http://adni.loni.usc.edu/;

% Group area, area changing rate, surface computation
[AD_mean,area_AD_mean,MCI_mean,area_MCI_mean,NL_mean,area_NL_mean,...
  area_AD_diff,area_MCI_diff,area_NL_diff,AD_mean_shape,MCI_mean_shape,...
  NL_mean_shape,AD_color,MCI_color,NL_color] = group_comparison(...
  sub_scan_time,sub_id,area_mean_estimate,area_pred,surf_mean,surf_estimate);


% Area trajectories and area changing rate trajectories visualization
plot_group_area(area_AD_mean,area_MCI_mean,area_NL_mean,area_AD_diff,...
                area_MCI_diff,area_NL_diff);
            
% AD shape trajectory
sliderplot_group_shape(AD_mean_shape,AD_color);
% MCI shape trajectory
sliderplot_group_shape(MCI_mean_shape,MCI_color);
% NC shape trajectory
sliderplot_group_shape(NL_mean_shape,NL_color);

