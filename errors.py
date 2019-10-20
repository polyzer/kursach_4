import re

open_file = open('second.txt')
save_errors_file = open('errors.txt', 'a')
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
            if line_arr[6] == error_obj['class_number']:
                error_obj['right_matches'] += 1
            else:
                error_obj['missed_matches'] += 1
                save_errors_file.write(line.split(" ")[0] + "\n")
#    result = re.split(r'[[', 'Analytics Vidhya')
open_file.close()
summary = 0
# Now we calculates errors
for error_obj in classes_objects:
    if error_obj['right_matches'] + error_obj['missed_matches'] > 0:
        error_obj['error_ref'] = error_obj['missed_matches'] / (error_obj['right_matches'] + error_obj['missed_matches'])
for error_obj in classes_objects:
    if error_obj['right_matches'] + error_obj['missed_matches'] > 0:
        summary += error_obj['error_ref']
summary = summary/104
print(summary)
