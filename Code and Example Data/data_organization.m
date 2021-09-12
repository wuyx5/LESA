function [sub_id,sub_scan_time,sub_scan_id,sub_times,sub_scan_age,sparseF] = data_organization(subject_name_list,F)

% Split char
for i = 1:length(subject_name_list)
    subject_id_list{i} = subject_name_list{i}(1:10);
    subject_time_list{i} = subject_name_list{i}(13:22);
    subject_scan_list{i} = subject_name_list{i}(25:end);
end

% Unique ID
sub_id = cellfun(@char,unique(subject_id_list),'uni',0);

% Time, Image for unique IDs in cell
for i = 1:length(sub_id)
    idx = find(strcmp(subject_id_list, sub_id{i}));
    for j = 1:length(idx)
        sub_scan_time{i}{j} = subject_time_list{idx(j)};
        sub_scan_id{i}{j} = subject_scan_list{idx(j)};
        sparseF{i}(:,:,:,j) = F(:,:,:,idx(j));
    end
    sub_times(i) = length(idx);
end

% Remove 1-2 scans
j=1;
for i = 1:length(sub_times)
    if sub_times(i)<3
        remove_idx(j) = i;
        j = j+1;
    end
end

sub_times(:,remove_idx) = [];
sub_id(:,remove_idx) = [];
sub_scan_id(:,remove_idx) = [];
sub_scan_time(:,remove_idx) = [];
sparseF(:,remove_idx) = [];

% Include age
[~,ageID,~] = xlsread('ADNIMERGE.csv','B:B');
ageID = ageID(2:end);
[~,study_date,~] = xlsread('ADNIMERGE.csv','G:G');
age = xlsread('ADNIMERGE.csv','I:I');

for i = 1:length(study_date)
    study_date{i} = datestr(study_date{i},'yyyy-mm-dd');
end

for i = 1:length(sub_id)
    ids = find(strcmp(sub_id{i},ageID));
    for j = 1:length(sub_scan_time{i})
        dates = find(strcmp(sub_scan_time{i}{j},study_date));
        id_date_dup{i}{j} = intersect(ids,dates);
    end
end

for i = 1:length(id_date_dup)
    for j = 1:length(id_date_dup{i})
        sub_scan_age{i}(j) = unique(age(id_date_dup{i}{j}));
    end
end

end