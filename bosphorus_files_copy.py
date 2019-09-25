import glob
import os
import shutil


files_ply_path = "G:\\kursach_4_kurs\\kursach_4\\Datasets\\DB\\ply"
files_probe_path = "G:\\kursach_4_kurs\\kursach_4\\model\\3DFace\\Probe"
files_gallery_path = "G:\\kursach_4_kurs\\kursach_4\\model\\3DFace\\Gallery"

def removeFilesfromDir(dirname):
    if dirname == files_ply_path:
        print("NOOOOOOOOOOOOOOOOO")
        return
    files_in_dir = glob.glob(os.path.join(dirname, "*"))
    for f_name in files_in_dir:
        os.remove(f_name)
    # for file_name in files_in_dir:
    #     os.remove(file_name)

def copyBosphorusNormalFiles(from_dir, to_dir):
    norm_files = glob.glob(os.path.join(from_dir, "*N_N_0*"))
    for full_file_name in norm_files:
        file_name = os.path.basename(full_file_name)
        copy_file_name = os.path.join(to_dir, file_name)
        shutil.copy(full_file_name, copy_file_name)
    print("Normal files were copied")

def copy_100(from_path, to_path):
    for i in range(100):
        name_index = ""
        if i < 10:
            name_index += "00" + str(i)
        elif i < 100:
            name_index += "0" + str(i)
        else:
            name_index += str(i)
        copy_file_names = glob.glob(os.path.join(from_path, "bs" + name_index + "*"))
        for full_file_name in copy_file_names:
            file_name = os.path.basename(full_file_name)
            copy_file_name = os.path.join(to_path, file_name)
            shutil.copy(full_file_name, copy_file_name)
        print("Files were copied")

if __name__ == "__main__":
    removeFilesfromDir(files_probe_path)
    copy_100(from_path = files_ply_path, to_path = files_probe_path)
    #removeFilesfromDir(files_gallery_path)
    #copyBosphorusNormalFiles(from_dir=files_ply_path, to_dir=files_gallery_path)