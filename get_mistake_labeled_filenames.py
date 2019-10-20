import glob
import os
import shutil
PlysDirName = 'G:\\kursach_4_kurs\\kursach_4\\Datasets\\DB\\ply'
ErrorsDirName = 'G:\\kursach_4_kurs\\kursach_4\\Datasets\\DB\\errored'
FileWithErrorsName = 'G:\\kursach_4_kurs\\kursach_4\\errors.txt'

f = open(FileWithErrorsName)
1
for line in f:
    line = line.strip()
    line = line.replace(".npy", ".ply")
    full_src_name = os.path.join(PlysDirName, line)
    full_dst_name = os.path.join(ErrorsDirName, line)
    shutil.copy(full_src_name, full_dst_name)
    print("File %s was copied to %s" %(full_src_name, full_dst_name))
print("OK")
