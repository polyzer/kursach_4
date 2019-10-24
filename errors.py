import re

open_file = open('G:\\kursach_4_kurs\\kursach_4\\model\\logs\\identication_2019-10-23_14_33_26.055823')
#open_file = open('G:\\kursach_4_kurs\\kursach_4\\model\\logs\\identication_2019-10-19_17_55_04.350168')

save_errors_file = open('turned_0_48_errors.txt', 'a')
fringe = 0
classes_objects = []
for i in range(0, 104):
    start_name = "bs"
    if i < 10:
        start_name += "00"
    elif i < 100:
        start_name += "0"
    start_name += str(i)
    new_el = {
        "class_name": start_name,
        "class_number": str(i),
        "right_matches": 0,
        "missed_matches": 0
    }
    classes_objects.append(new_el)

for line in open_file.readlines():
    for error_obj in classes_objects:
        if line.startswith(error_obj['class_name']):
            line_arr = line.split(' ')
            #print(line_arr[5])
            if line_arr[6] == error_obj['class_number']:
                error_obj['right_matches'] += 1
            else:
                error_obj['missed_matches'] += 1
                save_errors_file.write(line.split(" ")[0] + "\n")
#    result = re.split(r'[[', 'Analytics Vidhya')
open_file.close()
summary = 0

all_rights = 0
all_misses = 0
for obj in classes_objects:
    all_rights += obj['right_matches']
    all_misses += obj['missed_matches']
if all_misses > 0:
    save_errors_file.write("Right Matches: %s, Missed: %s, percentage: %s" %(all_rights, all_misses, (all_rights/(all_misses+all_rights))))
    print("Right Matches: %s, Missed: %s, percentage: %s" %(all_rights, all_misses, (all_rights/(all_misses+all_rights))))


