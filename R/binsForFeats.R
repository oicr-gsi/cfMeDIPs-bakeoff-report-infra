
library(ggplot2)

getGroup1BinCounts <- function(bin300bp.data.filter1, annotations, grp1, thres){
  # grp1 <- "Control_UHN"
  keepCols1 <- annotations[annotations$group == grp1,]
  keepCols1 <- unique(paste(keepCols1$Effective.sample.ID, keepCols1$IDENT, keepCols1$notes, sep = "_"))
  xcounts <- bin300bp.data.filter1[,keepCols1]
  xcounts$min <- apply(xcounts, 1, FUN=min)
  xcounts <- xcounts[xcounts$min > as.numeric(thres),]
  xcounts <- xcounts[,keepCols1]
  return(xcounts)
}

# subsetByThres <- function(xcounts, thres = 1){
#   if (thres == 0){
#     xcounts <- subset(xcounts, rowSums(xcounts) == 0)
#     # head(xcounts.0)
#   } else {
#     # xcounts <- subset(xcounts, rowSums(xcounts) >= thres)
#     xcounts$min <- apply(xcounts, 1, FUN=min)
#     xcounts <- xcounts[xcounts$min > as.numeric(thres),]
#     xcounts <- xcounts[,keepCols2]
#   }
#   return(xcounts)
# }


extractFeats <- function(xcounts.thres){
  feats.x <- row.names(xcounts.thres)
  return (feats.x)
}




# all.feats <- row.names(count)
# head(all.feats)

# feats in all other groups
getMinusBin1ReadCounts <- function(bin300bp.data.filter1,annotations,grp1,thres){
  grp2 <- unique(annotations$group)[!unique(annotations$group) %in% grp1]
  grp2.annotations <- annotations[annotations$group %in% grp2,]
  keepCols.grp2 <- paste(annotations$Effective.sample.ID, annotations$IDENT, annotations$notes, sep = "_")
  ycounts <- bin300bp.data.filter1[,keepCols.grp2]
  ycounts$min <- apply(ycounts, 1, FUN=min)
  ycounts <- ycounts[ycounts$min > as.numeric(thres),]
  ycounts <- ycounts[,keepCols.grp2]
  return(ycounts)
}

plotBins <- function(feats, xcounts, grp1, desc, scaleX=F){
  options(scipen = 99)
  # plot bin histogram for these regions for samples in protocols defined
  if (length(feats) > 0){
    # test 
    # feats.x.uncommon <- common.x.feats.thres.common.rest
    bin.ready.matrix <- xcounts[feats,]
    bin.ready.matrix.2 <- melt(bin.ready.matrix)
    head(bin.ready.matrix.2)
    plt <- ggplot(bin.ready.matrix.2) + 
      geom_histogram(aes(x = value), stat = "bin", position = "stack") + 
      theme_bw() + xlab(paste("300bp bins", desc, grp1))
    if (scaleX){
      plt <- plt + scale_x_log10()
    }
    
  } else {
    plt <- NA
  }
  return (plt)
}

plotCommonFeats <- function(feats.x,feats.y,xcounts, grp1, scaleX = T){
  common.x.feats.thres.common.rest <- feats.x[feats.x %in% feats.y] # bins common with the rest
  return(plotBins(common.x.feats.thres.common.rest, xcounts, grp1, "common with the rest in", scaleX))
}

plotUnCommonFeats <- function(feats.x,feats.y,xcounts, grp1, scaleX = T){
  feats.x.uncommon <- feats.x[!feats.x %in% feats.y] # bins not in x but in others
  return(plotBins(feats.x.uncommon, xcounts, grp1, "unique in", scaleX))
}

plotFeatsMissingCoverageInProtocol1 <- function(feats.x,feats.y,xcounts, grp1, scaleX= F){
  feats.not.in.x <- feats.y[!feats.y %in% feats.x] # bins missing coverage in in X protocol 
  return(plotBins(feats.not.in.x, xcounts, grp1, "with insufficient coverage in", scaleX))
}



# 

mainFunct <- function(bin300bp.data.filter1, grp1, annotations,thres = 1){
  
  xcounts.thres <- getGroup1BinCounts(bin300bp.data.filter1,annotations, grp1, thres)
  ycounts.thres <- getMinusBin1ReadCounts(bin300bp.data.filter1, annotations, grp1, thres)

  feats.y <- extractFeats(ycounts.thres)
  
  plt1 <- plotCommonFeats(feats.x,feats.y,xcounts, grp1)
  # if (class(plt) %in% c("gg", "ggplot"))
  print (plt1)
  plt2 <- plotUnCommonFeats(feats.x,feats.y,xcounts, grp1)
  # if(plt2 == N)
  print(plt2)
}


# # input
# annotationFile <- "/Volumes/gsiprojects/gsi/cfMeDIPs_validation/scripts/spikeins.txt"
# # RdataFile <- "/Volumes/gsiprojects/gsi/cfMeDIPs_validation/data/ROI_TGL61/cigarFlagTrue/merge/TGL61_merge_hg38-UCSC-CpG-promoters-islands-shelf-shore-inter_counts.RData"
# 
# annotations <- read.csv(annotationFile, sep = "\t")
# annotations <- unique(annotations[,c("sampleName", "Effective.sample.ID", "notes", "IDENT")])
# row.names(annotations) <- paste0(annotations$sampleName, "-deep")
# annotations$group <-  paste0(annotations$IDENT, "_", annotations$notes)
# head(annotations)
# 
# # attach(RdataFile)
# 
# bin300bp.data <- read.csv("~/Projects/GSI/medips_eval/data/aim3/binoccupancy/bin_coverage_counts.txt", 
#                           sep = "\t", as.is = T)
# 
# colnames(bin300bp.data) <- gsub("MEDIPS_hg38_", "", colnames(bin300bp.data))
# colnames(bin300bp.data) <- gsub(".deep_ws300_count.txt.gz", "", colnames(bin300bp.data))
# head(bin300bp.data)
# dim(bin300bp.data)
# 
# # bins with 0x common
# # filter that out
# bin300bp.data.filter1 <- subset(bin300bp.data, rowSums(bin300bp.data) > 0)
# dim(bin300bp.data.filter1)
# head(bin300bp.data.filter1)
# write.table(bin300bp.data.filter1,
#             "~/Projects/GSI/medips_eval/scripts/Report/data/binOccupancy/bin_coverage_counts_filter1.txt",
#             sep = "\t", row.names = T, col.names = T)
# 
# # bin300bp.data.filter1.test <- read.csv("~/Projects/GSI/medips_eval/data/aim3/binoccupancy/bin_coverage_counts_filter1.txt", 
# #                                        sep = "\t", as.is = T)
# # head(bin300bp.data.filter1.test)
# 
# sample.names <- paste0(colnames(bin300bp.data.filter1), "-deep")
# colnames(bin300bp.data.filter1) <- paste0(annotations[sample.names,]$Effective.sample.ID, "_",
#                                           annotations[sample.names,]$IDENT, "_", annotations[sample.names,]$notes)
# sample.names <- colnames(bin300bp.data.filter1)
# 
# head(bin300bp.data.filter1)
# 
# 
# 
# # coverage threshold
# # ==0
# # >=1,5,10,50,100,1000
# thres <- 50
# for (grp1 in unique(annotations$group)){
#   mainFunct(bin300bp.data.filter1, grp1, annotations,thres = thres)
#   break
# }
# 
# 
# 
# 
