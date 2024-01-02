
## package development

[![License: GPLv3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
![R](https://img.shields.io/badge/R-%3E%3D%202.10-blue)
![R CMDcheck](https://img.shields.io/badge/R%20CMD%20check-passing-green)
![Coverage](https://img.shields.io/badge/coverage-60%60-yellow)

## morphalr: Morphological Analysis for Archaeology

A package to compute morphological indices of spatial entities (e.g. parcels, buildings). It also provides computation of multivariate statistics results (HCA/PCA).

## Installing

Package currently exist as development on github.

Install package from github:

``` r
library(remotes)
install_github(repo = "JGravier/morphalr")
```

## Morphological indices

| Function name                  | Indices                                                   |     Implementation |
|:-------------------------------|:----------------------------------------------------------|-------------------:|
| morphalr_segment_orientation() | orientations of segments of polygons or lines             | :white_check_mark: |
| morphalr_dsr()                 | distance of polygons to their minimal bounding rectangles | :white_check_mark: |
| morphalr_dsc()                 | distance of polygons to their convex hull                 | :white_check_mark: |
| morphalr_circularity()         | Miller circularity index of polygons                      | :white_check_mark: |
| morphalr_complexity()          | morphological complexity of polygons                      | :white_check_mark: |
|                                | elongation (Schum)                                        |             :soon: |
|                                | spreading (Morton)                                        |             :soon: |
|                                | compacity (Thibault et al.)                               |             :soon: |
|                                | compactity 2 (Cauvin and Rimbert)                         |             :soon: |
|                                | compacity 3 (Gravelius)                                   |             :soon: |
|                                | stretching                                                |             :soon: |
|                                | area concavity                                            |             :soon: |
|                                | inverse of perimeter concavity                            |             :soon: |
