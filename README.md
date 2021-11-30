Interactive report for consolidating cfMeDIP-seq metrics
========================================================
For project specific use ONLY


Requirements
-----------
- R 4.0 + 
  - R packages
    - ggplot2
    - reshape2
    - ramarkdown
    - shiny
    - RColorBrewer
    - ComplexHeatmap
    - circlize
    - flexdashboard
    - stringr
    - edgeR
    - gtools
- data.zip *

Usage
-------
      git clone https://github.com/oicr-gsi/cfMeDIPs-bakeoff-report-infra.git
      cd cfMeDIPs-bakeoff-report-infra/
      unzip data.zip
      Rscript run.R
      
  The app runs on this URL http://127.0.0.1:PORT/

  
*NOTE: data.zip is not distributed on this repo but can be obtained by emailing lawrence.heisler@oicr.on.ca.
