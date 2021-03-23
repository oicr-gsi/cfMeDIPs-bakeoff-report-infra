
drawHeatCorrelationHeatMap <- function(corr.count.matrix, site_level, protocol1, 
                                       protocol2, 
                                       annotations,
                                       outDir, 
                                       clusterFlag = FALSE){
  corr.count <- corr.count.matrix
  # print (dim(corr.count))
  min.val <- min(corr.count)
  mid.val <- median(corr.count)
  max.val <- max(corr.count)
  col_fun = colorRamp2(c(min.val, mid.val, max.val), c("yellow", "red", "blue"))
  # col_fun(seq(-3, 3))
  
  annotation_df <- annotations
  # annotation_df.x <- annotation_df[annotation_df$group == protocol1,]
  # annotation_df.y <- annotation_df[annotation_df$group == protocol2,]
  anno1 <- HeatmapAnnotation(df = annotation_df[,c("IDENT", "notes")],
                             border = TRUE,
                             simple_anno_size = unit(1, "cm"))
  anno2 <- rowAnnotation(group = annotation_df[,c("group")], 
                         border = TRUE, 
                         simple_anno_size = unit(1, "cm"))
  
  rowlabs <- stringr::str_split_fixed(rownames(corr.count), 
                                      "_", 3)[,1]
  rowlabs <-  paste0(stringr::str_split_fixed(rowlabs, "-", 3)[,1], "-", stringr::str_split_fixed(rowlabs, "-", 3)[,2])
  collabs <- stringr::str_split_fixed(colnames(corr.count), 
                                      "_", 3)[,1]
  collabs <-  paste0(stringr::str_split_fixed(collabs, "-", 3)[,1], "-", stringr::str_split_fixed(rowlabs, "-", 3)[,2])
  
  Heatmap(corr.count, name = "Pairwise correlation between different protocols", 
                col = col_fun,
                row_names_gp = gpar(fontsize = 15),
                column_names_gp = gpar(fontsize = 15),
                top_annotation = anno1,
                left_annotation = anno2,
                # show_column_names = FALSE,
                cluster_columns = clusterFlag,
                row_labels = rowlabs,
                column_labels = collabs,
                column_title = protocol2,
                row_title = protocol1,
                cell_fun = function(j, i, x, y, width, height, fill) {
                  grid.text(sprintf("%.1f", corr.count[i, j]), x, y, gp = gpar(fontsize = 20))
                })
  # dev.off()
  
}
