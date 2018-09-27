---
title: "mrm_stick_fst_comp_v2"
output: 
  html_document: 
    keep_md: yes
---

#### load libs and data

```r
library(tidyverse)
library(ecodist)
cor.tidy <- read_csv("C:/Users/Kira/Desktop/stickleback/cor_out_fresh_fresh_marine_freshb_v2.csv") 
```

#### get fst matrix and diverg/non-diverg matrix

```r
cor.tidy %>% 
  unite(pop_pair1,pop1, type1, pop2,type2,sep="-") %>%
  unite(pop_pair2, pop3, type3, pop4,type4,sep="-") -> cor.tidy

pops <- sort(unique(c(unique(cor.tidy$pop_pair1), unique(cor.tidy$pop_pair2))))

fst <- matrix(nrow = length(pops),ncol=length(pops))
for (i in 1:length(pops)){
  for (j in i:length(pops)){
    
    tmp<- cor.tidy %>% filter(pop_pair1 == pops[i] & pop_pair2 == pops[j]) %>% select(Correlation) %>% .$Correlation
    if (length(tmp) == 0){
      tmp<- cor.tidy %>% filter(pop_pair1 == pops[j] & pop_pair2 == pops[i]) %>% select(Correlation) %>% .$Correlation
    }
    if (length(tmp) == 1){
      fst[i,j] <- tmp
    }
    
  }
}
```

```
## Warning: package 'bindrcpp' was built under R version 3.4.4
```

```r
fst <- apply(fst, 2, rev)
fst <- t(apply(fst, 2, rev))
fst <- as.dist(fst)

cor.tidy$Comparison <- gsub("Non Divergent Selection","0",cor.tidy$Comparison)
cor.tidy$Comparison <- gsub("Parallel Divergent Selection","1",cor.tidy$Comparison)

comparison <- matrix(nrow = length(pops),ncol=length(pops))
for (i in 1:length(pops)){
  for (j in i:length(pops)){
    
    tmp<- cor.tidy %>% filter(pop_pair1 == pops[i], pop_pair2 == pops[j]) %>% select(Comparison) %>% .$Comparison
    if (length(tmp) == 0){
      tmp<- cor.tidy %>% filter(pop_pair1 == pops[j] & pop_pair2 == pops[i]) %>% select(Comparison) %>% .$Comparison
    }
    if (length(tmp) == 1){
      comparison[i,j] <- tmp
    }
    
  }
}

comparison <- apply(comparison, 2, rev)
comparison <- t(apply(comparison, 2, rev))
comparison <- as.dist(comparison)
```

#### easiest to see comparison matrix

```r
pops
```

```
##  [1] "boot-lake-joes-lake"           "boot-lake-misty-lake"         
##  [3] "boot-lake-roberts-lake"        "joes-lake-misty-lake"         
##  [5] "joes-lake-roberts-lake"        "misty-lake-roberts-lake"      
##  [7] "pacific-marine-bea-lake"       "pacific-marine-boot-lake"     
##  [9] "pacific-marine-boot-stream"    "pacific-marine-joes-lake"     
## [11] "pacific-marine-joes-stream"    "pacific-marine-lq-benthic"    
## [13] "pacific-marine-lq-limnetic"    "pacific-marine-misty-lake"    
## [15] "pacific-marine-misty-stream"   "pacific-marine-mud-lake"      
## [17] "pacific-marine-pax-benthic"    "pacific-marine-pax-limnetic"  
## [19] "pacific-marine-pcr-lake"       "pacific-marine-pri-benthic"   
## [21] "pacific-marine-pri-limnetic"   "pacific-marine-roberts-lake"  
## [23] "pacific-marine-roberts-stream" "pacific-marine-wc-stream"     
## [25] "pcr-lake-boot-lake"            "pcr-lake-joes-lake"           
## [27] "pcr-lake-misty-lake"           "pcr-lake-roberts-lake"
```

```r
comparison
```

```
##     1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
## 2  NA                                                                     
## 3  NA NA                                                                  
## 4  NA NA  0                                                               
## 5  NA  0 NA NA                                                            
## 6   0 NA NA NA NA                                                         
## 7  NA NA NA NA NA NA                                                      
## 8  NA NA NA NA NA NA  1                                                   
## 9  NA NA NA NA NA NA  1 NA                                                
## 10 NA NA NA NA NA NA  1  1  1                                             
## 11 NA NA NA NA NA NA  1  1  1 NA                                          
## 12 NA NA NA NA NA NA  1  1  1  1  1                                       
## 13 NA NA NA NA NA NA  1  1  1  1  1 NA                                    
## 14 NA NA NA NA NA NA  1  1  1  1  1  1  1                                 
## 15 NA NA NA NA NA NA  1  1  1  1  1  1  1 NA                              
## 16 NA NA NA NA NA NA  1  1  1  1  1  1  1  1  1                           
## 17 NA NA NA NA NA NA  1  1  1  1  1  1  1  1  1  1                        
## 18 NA NA NA NA NA NA  1  1  1  1  1  1  1  1  1  1 NA                     
## 19 NA NA NA NA NA NA  1  1  1  1  1  1  1  1  1  1  1  1                  
## 20 NA NA NA NA NA NA  1  1  1  1  1  1  1  1  1  1  1  1  1               
## 21 NA NA NA NA NA NA  1  1  1  1  1  1  1  1  1  1  1  1  1 NA            
## 22 NA NA NA NA NA NA  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1         
## 23 NA NA NA NA NA NA  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1 NA      
## 24 NA NA NA NA NA NA  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1   
## 25 NA NA NA  0  0  0 NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## 26 NA  0  0 NA NA  0 NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## 27  0 NA  0 NA  0 NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## 28  0  0 NA  0 NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
##    25 26 27
## 2          
## 3          
## 4          
## 5          
## 6          
## 7          
## 8          
## 9          
## 10         
## 11         
## 12         
## 13         
## 14         
## 15         
## 16         
## 17         
## 18         
## 19         
## 20         
## 21         
## 22         
## 23         
## 24         
## 25         
## 26 NA      
## 27 NA NA   
## 28 NA NA NA
```

