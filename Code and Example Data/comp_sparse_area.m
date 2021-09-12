function [sparse_area] = comp_sparse_area(sparseF,sub_times)

for i = 1:length(sparseF)
    for j = 1:sub_times(i)
        sparse_area{i}(j) = area_surf_geod_closed(sparseF{i}(:,:,:,j));
    end
end

end