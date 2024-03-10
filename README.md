
## Package development

[![License: GPLv3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
![R](https://img.shields.io/badge/R-%3E%3D%202.10-blue)
![R CMDcheck](https://img.shields.io/badge/R%20CMD%20check-passing-green)
![Coverage](https://img.shields.io/badge/coverage-60%25-yellow)

## mafa: Morphological Analysis for Archaeology

A package to compute morphological indices of spatial entities (e.g. parcels, buildings). It also provides computation of multivariate statistics results.

## Installing

Package currently exist as development on github.

Install package from github:

``` r
library(remotes)
install_github(repo = "JGravier/mafa")
```

## Overview
mafa is an R package for calculating morphological indices of spatial units (e.g. plots, buildings, roads), frequently used in archaeology and archaeography. It is inspired by the morphometric and orientation index calculations of MorphAl, a QGIS plugin (Robert et al. 2014) developed by E. Grosso (Grosso 2021), and the complexity index proposed in Marie et al (2009). mafa implements, as a wrapper, multivariate statistical processing applied to spatial units and usually performed in the field of quantitative geography (Sanders 1989, Commenges et al. 2014). The package is currently under development and the short-term objective is to integrate the index calculations used in the Archaedyn program to study agrarian and parcel structures (Gauthier et al. 2022, see in particular indices p. 65).

**References**

Beauguitte, Laurent, Élodie Buard, Robin Cura, Florent Le Néchet, Marion Le Texier, Hélène Mathian, et Sébastien Rey. 2014. _R et espace. Traitement de l’information géographique._ Édité par Hadrien Commenges. Lyon: Framasoft. [http://framabook.org/r-et-espace/](http://framabook.org/r-et-espace/).

Gauthier, Estelle, Murielle Georges-Leroy, Nicolas Poirier, et Olivier Weller, éd. 2022. _ARCHAEDYN. Dynamique spatiale des territoires de la Préhistoire au Moyen Âge. Volume 1._ Les Cahiers de la MSHE Ledoux. Besançon: Presses universitaires de Franche-Comté. [http://books.openedition.org/pufc/46572](http://books.openedition.org/pufc/46572).

Grosso, Éric. 2021. « MorphAL: PTM plugin for QGIS ». Python version 1.0.0. [https://github.com/paristimemachine/ptm4qgis-morphal](https://github.com/paristimemachine/ptm4qgis-morphal).

Marie, Maxime, Abdelkrim Bensaid, et Daniel Delahaye. 2009. « Le rôle de la distance dans l’organisation des pratiques et des paysages agricoles : l’exemple du fonctionnement des exploitations laitières dans l’arc atlantique ». _Cybergeo: European Journal of Geography_. [https://doi.org/10.4000/cybergeo.22366](https://doi.org/10.4000/cybergeo.22366).

Robert, Sandrine, Éric Grosso, Pascal Chareille, et Hélène Noizet. 2014. « MorphAL (Morphological Analysis) : un outil d’analyse de morphologie urbaine ». In _Archéologie de l’espace urbain_, édité par Elisabeth Lorans et Xavier Rodier, 451‑63. Perspectives Villes et Territoires. Tours: Presses universitaires François-Rabelais. [https://doi.org/10.4000/books.pufr.7717](https://doi.org/10.4000/books.pufr.7717).

Sanders, Lena. 1989. _L’Analyse des données appliquée à la géographie_. Collection Alidade. Montpellier: RECLUS.


## Indices and statistics

| Function name              | Indices                                                   |     Implementation |
|:---------------------------|:----------------------------------------------------------|-------------------:|
| mafa_segment_orientation() | orientations of segments of polygons or linestring        | :white_check_mark: |
| mafa_dsr()                 | distance of polygons to their minimal bounding rectangles | :white_check_mark: |
| mafa_dsc()                 | distance of polygons to their convex hull                 | :white_check_mark: |
| mafa_circularity()         | Miller circularity index of polygons                      | :white_check_mark: |
| mafa_complexity()          | morphological complexity of polygons                      | :white_check_mark: |
| mafa_clustering()          | clustering of spatial units based on HCA on PCA           | :white_check_mark: |
| mafa_clusters()            | add clusters of spatial units from a selected cutting threshold of a hclust object   | :white_check_mark: |
| mafa_clusters_mean()       | compute mean of center-scale values of columns group by cluster     | :white_check_mark: |
|                            | elongation                                                |             :soon: |
|                            | spreading                                                 |             :soon: |
|                            | compacity                                                 |             :soon: |
|                            | compactity 2                                              |             :soon: |
|                            | compacity 3                                               |             :soon: |
|                            | stretching                                                |             :soon: |
|                            | area concavity                                            |             :soon: |
|                            | inverse of perimeter concavity                            |             :soon: |
