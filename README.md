# YouTube QoE analysis is mostly located under `actual_measurement`

## `Python 3.8.12`, `pandas 1.3.3`, `numpy 1.21.2`, `seaborn 0.11.2`, `matplotlib 3.4.3` were used, however newer versions should work fine.

`./Vantage-Points-Map-basemap.ipynb` is used to draw the vantage points on a map, similar to `Vantage-Points-Map.ipynb` but using `basemap`.

### Methodology Section 4.1.6
`actual_measurement/youtube-make-buffer-timeline.ipynb`

### Results Section 5.1.1
`actual_measurement/error-analysis.ipynb` - note that this requires running `QoE-analysis.ipynb` beforehand to generate the `pickles`

### Results Section 5.1.2
`actual_measurement/URL-domain-name-analysis.ipynb`

### Results Section 5.1.3, 5.1.4
`actual_measurement/QoE-analysis.ipynb` - note that at the bottom of this notebook, `pickles` from `URL-domain-name-analysis.ipynb` are used

