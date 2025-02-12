library(R2BayesX)
library(sp)
library(rgdal)
library(BayesX)

setwd("R:/Dissertation Projects/LifeExp_LILA")

data = read.table("LILA_BayesX.txt", header = T)
names(data)

dir="C:/temp"

prg_food <- file.path(dir, "food.prg")
#
#write.table(scenario1, file.path(dir, "data.raw"),quote = FALSE, row.names = F)
#
## create the .prg file, here use the bayesx code: paste it here, and change the / to /
writeLines("bayesreg b
            dataset d
            d.infile using R:/Dissertation Projects/LifeExp_LILA/LILA_BayesX.txt
            map m
            m.infile using R:/Dissertation Projects/LifeExp_LILA/USAtrc10_12.bnd
            logopen using C:/temp/food.log
            b.outfile = C:/temp/food.log
            b.regress LifeExp = edu + non_white + vHILA + vLIHA + vLILA + popdensity + STFID10(geospline,map=m) + STFID10(random), family=gaussian predict iterations=2000 burnin=500 step=10  using d
            b.getsample
            logclose
            ", prg_food)

## run the .prg file from R
run.bayesx(prg_food)

## explore the log file, and plot the results by copying the .res file directory

res <-read.table("C:/temp/food.log_f_STFID10_geospline.res", header = TRUE)

amp = read.bnd("R:/Dissertation Projects/LifeExp_LILA/USAtrc10_12.bnd")

drawmap(res, map=amp, plotvar=pcat95, regionvar=STFID10, legent=F, borders=F, pcat=T)

#res$expmean=exp(res$pmean)
#write.csv(res,'R:/Dissertation Projects/New Index/Landscape Metrics/spatial_08.csv')


fixeff <- read.table("C:/temp/food.log_FixedEffects1.res", header=TRUE)
write.csv(fixeff,'fixed_vfully_adj_pd.csv')


reg = lm(data$LifeExp ~ data$edu + data$non_white + data$LIHA + data$HILA + data$LILA + as.character(data$state), weights = data$wgts)
summary(reg)




