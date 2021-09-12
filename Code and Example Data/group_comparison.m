function [AD_mean,area_AD_mean,MCI_mean,area_MCI_mean,NL_mean,area_NL_mean,...
          area_AD_diff,area_MCI_diff,area_NL_diff,AD_mean_shape,...
          MCI_mean_shape,NL_mean_shape,AD_color,MCI_color,NL_color] = ...
          group_comparison(sub_scan_time,sub_id,area_mean_estimate,area_pred,...
          surf_mean,surf_estimate)

% Load labels
[~,mmseID,~] = xlsread('DXSUM_PDXCONV_ADNIALL.csv','D:D');
mmseID = mmseID(2:end);
[~,exam_date,~] = xlsread('DXSUM_PDXCONV_ADNIALL.csv','J:J');
exam_date = exam_date(2:end);
diag_adni1 = xlsread('DXSUM_PDXCONV_ADNIALL.csv','L2:L3869');
diag_adnigo2 = xlsread('DXSUM_PDXCONV_ADNIALL.csv','K3870:K10015');
diag_adni3 = xlsread('DXSUM_PDXCONV_ADNIALL.csv','BA10016:BA12561');

for i = 1:length(exam_date)
    exam_date{i} = datestr(exam_date{i},'yyyy-mm-dd');
end

for i = 1:length(diag_adnigo2)
    if ismember(diag_adnigo2(i),[3,5,6,8,9])
        diag_adnigo2(i) = 3;
    elseif ismember(diag_adnigo2(i),[2,4,7])
        diag_adnigo2(i) = 2;
    else
        diag_adnigo2(i) = 1;
    end
end

diag_all = cat(1,diag_adni1,diag_adnigo2,diag_adni3);

% Assign labels to subjects
for i = 1:length(exam_date)
    exam_date_num{i} = datenum(exam_date{i},'yyyy-mm-dd');
end
for i = 1:length(exam_date_num)
    if isempty(exam_date_num{i})
        exam_date_num{i} = [0];
    end
end

for i = 1:length(sub_scan_time)
    for j = 1:length(sub_scan_time{i})
        sub_scan_time_num{i}{j} = datenum(sub_scan_time{i}{j},'yyyy-mm-dd');
    end
end

clear id_date_index;
for i = 1:length(sub_id)
    ids = find(strcmp(sub_id{i},mmseID));
    for j = 1:length(sub_scan_time_num{i})
        date_ids = find(cellfun(@(x) abs(x-sub_scan_time_num{i}{j})<15,exam_date_num));
        id_date_index{i}{j} = intersect(ids,date_ids);
    end
end

for i = 1:length(id_date_index)
    for j = 1:length(id_date_index{i})
        if length(id_date_index{i}{j})>1
            id_date_index{i}{j} = id_date_index{i}{j}(1);
        end
        if isempty(id_date_index{i}{j}) == 0
            sub_label{i}{j} = diag_all(id_date_index{i}{j});
        else
            sub_label{i}{j} = 0;
        end
    end
end

for i = 1:length(sub_label)
    tmp = cell2mat(sub_label{i});
    if find(tmp==2)
        sub_diag(i) = 2;
    elseif find(tmp==3)
        sub_diag(i) = 3;
    else
        sub_diag(i) = 1;
    end
end

% Group mean
AD_mean = zeros(size(surf_mean));
area_AD_mean = zeros(size(area_mean_estimate));
for i = 1:length(find(sub_diag==3))
    tmp = find(sub_diag==3,i);
    AD_mean = AD_mean + surf_estimate{tmp(end)};
    area_AD_mean = area_AD_mean + area_pred{tmp(end)};
end
AD_mean = AD_mean/length(find(sub_diag==3));
area_AD_mean = area_AD_mean/length(find(sub_diag==3));

MCI_mean = zeros(size(surf_mean));
area_MCI_mean = zeros(size(area_mean_estimate));
for i = 1:length(find(sub_diag==2))
    tmp = find(sub_diag==2,i);
    MCI_mean = MCI_mean + surf_estimate{tmp(end)};
    area_MCI_mean = area_MCI_mean + area_pred{tmp(end)};
end
MCI_mean = MCI_mean/length(find(sub_diag==2));
area_MCI_mean = area_MCI_mean/length(find(sub_diag==2));

NL_mean = zeros(size(surf_mean));
area_NL_mean = zeros(size(area_mean_estimate));
for i = 1:length(find(sub_diag==1))
    tmp = find(sub_diag==1,i);
    NL_mean = NL_mean + surf_estimate{tmp(end)};
    area_NL_mean = area_NL_mean + area_pred{tmp(end)};
end
NL_mean = NL_mean/length(find(sub_diag==1));
area_NL_mean = area_NL_mean/length(find(sub_diag==1));

for i = 1:length(area_AD_mean)
    AD_mean(:,:,:,i) = AD_mean(:,:,:,i)*area_AD_mean(i);
    MCI_mean(:,:,:,i) = MCI_mean(:,:,:,i)*area_MCI_mean(i);
    NL_mean(:,:,:,i) = NL_mean(:,:,:,i)*area_NL_mean(i);
end

for i = 1:(length(area_AD_mean)-1)
    area_AD_diff(i) = (area_AD_mean(i+1)-area_AD_mean(i))/area_AD_mean(i);
    area_MCI_diff(i) = (area_MCI_mean(i+1)-area_MCI_mean(i))/area_MCI_mean(i);
    area_NL_diff(i) = (area_NL_mean(i+1)-area_NL_mean(i))/area_NL_mean(i);
end

% shape trajectories
AD_mean_shape = AD_mean;
for i = 1:length(area_AD_mean)
    AD_mean_shape(:,:,:,i) = AD_mean(:,:,:,i)/area_AD_mean(i);
end
MCI_mean_shape = MCI_mean;
for i = 1:length(area_MCI_mean)
    MCI_mean_shape(:,:,:,i) = MCI_mean(:,:,:,i)/area_MCI_mean(i);
end
NL_mean_shape = NL_mean;
for i = 1:length(area_NL_mean)
    NL_mean_shape(:,:,:,i) = NL_mean(:,:,:,i)/area_NL_mean(i);
end

% Color for visualization
AD_color = zeros(size(AD_mean,1),size(AD_mean,2),size(AD_mean,4));
MCI_color = zeros(size(MCI_mean,1),size(MCI_mean,2),size(MCI_mean,4));
NL_color = zeros(size(NL_mean,1),size(NL_mean,2),size(NL_mean,4));

for i = 1:size(AD_mean,4)
    diff = AD_mean_shape(:,:,:,i) - NL_mean_shape(:,:,:,i);
    AD_color(:,:,i) = sqrt(diff(:,:,1).^2+diff(:,:,2).^2+diff(:,:,3).^2);
end
for i = 1:size(MCI_mean,4)
    diff = MCI_mean_shape(:,:,:,i) - NL_mean_shape(:,:,:,i);
    MCI_color(:,:,i) = sqrt(diff(:,:,1).^2+diff(:,:,2).^2+diff(:,:,3).^2);
end
for i = 1:size(NL_mean,4)
    diff = NL_mean_shape(:,:,:,i) - NL_mean_shape(:,:,:,i);
    NL_color(:,:,i) = sqrt(diff(:,:,1).^2+diff(:,:,2).^2+diff(:,:,3).^2);
end

AD_max = max(max(AD_color(:,:,end)));
MCI_max = max(max(MCI_color(:,:,end)));

AD_color = AD_color/AD_max;
MCI_color = MCI_color/AD_max;
NL_color = NL_color;


end