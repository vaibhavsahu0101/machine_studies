# Roberto
# Vaibhav Sahu May,2024

#!/bin/bash

# directory to check for TIFF images

# enter the directory to convert tif images to png

# dir="/Users/vsahu/Desktop/drop-convert/tifs"
# dir="/Volumes/naat_sahu/machine_studies/studies220424/gamma_compensation/"
# dir="/Users/vsahu/Downloads/DATA/machine_studies/PLI9/studies300424/acq_11000_gain_gamma"
# dir="/Users/vsahu/Downloads/DATA/machine_studies/PLI10/studies140524/light_source_preset/cpl-cpl/ccw/acA5472-17uc/Off"
# dir="/Volumes/naat_sahu/machine_studies/PLI10/studies150524/light_source_preset/cpl-cpl/ccw/acA5472-17uc/Off"
# dir="/Volumes/naat_sahu/machine_studies/PLI10/studies130524/light_source_preset/cpl-r-lp/a2A4504-18ucBAS/Daylight5000K"
dir="/Users/vsahu/Downloads/DATA/machine_studies/PLI10/studies290524/light_source_preset/cpl-cpl/ccw/acA5472-17uc/RGB8/Off"

# total=$(find "$dir" -name "*.tif" | wc -l | sed -e 's/^[[:space:]]*//')
files=("$dir"/*00_*/*.tif)
# total=$(find "$dir" -name "*.tif" | wc -l | sed -e 's/^[[:space:]]*//')
total=${#files[@]}
index=0

# current time in ticks
start=$(date +%s)

# find "$dir" -name "*.tif"| while read -r file; do
for file in "${files[@]}"; do
    # print progress
    index=$((index+1))
    percent=$(echo "scale=2; $index/$total*100" | bc)
    now=$(date +%s)
    elapsed=$((now-start))
    eminutes=$((elapsed/60))
    eseconds=$((elapsed%60))
    remaining=$((elapsed*total/index-elapsed))
    rminutes=$((remaining/60))
    rseconds=$((remaining%60))
    echo "$index/$total ($percent%) ETA: $rminutes min $rseconds sec (elapsed: $eminutes min $eseconds sec)"
    echo -ne "\033[1A"
    
    # convert the tif image to png
    basedir=$(dirname "$file")
    filename=$(basename "$file" .tif)

    convert "${file}" "$basedir/${filename}.png"

    # if the file was successfully converted, delete the tif image
    if [ $? -eq 0 ]; then
        rm "${file}"
    fi
done

echo "Finished converting $total files in $eminutes min $eseconds sec"