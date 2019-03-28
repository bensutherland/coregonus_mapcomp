# To collect data for C. ablock

# Clear space
# rm(list=ls())

setwd("~/Documents/general_projects/04_continuing_salmonid_MapComp/01_Coregonus_albock_file_prep")

# read in data
cabl.in <- read.delim2(file = "FileS4.csv", header = T, sep = ",", stringsAsFactors = F)
head(cabl.in)
str(cabl.in)

# Data needs to be in the following format:
# "SpeciesName,LG,Position,Zeroes,markerName,markerSequence"
# better example
# Cclu,1,0,0,63776,GTATGAGGTTTGTCTTTAACAAAGGTCTCCAGTCAGAAACAGAGATGATGTGTCTTTAACCCTCCAGT
# Cclu,1,6.135,6.135,64642,CATCAAGTTATAAAAGTAAATCAAGTTGACATGTTAATGTACACCTCAAAACAGCTCTTTTGATTCAG

cabl.in$sp <- rep(x = "Cabl", times = nrow(cabl.in))
head(cabl.in)

# What do your LGs look like
unique(cabl.in$LG)

# Format the LGs
cabl.in$LG <- as.numeric(gsub(x = cabl.in$LG, pattern = "SS", replacement = ""))
str(cabl.in)

# Create empty vector for totpos
cabl.in$totpos <- as.numeric(rep(x = "0", times = nrow(cabl.in)))

# make fem.pos numeric
cabl.in$Female_Position <- as.numeric(cabl.in$Female_Position)

str(cabl.in)

# Collect in needed format
cabl.in <- cabl.in[,c("sp","LG","Female_Position","totpos","RAD_ID","FASTA")]

head(cabl.in)
str(cabl.in)

# Sort the LGs
cabl.in <- cabl.in[order(cabl.in$LG, cabl.in$Female_Position), ]
head(cabl.in)

# output
write.csv(x = cabl.in, file = "cabl_prepped.csv", quote = F, row.names = F)
