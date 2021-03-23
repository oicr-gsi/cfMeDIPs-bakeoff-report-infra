subsetCountMatrix <- function(count, site_level, annotations, protocol){
  # returns a list of matrices for group wise comparison
  count_site <- count
  if (site_level != "allsites"){
    count_site <- count[grepl(site_level, count$regions),]
    # count_site <- count[keepRows,]
  }
  
  # protocol <- unique(annotations$protocol)[[i]]
  annotations.groups <- annotations[annotations$group == protocol,]
  
  keepSampleIDs <- paste0(annotations.groups$Effective.sample.ID,
                          "_", annotations.groups$notes, "_",
                          annotations.groups$IDENT)
  count_site <- count_site[, c(keepSampleIDs, "regions")]
  reg <- count_site$regions
  count_site <- count_site[,-dim(count_site)[2]]
  row.names(count_site) <- reg
  return (count_site)
}

findDiagonals <- function(matr,rindex, cindex){
  lg <- F
  rn <- row.names(matr)[rindex]
  rn <- gsub("-Control-2-cfDNA", "",stringr::str_split_fixed(rn, "_", 3)[,1])
  cn <- colnames(matr)[cindex]
  cn <- gsub("-Control-2-cfDNA", "",stringr::str_split_fixed(cn, "_", 3)[,1])
  if (rn == cn){
    lg <- TRUE
  }
  return (lg)
}

normalizeCounts <- function(count.data, total.reads){
  # count.data is the count matrix 
  # count data matrix is row = bin/regions cols = sample.name
  # total.reads is the matrix of total reads post dedup
  # total.reads.matrix looks like row = total reads; cols = sample name
  # for each column; counts[,sample.name]/total.reads[,sample.name]
}