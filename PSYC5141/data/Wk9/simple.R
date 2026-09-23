simple <- function(cellTotals,anovaTable,fixed,across){

  # DESCRIPTION: Function for generating "pooled error term" simple 
  # main effects for the anova_test() function in the rstatix library.
  #
  # cellTotals - dataframe containing cell totals and counts
  # anovaTable - dataframe containing the omnibus ANOVA outcomes 
  #              from anova_test
  # fixed      - The factor for which the simple main effects are being
  #              computed
  # across     - The second factor for which the simple main effects will
  #              be evaluated at each of its levels
  #
  # REFERENCES 
  # Roberts, M. J., & Russo, R. (1999, Chapter 10). A student’s guide to 
  # Analysis of Variance. Routledge: London.
  #....................................................................
  # Mark Hurlstone, m.hurlstone@lancaster.ac.uk
  # Created: Tue 22 Nov 2022
  
  
  # 1. Determine the number of simple main effects of the "across" factor
  acrossNl = length(levels(cellTotals[[across]]))

  # 2. Initialize variables for ANOVA table
  #--------------------------------------------------------------------
  levels = matrix(data = 0, ncol= 1, nrow = acrossNl+1)
  levels[1:acrossNl] = matrix(levels(cellTotals[[across]]))
  levels[acrossNl+1] = "Error term"
  ss  = matrix(0,acrossNl+1,1)
  df  = matrix(0,acrossNl+1,1)
  ms  = matrix(0,acrossNl+1,1)
  f   = matrix(0,acrossNl+1,1)
  p   = matrix(0,acrossNl+1,1)  
  eta = matrix(0,acrossNl+1,1) 
  
  # 3. Calculate between-group variances and degrees of freedom
  #--------------------------------------------------------------------
  n = mean(cellTotals$n)
  fixedNl = length(levels(cellTotals[[fixed]]))
  c = 0
  for (i in levels(cellTotals[[across]])){
    c = c+1
    idx = which(cellTotals[[across]] == i)
    ss[c] = sum(cellTotals$sum[idx]^2)/n - sum(cellTotals$sum[idx])^2/(n*fixedNl) 
    df[c] = length(levels(cellTotals[[fixed]])) - 1
  }
  
  # 4. Get the error-variance and degrees of freedom
  #--------------------------------------------------------------------
  getRow = anovaTable == fixed
  ss[acrossNl+1,1] = anovaTable[getRow,5]
  df[acrossNl+1,1] = anovaTable[getRow,3]
  
  # 5. Calculate mean squares
  #--------------------------------------------------------------------
  ms = ss/df
  
  # 6. Calculate F values
  #--------------------------------------------------------------------
  f[1:acrossNl] = ms[1:acrossNl]/ms[acrossNl+1]
  
  # 7. Calculate p values
  #--------------------------------------------------------------------
  for (i in 1:acrossNl){
    p[i] = pf(f[i], df[i], df[acrossNl+1], lower.tail = FALSE)
  }
  #f[acrossNl+1] = ""
  #p[acrossNl+1] = "" 
  
  # 8. Prepare the simple main effects table
  #--------------------------------------------------------------------
  seTable = data.frame(levels,ss,df,ms,f,p)
  colnames(seTable) = c("Levels","Sum of Squares","Degrees of Freedom",
    "Mean Square","F","P")
  return(seTable)
}
 