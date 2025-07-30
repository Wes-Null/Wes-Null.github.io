###########################################
### SPOTIFY CLUSTER PROJECT: ML SECTION ###
###########################################

### By Aaron Null ###

library(tidyverse)
library(cluster)
library(factoextra)
library(readr)
library(pheatmap)
library(uwot)
library(rnndescent)

## OPEN DATA ##

Spotify_df <- read_csv("data/Spotify_Top_Songs_Global_May_29_2025 (2).csv")

Spotify_df$exists = 1

### PIVOT WIDE ###

## Columns are countries, rows are songs
## 1 if song appears, 0 if not

spotify_wide <- Spotify_df |>
  pivot_wider(names_from = country, values_from = exists, id_cols = c(track_name, artist_names))

spotify_wide <- spotify_wide %>%
  mutate(across(everything(), ~ifelse(is.na(.), 0, .)))

#########################################
### PART ONE: Hierarchical Clustering ###
#########################################

### Sample 4000 rows first to test linkage method and select optimal k

sample <- 4000

round_one_sample <- spotify_wide |>
  sample_n(sample)

### Create Jaccard matrix from sample

jaccard_mat <- dist(round_one_sample[,3:ncol(round_one_sample)], method = "binary")

### Test different cluster linkage methods: Complete and Wards

# Complete Linkage
corr_complete <- cor(jaccard_whole, cophenetic(hc_complete))

# Ward's Method
corr_ward <- cor(jaccard_whole, cophenetic(hc_wards))

corr_complete
corr_ward

# Ward has higher cophenetic correlation

# Run clustering on the sample

hc_wards_sample <- agnes(jaccard_mat, method = "ward")

# Use the silhouette method to find the best k (produces chart)

round_one_cut<- fviz_nbclust(
  x = as.matrix(jaccard_mat),
  FUNcluster = function(x, k) { list(cluster = cutree(hc_wards_sample, k = k)) },
  method = "silhouette",
  k.max = 100
) +
  labs(title = "Optimal Number of Clusters (Silhouette Method)")

optimal_k_plot <- round_one_cut + scale_x_discrete(breaks = seq(0, 100, by = 5))

# Save the plot

saveRDS(optimal_k_plot, "optimal_k_plot.rds")

# Picking k = 32
# Create jaccard matrix of the whole data set

jaccard_whole <- dist(spotify_wide[,3:ncol(spotify_wide)], method = "binary")

# Do clustering on the whole dataset

hc_wards <- agnes(jaccard_whole, method = "ward")

# saveRDS(hc_wards, "data/hc_wards.rds")

# Cluster object is then loaded into main report

##################################
### PART 2: UMAP Visualization ###
##################################

## Numeric data only

umap_input <- spotify_wide |>
  select(-track_name, -artist_names)

set.seed(42)

## Run umap from uwot

umap_result <- umap(
  X = umap_input,
  metric = "jaccard",
  nn_method = "nndescent"
)

## Format into df

umap_plot_df <- data.frame(
  X = umap_result[, 1],
  Y = umap_result[, 2],
  cluster = as.factor(cutree(hc_wards, k = 32))
)

## Save df

saveRDS(umap_plot_df, "data/umap_plot_df.rds")

## Load into main report
