---
title: "mrm_stick_mult_qual"
author: "kira delmore"
date: "Sept 24, 2018"
output: 
  html_document: 
    keep_md: yes
---

#### load libs and data

```r
library(tidyverse)
library(ecodist)
```

#### loop code from mrm_stick_qual.Rmd
#### you probably don't want to run this yourself so ive commented it out

```r
# results <- NA
# for (i in 1:1000){

#   #### load data
#   cor.tidy <- read_csv("C:/Users/Kira/Desktop/stickleback/cor_out3b_continuous_distance.csv")
# 
#   #### pairs
#   
#   boot <- c("boot_stream","boot_lake")
#   constance <- c("constance_stream","constance_lake")
#   geneva <- c("geneva_stream","geneva_lake")
#   joes <- c("joes_stream","joes_lake")
#   lq <- c("lq_benthic","lq_limnetic")
#   misty <- c("misty_stream","misty_lake")
#   pax <- c("pax_benthic","pax_limnetic")
#   pri <- c("pri_benthic","pri_limnetic")
#   roberts <- c("roberts_stream","roberts_lake")
#   
#   #### randomly select one from each
#   
#   random_boot <- sample(boot,1)
#   random_constance <- sample(constance,1)
#   random_geneva <- sample(geneva,1)
#   random_joes <- sample(joes,1)
#   random_lq <- sample(lq,1)
#   random_misty <- sample(misty,1)
#   random_pax <- sample(pax,1)
#   random_pri <- sample(pri,1)
#   random_roberts <- sample(roberts,1)
#   
#   #### subset dataset based on random selections
#   
#   cor.tidy <- cor.tidy[!grepl(random_boot, cor.tidy$pop_comp),]
#   cor.tidy <- cor.tidy[!grepl(random_constance, cor.tidy$pop_comp),]
#   cor.tidy <- cor.tidy[!grepl(random_geneva, cor.tidy$pop_comp),]
#   cor.tidy <- cor.tidy[!grepl(random_joes, cor.tidy$pop_comp),]
#   cor.tidy <- cor.tidy[!grepl(random_lq, cor.tidy$pop_comp),]
#   cor.tidy <- cor.tidy[!grepl(random_misty, cor.tidy$pop_comp),]
#   cor.tidy <- cor.tidy[!grepl(random_pax, cor.tidy$pop_comp),]
#   cor.tidy <- cor.tidy[!grepl(random_pri, cor.tidy$pop_comp),]
#   cor.tidy <- cor.tidy[!grepl(random_roberts, cor.tidy$pop_comp),]
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

# ## have to flip this matrix
# ## i dont know why I can't figure this out more elegantly
# fst <- apply(fst, 2, rev)
# fst <- t(apply(fst, 2, rev))
# fst <- as.dist(fst)
# 
# #### get ecology matrix together
# cor.tidy$Qual_ecology_score <- ordered(cor.tidy$Qual_ecology_score,levels=c("3","2","1","0"))
# pops <- sort(unique(cor.tidy$pop2))
# 
# ecology <- matrix(nrow = length(pops),ncol=length(pops))
# for (i in 1:length(pops)){
#   for (j in 1:length(pops)){
#     
#     tmp<- cor.tidy %>% filter(pop1 == pops[i], pop2 == pops[j]) %>% select(Qual_ecology_score) %>% .$Qual_ecology_score
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

# #### get euc matrix together
# 
# cor.tidy$euc.distance <- as.numeric(cor.tidy$euc.distance)
# 
# pops <- sort(unique(cor.tidy$pop2))
# 
# euc <- matrix(nrow = length(pops),ncol=length(pops))
# for (i in 1:length(pops)){
#   for (j in 1:length(pops)){
#     
#     tmp<- cor.tidy %>% filter(pop1 == pops[i], pop2 == pops[j]) %>% select(euc.distance) %>% .$euc.distance
#     if (length(tmp) == 1){
#       euc[i,j] <- tmp
#     }
#     
#   }
# }
# 
# euc <- apply(euc, 2, rev)
# euc <- t(apply(euc, 2, rev))
# euc <- as.dist(euc)

# #### run MRM
# z <- MRM(fst~ecology+euc,nperm = 10000)
# model_r <- z$r.squared[1]
# model_p <- z$r.squared[2]
# coef_ecol <- z$coef[2,1]
# coef_geog <- z$coef[3,1]
# p_ecol <- z$coef[2,2]
# p_geog <- z$coef[3,2]
# results_sample <- cbind(model_r,model_p,coef_ecol,coef_geog,p_ecol,p_geog)
# results <- rbind(results,results_sample)
# 
# }
# results <- results[-1,]
```

#### so now we have a df with results for 1000 random selection of a pop from each pair

```r
load("C:/Users/Kira/Desktop/stickleback/results_qual.R")
head(results)
```

```
##      model_r model_p   coef_ecol     coef_geog p_ecol p_geog
## R2 0.5459543   1e-04 -0.06315225 -3.758737e-05 0.0159  1e-04
## R2 0.5015645   8e-04 -0.03672503 -3.530937e-05 0.0978  6e-04
## R2 0.5522886   3e-04 -0.03936739 -3.847380e-05 0.0870  3e-04
## R2 0.5803616   2e-04 -0.08515431 -3.596447e-05 0.0013  2e-04
## R2 0.4634700   6e-04 -0.04140971 -3.431471e-05 0.0946  4e-04
## R2 0.5345066   8e-04 -0.03429281 -3.758543e-05 0.1448  8e-04
```

#### i dont really know how we want to report these results
#### summarized below (my mind can't calculate CI for columns right now, feel free to add)
#### count of replicates where ecology was sign and geog was sign

```r
summary(results[,1:ncol(results)])
```

```
##     model_r          model_p            coef_ecol       
##  Min.   :0.4348   Min.   :0.0001000   Min.   :-0.11145  
##  1st Qu.:0.4982   1st Qu.:0.0002000   1st Qu.:-0.06188  
##  Median :0.5232   Median :0.0004000   Median :-0.04558  
##  Mean   :0.5279   Mean   :0.0004388   Mean   :-0.04952  
##  3rd Qu.:0.5566   3rd Qu.:0.0006000   3rd Qu.:-0.03656  
##  Max.   :0.6802   Max.   :0.0016000   Max.   :-0.02474  
##    coef_geog              p_ecol            p_geog         
##  Min.   :-4.110e-05   Min.   :0.00010   Min.   :0.0001000  
##  1st Qu.:-3.746e-05   1st Qu.:0.01777   1st Qu.:0.0002000  
##  Median :-3.618e-05   Median :0.06025   Median :0.0004000  
##  Mean   :-3.610e-05   Mean   :0.09288   Mean   :0.0003846  
##  3rd Qu.:-3.486e-05   3rd Qu.:0.14458   3rd Qu.:0.0005000  
##  Max.   :-2.946e-05   Max.   :0.37430   Max.   :0.0014000
```

```r
nrow(results[results[, "p_ecol"] <= 0.05,])
```

```
## [1] 454
```

```r
nrow(results[results[, "p_geog"] <= 0.05,])
```

```
## [1] 1000
```
