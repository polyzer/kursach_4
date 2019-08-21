import re
open_file = open('out.txt')
#People id's
errors_obj = {
    "bs000": {
    }
}
classes_names = []
for i in range(0, 104):
    start_name = "bs"
    if i < 10:
        start_name += "00"
    elif i < 100:
        start_name += "0"
    start_name += str(i)
    classes_names.append(start_name)
print(classes_names)

# for line in open_file.readlines():
#     print(line)
#     result = re.split(r'i', 'Analytics Vidhya')
open_file.close()