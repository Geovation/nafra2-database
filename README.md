# NAFRA2 database

Processing NAFRA2 data to load into PostGIS database

## Data download

The project assumes a `NaFRA2` folder in the root directory, data obtained from DEFRA. This data is exactly as obtained from DEFRA, downloaded by SFTP.

> Once you have access to the SFTP site, you will find a folder for each product and subdirectories for each Ordnance Survey National Grid square.  Within each of these you will find the data clipped to 50km tiles. Tiles names are based on the Ordnance Survey National Grid
> 
> **Contact from DEFRA Large Data Download team**

The data is in a folder structure as follows (with all OS grid squares)

```
NaFRA2
├── RoFRS
│   ├── NT
│   │   ├── RoFRS_Climate_Change_01_NT50_v202501.zip
│   │   ├── RoFRS_Climate_Change_01_NT55_v202501.zip
│   │   ├── RoFRS_NT50_v202501.zip
│   │   └── RoFRS_NT55_v202501.zip
│   └── ...
└── RoFSW
    ├── RoFSW
    │   ├── NT
    │   │   ├── RoFSW_NT50_v202509.zip
    │   │   ├── RoFSW_NT55_v202509.zip
    │   │   └── ...
    ├── RoFSW_Climate_Change_01
    ├── RoFSW_Hazard
    ├── RoFSW_Hazard_Climate_Change_01
    ├── RoFSW_Model_Origin
    ├── RoFSW_Speed
    └── RoFSW_Speed_Climate_Change_01
```

All of the zip files hold a geodatabase folder e.g. `RoFRS_NT50_v202501.gdb`

## Unzipping data

With the folder structure above we need to extract all the zip files to hold all the geodatabases in a single folder in order to process them together.

The `create_files.sh` script loops through for both RoFRS (Risk of Flooding from Rivers and Sea) and RoFSW (Risk of Flooding from Surface Water).

After running this script to new folders will be created in the root of the repository.

```
/
├── RoFRS
│   ├── RoFRS_NT50_v202501.gdb
│   ├── RoFRS_NT55_v202501.gdb
│   ├── RoFRS_NU00_v202501.gdb
│   └── ...
└── RoFSW
    ├── RoFRS_NT50_v202501.gdb
    ├── RoFRS_NT55_v202501.gdb
    ├── RoFRS_NU00_v202501.gdb
    └── ...
```

# Processing data

We are going to merge the layers and export to CSV files that can be quickly loaded into a PostGIS database.

