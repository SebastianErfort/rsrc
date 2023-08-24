#!/usr/bin/python3
# Read a table from file
# Determine column (field) titles and widths, then read content.

results = []

with open(argv[1], 'r') as f:
    content = f.readlines()

    fields = []
    field_widths = []
    active = False
    for line in content:
        # read table header: field titles and widths
        if line.startswith('Number'):
            active = True  # found table header, after this we want to read data

            for idx, char in enumerate(line):  # Criterion for new field: here capital letter
                if char.isupper():
                    field_widths.append([idx, None])
            for idx, fw in enumerate(field_widths[:-1]):  # determine field widths
                fw[1] = field_widths[idx+1][0] - 1
            fields = [line[fw[0]:fw[1]].strip().lower() for fw in field_widths]

        # read table data
        else:
            if active:
                l_split = [line[fw[0]:fw[1]].strip().lower() for fw in field_widths]
                # create key-value pairs from column headers and values
                p = {k.lower(): l_split[idx] for idx, k in enumerate(fields)}

                results.append(p)
