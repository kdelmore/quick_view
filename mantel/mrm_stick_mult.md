---
title: "mrm_stick_mult"
author: "kira delmore"
date: "June 24, 2018"
output: 
  html_document: 
    keep_md: yes
---

#### load libs and data

```r
library(tidyverse)
library(ecodist)
```

#### loop code from mrm_stick.Rmd
#### you probably don't want to run this yourself so ive commented it out

```r
# results <- NA
# for (i in 1:1000){
# 
#   #### load data
#   cor.tidy <- read_csv("C:/Users/Kira/Desktop/stickleback/cor_out3b.csv")

  # #### pairs
  # 
  # boot <- c("boot_stream","boot_lake")
  # constance <- c("constance_stream","constance_lake")
  # geneva <- c("geneva_stream","geneva_lake")
  # joes <- c("joes_stream","joes_lake")
  # lq <- c("lq_benthic","lq_limnetic")
  # misty <- c("misty_stream","misty_lake")
  # pax <- c("pax_benthic","pax_limnetic")
  # pri <- c("pri_benthic","pri_limnetic")
  # roberts <- c("roberts_stream","roberts_lake")
  # 
  # #### randomly select one from each
  # 
  # random_boot <- sample(boot,1)
  # random_constance <- sample(constance,1)
  # random_geneva <- sample(geneva,1)
  # random_joes <- sample(joes,1)
  # random_lq <- sample(lq,1)
  # random_misty <- sample(misty,1)
  # random_pax <- sample(pax,1)
  # random_pri <- sample(pri,1)
  # random_roberts <- sample(roberts,1)
  # 
  # #### subset dataset based on random selections
  # 
  # cor.tidy <- cor.tidy[!grepl(random_boot, cor.tidy$pop_comp),]
  # cor.tidy <- cor.tidy[!grepl(random_constance, cor.tidy$pop_comp),]
  # cor.tidy <- cor.tidy[!grepl(random_geneva, cor.tidy$pop_comp),]
  # cor.tidy <- cor.tidy[!grepl(random_joes, cor.tidy$pop_comp),]
  # cor.tidy <- cor.tidy[!grepl(random_lq, cor.tidy$pop_comp),]
  # cor.tidy <- cor.tidy[!grepl(random_misty, cor.tidy$pop_comp),]
  # cor.tidy <- cor.tidy[!grepl(random_pax, cor.tidy$pop_comp),]
  # cor.tidy <- cor.tidy[!grepl(random_pri, cor.tidy$pop_comp),]
  # cor.tidy <- cor.tidy[!grepl(random_roberts, cor.tidy$pop_comp),]
#   
# #### get fst matrix together
# #### gregs loop
# 
# pops <- sort(unique(cor.tidy$pop2))
# 
# fst <- matrix(nrow = length(pops),ncol=length(pops))
# for (i in 1:length(pops)){
#   for (j in 1:length(pops)){
#     
#     tmp<- cor.tidy %>% filter(pop1 == pops[i], pop2 == pops[j]) %>% select(Correlation) %>% .$Correlation
#     if (length(tmp) == 1){
#       fst[i,j] <- tmp
#     }
#     
#   }
# }
# 
# ## have to flip this matrix
# ## i dont know why I can't figure this out more elegantly
# fst <- apply(fst, 2, rev)
# fst <- t(apply(fst, 2, rev))
# fst <- as.dist(fst)
# 
# #### get ecology matrix together
# #### binomial for now because im not sure where the qualitative variable is 
# #### there are two variables it could be but both have four categories and i think should only have 3
# 
# unique(cor.tidy$Ecology)
# cor.tidy$Ecology <- gsub("Same_Ecology","0",cor.tidy$Ecology)
# cor.tidy$Ecology <- gsub("Diff_Ecology","1",cor.tidy$Ecology)
# unique(cor.tidy$Ecology)
# 
# pops <- sort(unique(cor.tidy$pop2))
# 
# ecology <- matrix(nrow = length(pops),ncol=length(pops))
# for (i in 1:length(pops)){
#   for (j in 1:length(pops)){
#     
#     tmp<- cor.tidy %>% filter(pop1 == pops[i], pop2 == pops[j]) %>% select(Ecology) %>% .$Ecology
#     if (length(tmp) == 1){
#       ecology[i,j] <- tmp
#     }
#     
#   }
# }
# 
# ecology <- apply(ecology, 2, rev)
# ecology <- t(apply(ecology, 2, rev))
# ecology <- as.dist(ecology)

# #### get geography matrix together
# #### binomial for now because im not sure where the qualitative variable is 
# 
# unique(cor.tidy$Geography)
# cor.tidy$Geography <- gsub("Same_Ocean","0",cor.tidy$Geography)
# cor.tidy$Geography <- gsub("Diff_Ocean","1",cor.tidy$Geography)
# unique(cor.tidy$Geography)
# 
# pops <- sort(unique(cor.tidy$pop2))
# 
# geography <- matrix(nrow = length(pops),ncol=length(pops))
# for (i in 1:length(pops)){
#   for (j in 1:length(pops)){
#     
#     tmp<- cor.tidy %>% filter(pop1 == pops[i], pop2 == pops[j]) %>% select(Geography) %>% .$Geography
#     if (length(tmp) == 1){
#       geography[i,j] <- tmp
#     }
#     
#   }
# }
# 
# geography <- apply(geography, 2, rev)
# geography <- t(apply(geography, 2, rev))
# geography <- as.dist(geography)

# #### run MRM
# #### interpretation of result = both ecology and geography explain sign variation in pairwise fst
# #### based on para estimates geog more impt (not 100% we can use coefficients that way)
# z <- MRM(fst~ecology+geography,nperm = 10000)
# model_r <- z$r.squared[1]
# model_p <- z$r.squared[2]
# coef_ecol <- z$coef[2,1]
# coef_geog <- z$coef[3,1]
# p_ecol <- z$coef[2,2]
# p_geog <- z$coef[3,2]
# results_sample <- cbind(model_r,model_p,coef_ecol,coef_geog,p_ecol,p_geog)
# results <- rbind(results,results_sample)

# }
# results <- results[-1,]
```

