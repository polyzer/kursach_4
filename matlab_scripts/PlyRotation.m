%This script rotates ply clouds
PlyLoadDir = 'G:\kursach_4_kurs\kursach_4\Datasets\DB\errored\';
RotatedPlySaveDir = 'G:\kursach_4_kurs\kursach_4\Datasets\DB\ply_rotated_new\';
for k = 50:104
    num_part = '';
    if k < 10
        num_part = 'bs00';
    elseif k < 100
        num_part = 'bs0';
    else        
        num_part = 'bs';
    end
    files_mask = strcat(PlyLoadDir, num_part, int2str(k), '*.ply');
    normals_mask=strcat(PlyLoadDir, num_part, int2str(k),'*N_N_0.ply');
    files  = dir (files_mask);
    [count, ~] = size(files);
    fprintf("%d\n", count);
    normal_file = dir(normals_mask);
    full_normal_file =  fullfile(normal_file(1).folder, normal_file(1).name);
    current_normal_ply = pcread(full_normal_file);
    fprintf("Normal filename: %d\n", full_normal_file);
    %Now we go through files (that we get using mask)
    for i = 1:count
        file = files(i);
        filename = fullfile(file.folder, file.name);
        current_rotating_ply = pcread(filename);
        [tform,current_rotating_ply,rmse] = pcregrigid(current_rotating_ply, current_normal_ply);
        fprintf("rmse %d", rmse);
        counter = 0;
        while counter < 10
            [tform,current_rotating_ply,rmse] = pcregrigid(current_rotating_ply, current_normal_ply);
            fprintf("rmse %d", rmse);
            counter = counter + 1;
        end
        %ptCloudOut = pctransform(ptCloudOut, tform);
        fprintf(">>> %s (%d of %d)<<<\n", file.name, i, count);
        write_file_name = strcat(RotatedPlySaveDir, file.name);
        pcwrite(current_rotating_ply, write_file_name);
    end
end
