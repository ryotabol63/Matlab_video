% ffmpegへのpath(環境に合わせてpathを変える必要あり)
%ffmpeg = "/opt/homebrew/bin/ffmpeg"; % macでhomebrewでインストールした場合
ffmpeg  = "C:\ffmpeg\bin\ffmpeg.exe"; % for Windows

org_dir = pwd;

%cd("/Users/hariyama/Downloads/tmp");
%data_folder = uigetdir();
%data_folder = "/Users/hariyama/Dropbox/LAB/WORK_DB/Research/P_子供情育環境学/20230201_山口_ハダシらんど/test";

% ------------ ここからは変更は不要　---------------
data_folders = string(uipickfiles());

for data_folder = data_folders
    cd(data_folder);
    files = dir('*.m2ts');
    files = string({files.name});
    
    for f = files
        [~, fbody, ~]=fileparts(f);
        cmd = ffmpeg + ' -i ' + data_folder + '/' + f + ' ' +  ...
            data_folder + '/' + fbody + '.mp4';
        disp(cmd)
        system(cmd);
    end
end

%{
for data_folder = data_folders
    cd(data_folder);
    files = dir('*.mp4');
    files = string({files.name});
    
    flist = [];
    for f = files
        [folder, fbody, ~]=fileparts(f);
        cmd = "file " + fbody + ".mp4";
        flist = [flist; cmd];                              
    end
    writematrix(flist, "list.txt");
    disp(flist)
    [~, curFolderName, ~] = fileparts(data_folder);    
    outFile = curFolderName + ".mp4";
    cmd = ffmpeg + " -f concat -safe 0 -i list.txt -c copy " + outFile;
    %disp(cmd)
    system(cmd);
    movefile(outFile, "../");    
    delete("list.txt");
end
%}

cd(org_dir);



