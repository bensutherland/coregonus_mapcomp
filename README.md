# coregonus_mapcomp
Collect and format Coregonus genetic map input data for MapComp analysis         

### Requirements
MapComp https://github.com/enormandeau/mapcomp     
bwa (using 0.7.12-r1039)     
samtools (using v.1.9)    


The following species have been analyzed previously. Check this repo for more info:
https://github.com/bensutherland/2016_ms_sfonmap    
- Coho Salmon (Kodama et al. 2014)
- Chinook Salmon (Naish et al. 2013)
- Rainbow Trout (Palti et al. 2015)
- Chum Salmon (Waples et al. 2016)
- Sockeye Salmon (Larson et al. 2015)
- Brook Charr (Sutherland et al. 2016)
- Atlantic Salmon (Lien et al. 2011)
- Lake Whitefish (Gagnaire et al. 2013)
- Northern Pike (Rondeau et al. 2014)

In the present analysis, we will analyze the following Coregonus species:    
- Lake Whitefish (_Coregonus clupeaformis_) (see above)
- European Whitefish (_Coregonus lavaretus albock_) (de Kayne et al. 2018)
- Cisco (_Coregonus artedi_) (Blumstein et al. in prep)   

...in addition to the following species (one per genus):     
- Northern Pike (see above)
- Atlantic Salmon (see above)
- Brook Charr (see above)
- Chinook Salmon (see above)

...to obtain the new European Whitefish and Cisco maps, and to obtain the reduced species from previous analyses, follow the steps below 

---

## Collect Raw Input Data
### A. Obtain data from first salmonid genetic map comparison
Download raw data for all species in the previous analysis from:     
https://www.dropbox.com/s/s5gbp1sak54cwdd/markers.csv?dl=0     

Put the downloaded file into `02_input_materials`, and run within R:     
`01_scripts/salmonid_maps_v1_subset.r`     
...this will produce a combined input file for the species of interest from the previous analysis, entitled `02_input_materials/data_v1_subset.csv`         

### B. Obtain data from new maps
Follow the instructions in `00_resources/data_sources.md`     
...this will collect European Whitefish and Cisco and put into the file `02_input_materials/markers_2.csv`     

### C. Move data into MapComp
Clone mapcomp onto your computer, in the same level directory as coregonus_mapcomp:      
```
cd ..
git clone https://github.com/enormandeau/mapcomp.git
cd ./mapcomp
```
The rest of the instructions should be followed from within the mapcomp directory.     
       
```
# Get data
cp ./../coregonus_mapcomp/02_input_materials/markers_2.csv ./02_data/
cp ./../coregonus_mapcomp/02_input_materials/data_v1_subset.csv ./02_data/
# Combine and remove header 
cat 02_data/data_v1_subset.csv 02_data/markers_2.csv | grep -vE 'mname' - > 02_data/markers.csv

```

See how many markers and how many species:     
`grep '>' 02_data/markers.fasta | awk -F"_" '{ print $1 }' - | sort | uniq -c | less`

Markers | Species
:--------: | --------:
20450 | >Cart
17067 | >Cartfnodup
6340 | >Cartm
3438 | >Cclu
 524 | >Eluc
6352 |>Otsh
3826 |>Sfon
5917 |>Ssal


### Run MapComp    
Change the variable `GENOME_FILE` in `./mapcomp` and the `01_scripts/01_bwa_align_reads.sh`
```
# Run the analysis
./mapcomp
# Output figures are available in 04_figures
```

Bring in the original mapcomp excel table:    
`/Users/wayne/Documents/general_projects/04_continuing_salmonid_MapComp/corr_bw_LGs_Sfonv3.4_wRT_2016-12-28.xlsx`

