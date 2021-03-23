
neatCounts <- function(count, ant){
  # rm(count)
  # attach("~/Projects/GSI/medips_eval/scripts/Report/data/roiCounts/TGL61_merge_hg38-UCSC-CpG-promoters-islands-shelf-shore-inter_counts.RData")
  # ant <- getAnt()
  sample.names <- colnames(count)
  colnames(count) <- paste0(ant[sample.names,]$Effective.sample.ID,
                            "_", ant[sample.names,]$notes, "_",
                            ant[sample.names,]$IDENT)
  sample.names <- colnames(count)
  return (count)
}

# count$regions <- row.names(count)
# write.table(count, "~/Projects/GSI/medips_eval/scripts/Report/data/roiCounts/TGL61_merge_hg38-UCSC-CpG-promoters-islands-shelf-shore-inter_counts.txt", 
#                   sep = "\t",col.names = T, row.names = F, quote = F)
