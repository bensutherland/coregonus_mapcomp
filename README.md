# coregonus_mapcomp
Collect and format Coregonus genetic map input data for MapComp analysis


If you are looking for the method to obtain raw data for the following species and projects, check the repo:     
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

...to obtain additional maps, follow ##collect-raw-input-data[].     

---

## Collect Raw Input Data
In this analysis, we are going to look at the following Coregonus species:    
- Lake Whitefish (_Coregonus clupeaformis_) (see above)
- European Whitefish (_Coregonus lavaretus albock_) (de Kayne et al. 2018)
- Cisco (_Coregonus artedi_) (Blumstein et al. in prep)   

The following species will also be used, from previous analyses, using one representative species per genus:      
- Northern Pike (see above)
- Atlantic Salmon (see above)
- Brook Charr (see above)
- Chinook Salmon (see above)

And we may integrate a higher density map from:
- Chinook Salmon (McKinney et al. 201X)

### Obtain data from first salmonid genetic map comparison
Download raw data for all species in the previous analysis from:     
https://www.dropbox.com/s/s5gbp1sak54cwdd/markers.csv?dl=0     

Put the downloaded file into `02_input_materials`, and run within R:     
`01_scripts/salmonid_maps_v1_subset.r`     

To produce a combined input file for the species of interest from the previous analysis, within:    
`02_input_materials/data_v1_subset.csv`         

### Obtain data from new maps
Follow the instructions in `00_resources/data_sources.md`     
This will result in the new maps described above being present in `markers_2.csv`       
 



### THIS IS ALL NEW ###

##### Female #####
From supplied files, save the female map as a .csv file `female_linkage_map_final.csv`, replace ^M character with a newline, then run the following code:     
```
grep -vE '^LG' female_linkage_map_final.csv | awk -F, '{ print "Cart," $1 ","  $10 ",0" "," $2 "," $11 }' - > cart_fem_map.csv
```

This adds 20,450 Cart markers.

Then run the step of mapcomp to add the totpos column, and convert to fasta. Save as `markers_female_Cart.fasta`

##### Male #####
Save out the male map the same way, but run the following command instead because of different column names:     
```
grep -vE '^LG' male_linkage_map_final.csv | awk -F, '{ print "Cartm," $1 ","  $4 ",0" "," $2 "," $6 }' - > ./cart_male_map.csv
``` 

As above, convert to `markers_male_Cart.fasta`.     

##### Female no duplicated markers #####
```
grep -vE '^LG' female_linkage_map_final.csv | grep -v 'Duplicated' - | awk -F, '{ print "Cartfnodup," $1 ","  $10 ",0" "," $2 "," $11 }' - > ./cart_fem_map_nodup.csv
# Copy to mapcomp repo
cp ./cart_fem_map_nodup.csv ./../mapcomp_cisco_w_male/02_data/
# Convert to fasta
01_scripts/00_prepare_input_fasta_file_from_csv.sh ./02_data/cart_fem_map_nodup.csv
# Rename
mv 02_data/markers.fasta 02_data/markers_female_nodup_Cart.fasta
```

#### Obtain other maps ####
Use the stored file and make into a fasta using the mapcomp script.  
       
```
# Get data
cp /Users/wayne/Documents/general_projects/04_continuing_salmonid_MapComp/00_source_materials/markers.csv 02_data/
# Convert to fasta
./01_scripts/00_prepare_input_fasta_file_from_csv.sh ./02_data/markers.csv 
# save
mv 02_data/markers.fasta 02_data/markers_orgn_mapcomp_sp.fasta   
```

### Combine ####
As long as these prepared are the only in your repo, combine as follows      
```
cat 02_data/*.fasta > 02_data/markers.fasta
# 
grep '>' 02_data/markers.fasta | awk -F"_" '{ print $1 }' - | sort | uniq -c | less
```

Markers | Species
:--------: | --------:
20450 | >Cart
17067 | >Cartfnodup
6340 | >Cartm
3438 | >Cclu
 524 | >Eluc
21105 | >Ogor
6119 |>Oket
5377 |>Okis
 955 |>Omyk
6262 |>Oner
6352 |>Otsh
3826 |>Sfon
5917 |>Ssal




## Finish
Change the location of the genome in `./mapcomp` and the `01_scripts/bwa_align_reads.sh`
```
./mapcomp
```

Bring in the original mapcomp excel table:    
`/Users/wayne/Documents/general_projects/04_continuing_salmonid_MapComp/corr_bw_LGs_Sfonv3.4_wRT_2016-12-28.xlsx`

Update, using Cart against Otsh first.   