#### so now we have a df with results for 1000 random selection of a pop from each pair

```r
load("C:/Users/Kira/Desktop/stickleback/results.R")
head(results)
```

```
##      model_r model_p   coef_ecol  coef_geog p_ecol p_geog
## R2 0.5544114   1e-04 -0.07128398 -0.2700473 0.0180  1e-04
## R2 0.5904706   5e-04 -0.03977170 -0.2795565 0.2152  1e-03
## R2 0.5348879   5e-04 -0.04689921 -0.2719739 0.2356  1e-04
## R2 0.5277045   2e-04 -0.06562277 -0.2625775 0.1014  2e-04
## R2 0.7004486   1e-04 -0.16764959 -0.2850116 0.0001  1e-04
## R2 0.5299151   1e-04 -0.05195173 -0.2609564 0.1018  1e-04
```

#### i dont really know how we want to report these results
#### summarized below (my mind can't calculate CI for columns right now, feel free to add)
#### count of replicates where ecology was sign and geog was sign

```r
summary(results[,1:ncol(results)])
```

```
##     model_r          model_p            coef_ecol          coef_geog      
##  Min.   :0.4735   Min.   :0.0001000   Min.   :-0.17167   Min.   :-0.3087  
##  1st Qu.:0.5228   1st Qu.:0.0001000   1st Qu.:-0.08217   1st Qu.:-0.2823  
##  Median :0.5459   Median :0.0001000   Median :-0.06690   Median :-0.2711  
##  Mean   :0.5535   Mean   :0.0001756   Mean   :-0.07052   Mean   :-0.2713  
##  3rd Qu.:0.5798   3rd Qu.:0.0002000   3rd Qu.:-0.05304   3rd Qu.:-0.2603  
##  Max.   :0.7232   Max.   :0.0010000   Max.   :-0.03057   Max.   :-0.2369  
##      p_ecol            p_geog         
##  Min.   :0.00010   Min.   :0.0001000  
##  1st Qu.:0.01340   1st Qu.:0.0001000  
##  Median :0.05145   Median :0.0001000  
##  Mean   :0.08099   Mean   :0.0001723  
##  3rd Qu.:0.11678   3rd Qu.:0.0002000  
##  Max.   :0.39570   Max.   :0.0015000
```

```r
nrow(results[results[, "p_ecol"] <= 0.05,])
```

```
## [1] 490
```

```r
nrow(results[results[, "p_geog"] <= 0.05,])
```

```
## [1] 1000
```
