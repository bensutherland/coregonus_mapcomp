# retain only the species needed for the Coregonus analysis

# Clear space
# rm(list=ls())

# Set working directory (if this is not your computer, set it to where your git repo is)
setwd("~/Documents/general_projects/04_continuing_salmonid_MapComp/")

# Load in data
data_v1 <- read.csv(file = "coregonus_mapcomp/02_input_materials/markers.csv"
                    , header = F, stringsAsFactors = F)
head(data_v1)
colnames(data_v1) <- c("sp", "lg", "cM", "cM_tot", "mname")
str(data_v1)

# Observe data
unique(data_v1$sp) # what species are in here? 
dim(data_v1)

# Keep the anchor species (one per genus)
keep_species <- c("Cclu", "Eluc", "Ssal", "Sfon", "Otsh")

# Subset
data_v1_subset <- data_v1[data_v1$sp %in% keep_species, ]

# Observe data
unique(data_v1_subset$sp) # what species are in here? 

# Output data
write.csv(x = data_v1_subset, file = "coregonus_mapcomp/02_input_materials/data_v1_subset.csv"
          , row.names = F, quote = F)
