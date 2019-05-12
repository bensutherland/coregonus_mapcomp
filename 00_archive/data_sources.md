# Websites and directions to obtain raw data
2019-04-05
B. Sutherland

This is how to obtain data necessary for the second salmonid genetic map analysis      

**Note**: Follow steps exactly to ensure compatibility with the formatting script in R.     

The MapComp format is:      
SpeciesName,LG,Position,Zeroes,markerName,markerSequence      

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

##### Female #####
From supplied files, save the female map as a csv in 02_input_material, and make sure there are no ^M as end of line characters, then run:     
```
# First save out all (20,450) markers
grep -vE '^LG' 02_input_materials/S1_cisco_female_map.csv | awk -F, '{ print "Cart," $1 ","  $8 ",0" "," $2 "," $9 }' -  > 02_input_materials/cart_fem_map.csv

# Second save out non-duplicated markers
grep -vE '^LG' 02_input_materials/S1_cisco_female_map.csv | grep -v 'Duplicated' - | awk -F, '{ print "Cartfnodup," $1 ","  $8 ",0" "," $2 "," $9 }' - > 02_input_materials/cart_fem_map_nodup.csv

```

##### Male #####
From supplied files, save the male map as a csv in 02_input_material (note: different column numbers), and make sure there are no ^M as end of line characters, then run:     
```
grep -vE '^LG' 02_input_materials/S2_cisco_male_map.csv | awk -F, '{ print "Cartm," $1 ","  $4 ",0" "," $2 "," $6 }' - > ./02_input_materials/cart_male_map.csv
``` 

## Finish and move files to MapComp
Combine the new csv files:
`cat 02_input_materials/cart_fem_map.csv 02_input_materials/cart_male_map.csv 02_input_materials/cart_fem_map_nodup.csv > 02_input_materials/markers_2.csv`

Continue with the README at step XX.    
