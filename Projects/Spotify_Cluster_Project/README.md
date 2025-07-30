# Global Music Taste: A Clustering Analysis of Spotify Charts

**Live Project Website: https://Wes-Null.github.io**

This project performs a comprehensive clustering analysis on the top songs from Spotify charts across 73 different countries.
The goal is to uncover and visualize regional music tastes, identify global hits, and understand the relationships 
between different international music markets.

The data was initially collected from https://charts.spotify.com/home and the individual
country datasets were combined in Google Colab using Python.

---

## Technologies Used 🛠️
* **Python**: Primary language for merging country chart data.
* **R**: Primary language for data analysis and visualization.
* **Quarto**: Used to create the final project website.
* **R Packages**:
    * `dplyr` & `tidyr`: For data manipulation and cleaning.
    * `readr`: For loading data.
    * `cluster` & `factoextra`: For hierarchical clustering and silhouette analysis.
    * `ggplot2`: For static visualizations.
    * `pheatmap`: For creating the cluster heatmap.
    * `DT` & `bslib`: For creating interactive tables and UI components.
    * `uwot`: For UMAP dimensionality reduction.
    * `rnndescent`: For UMAP dimensionality reduction.
* **Python Packages**
    * `pandas`: For data manipulation and cleaning.
    * `re`: For text processing
    * `country_list`: For matching country abbreviations to country names
    * `numpy`: For data manipulation and cleaning.
* **Hosting**: GitHub Pages.

---

## How to Run This Project

1.  **Clone the Repository**:
    ```bash
    git clone [https://github.com/Wes-Null/Wes-Null.github.io.git](https://github.com/Wes-Null/Wes-Null.github.io.git)
    ```
2.  **Open the Project**: Open the `.Rproj` file in RStudio.
3.  **Install Packages**: Run the provided `install_packages.R` script (or install the packages listed above manually).
4.  **Render the Website**: To preview the site locally, open the RStudio Terminal and run:
    ```bash
    quarto preview
    ```

---

## Project Structure

* `_quarto.yml`: The main configuration file for the Quarto website.
* `index.qmd`: The website's homepage.
* `/projects/Spotify_Cluster_Project/`: The main project folder containing the detailed analysis reports.
* `/data/`: Contains the final, clean dataset used in the analysis.
* `/images/`: Contains the static images used in the final report qmd.
* `README.md`: This file.
