
## package development

[![License: GPL
v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
![R](https://img.shields.io/badge/R-%3E%3D%202.10-blue) ![R CMD
check](https://img.shields.io/badge/R%20CMD%20check-passing-green)
![Coverage](https://img.shields.io/badge/coverage-30%25-red)

## morphalr: Morphological Analysis for Archaeology

A package to compute morphological indices of spatial entities
(e.g. parcels, buildings). It also provides visuals of multivariate
statistics results (ACP and HCA).

## Installing

Package currently exist as development on github.

Install package from github:

``` r
library(remotes)
install_github(repo = "JGravier/morphalr")
```

## Compute orientations from polygon

Load data of parcels of the city of Rouen in 1827 and extract segments
(lines) from polygons.

``` r
library(tidyverse)
library(sf)
library(morphalr)

# transform polygons as segments (lines)
linerouen <- morphalr_geom_to_segment(sfobject = rouen_1827, to = 'LINESTRING')
```

`morphal_geom_to_segment()` can be applied on LINESTRING, e.g. in the
case of streets modeled as lines.

Compute orientations of segments with East looking and perpendicular
parameters.

``` r
orientationsest <- morphalr_segment_orientation(sfsegments = linerouen, looking = 'E', perpendicular = TRUE)

orientationsest |>
  ggplot() +
  geom_sf(aes(color = orientation)) +
  scale_color_viridis_c() +
  theme_bw() +
  theme(axis.ticks = element_blank(), axis.text = element_blank())
```

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

## Compute morphological indices

Example with distance to minimal bounding rectangle (DSR):

``` r
rouen_1827 |>
  morphalr_dsr() |>
  ggplot() +
  geom_sf(aes(fill = dsr), color = 'grey90', linewidth = 0.05) +
  scale_fill_viridis_c(direction = -1) +
  theme_bw() +
  theme(axis.ticks = element_blank(), axis.text = element_blank())
```

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

## Morphological indices implemented

| Function name                | Indices                                                   |
|:-----------------------------|:----------------------------------------------------------|
| morphalr_segment_orientation | orientations of segments of polygons or lines             |
| morphalr_dsr()               | distance of polygons to their minimal bounding rectangles |
| morphalr_dsc()               | distance of polygons to their convex hull                 |
| morphalr_circularity()       | Miller circularity index of polygons                      |
| morphalr_complexity()        | morphological complexity of polygons                      |
