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

  
*NOTE: Please email Prisni.Rath@oicr.on.ca for the link to data.zip for visualization here.
