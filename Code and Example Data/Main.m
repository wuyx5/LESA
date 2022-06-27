clear; close all;

%% Load Example Data
currentFolder = pwd;
load Example_data.mat;

%% Surface Registration and Computing Karcher Mean with SRNF
addpath(genpath('./Registration/'));
[muF,v] = Karcher_mean(F);
cd(currentFolder);

%% PCA
[S,U,coef,sparse_coef]=surf_pca(v,muF,sub_times);

%% SPHARM-PDM
[S_SPDM,U_SPDM,coef_SPDM,v_SPDM,muF_SPDM]=spdm_pca(F);

%% Figure 6

[dist_elastic,dist_spdm] = repre_efficiency(U,coef,muF,v,U_SPDM,coef_SPDM,muF_SPDM,v_SPDM);
plot_repre_efficiency(dist_elastic,dist_spdm);

%% PACE Fitting
% PACE Package: https://github.com/functionaldata/PACE_matlab
% Yao, F., Müller, H.G., Wang, J.L. (2005). Functional data analysis for sparse longitudinal data. J. American Statistical Association 100, 577-590.

addpath('./PACE_matlab-master/release2.17/PACE/');
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
sliderplot_individual(surf_estimate{idx});

idx = 6;
plot_individual_area(age_min,age_max,area_pred,area_mean_estimate,outa,sparse_t,sparse_area,idx);
plot_individual_PC(age_min,age_max,coef_pred,pc_mean_estimate,outa,sparse_t,sparse_coef,idx);
sliderplot_individual(surf_estimate{idx});

%% Figure 9
sliderplot_lifespan(surf_mean);
