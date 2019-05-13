# To collect data for C. lavaretus

# Clear space
# rm(list=ls())

# Set working directory
setwd("~/Documents/general_projects/04_continuing_salmonid_MapComp/coregonus_mapcomp")

# Set variables
species_short <- "Clav"

# Read in data
clav.in <- read.delim2(file = "02_input_materials/FileS4.csv", header = T, sep = ",", stringsAsFactors = F)
head(clav.in)
str(clav.in)

# MapComp Format:    
# SpeciesName, LG, Position, Zeroes, markerName, markerSequence
# e.g. Cclu,1,6.135,6.135,64642,CATCAAGTTATAAAAGTAAATCAAGTTGACATGTTAATGTACACCTCAAAACAGCTCTTTTGATTCAG

### Re-format to MapComp format ####
# Add species short name
clav.in$sp <- rep(x = species_short, times = nrow(clav.in))

# Add empty vector for totpos calculation within mapcomp
clav.in$totpos <- as.numeric(rep(x = "0", times = nrow(clav.in)))

# Standardize LG names to standardize
unique(clav.in$LG) # current format
clav.in$LG <- as.numeric(gsub(x = clav.in$LG
                              , pattern = "SS" # remove extra characters
                              , replacement = "")
                         )
str(clav.in)

# Make the marker position numeric
clav.in$Female_Position <- as.numeric(clav.in$Female_Position)
str(clav.in)

# Re-order columns and retain only those needed for MapComp format
clav.in <- clav.in[,c("sp","LG","Female_Position","totpos","RAD_ID","FASTA")]
head(clav.in)
str(clav.in)

# Sort by LG and the cM position
clav.in <- clav.in[order(clav.in$LG, clav.in$Female_Position), ]
head(clav.in)

# Write to output
write.csv(x = clav.in, file = "02_input_materials/clav_prepped.csv", quote = F, row.names = F)
