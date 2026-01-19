#!/bin/bash

# Directory containing the GDB files
BASE_DIR_ROFRS="RoFRS/*.gdb"
SAMPLE_ROFRS="RoFRS/RoFRS_NT50_v202501.gdb"
BASE_DIR_ROFSW="RoFSW/*.gdb"
SAMPLE_ROFSW="RoFSW/RoFSW_NT50_v202509.gdb"

# Output separated by layer
SEPARATED_DIR_ROFRS="RoFRS_Separated"
SEPARATED_DIR_ROFSW="RoFSW_Separated"

# List all layers in the GDB
# e.g. RoFRS_4band
rofrs_layers=$(ogrinfo "$SAMPLE_ROFRS" | awk -F': ' '/^Layer: / {print $2}' | cut -d' ' -f1)

# Loop through each layer
for layer in $rofrs_layers; do
    echo "Exporting layer: $layer"

    # Create output directory if it doesn't exist
    mkdir -p "$SEPARATED_DIR_ROFRS"
    mkdir -p "$SEPARATED_DIR_ROFRS/$layer"

    # Loop through each GDB and export the specific layer to a separate GPKG
    for gdb in $BASE_DIR_ROFRS; do
        base_name=$(basename "$gdb" .gdb)
        output_gpkg="${SEPARATED_DIR_ROFRS}/${layer}/${base_name}.gpkg"
        ogr2ogr -f GPKG "$output_gpkg" "$gdb" "$layer"
    done

    # Then for each layer merge all the GPKGs into a single GPKG with ogrmerge
    ogrmerge -o "${layer}.gpkg" -single -f GPKG "${SEPARATED_DIR_ROFRS}/${layer}/*.gpkg"

    # Then append to a master GPKG
    ogr2ogr -update -append "RoFRS.gpkg" "${layer}.gpkg" -nln "$layer"

    # Clean up intermediate files
    rm -r "${SEPARATED_DIR_ROFRS:?}/$layer"
    rm "${layer}.gpkg"
    
done

