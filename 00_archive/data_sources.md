# Websites and directions to obtain raw data
2019-04-05
B. Sutherland

This is how to obtain data necessary for the second salmonid genetic map analysis      

**Note**: Follow steps exactly to ensure compatibility with the formatting script in R.     

## Citations
The following species will be collected for the final analysis, please cite the following papers if you use the data:     
**European Whitefish** *C. lavaretus ablock*      
de Kayne et al. 2018 A European Whitefish Linkage Map and Its Implications for Understanding Genome-Wide Synteny Between Salmonids Following Whole Genome Duplication. G3: Genes, Genomes, Genetics 8(12) pp 3745-3755. https://doi.org/10.1534/g3.118.200552
 
**Cisco** *C. artedi*      
Blumstein et al. in prep (to add)     

Not yet implemented:    
**Chinook Salmon** *Oncorhynchus tshawytscha*     


## Per species, download and format data
### 1. European Whitefish (i.e. C. lavaretus or Clav)
Go to the following figshare repo and download FileS4, a .csv containing the female map.            
https://figshare.com/articles/Supplemental_Material_for_De-Kayne_and_Feulner_2018/7093799
Make sure the filename is `FileS4.csv` Put this within `coregonus_mapcomp/02_input_materials`.     

To format markers, run R interactively using the following script:     
`prep_clav.r`     
...this will produce a .csv in the MapComp format in `02_input_materials/clav_prepped.csv`.    


#### Cisco (i.e. C. artedi, or Cart)
Obtain from D. Blumstein, in prep. Make sure name is      

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

#### Chinook Salmon
(Currently data file provided by email only FileS2.xlsx)

