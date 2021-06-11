# DecisionTree "분류" 분석

#############################################
## Chapter15_4_1. 분류분석(Decision Tree)
#############################################

## 1. party 패키지 적용 분류분석

## [실습1] ctree  함수 이용 의사결정트리 생성하기

setwd('C:/downloads/Rwork/Part-IV')

# 단계1 : part패키지 설치
install.packages("party")
library(party) # ctree() 제공

# 단계2 : airquality 데이터 셋 로딩
library(datasets)
str(airquality)
head(airquality)
# 150개 관측치, att 6개, 대기에 관해. 

# 단계3 : formula 생성 (Target Att 설정)
# ~ 기준 왼쪽 : target, 오른쪽 : 설명Att
formula <-  Temp ~ Solar.R +  Wind + Ozone
# 유효한 설명 Att 설정 --- 
#(연속형)종속 변수간의 상관계수 고려
#(이산형) 평균의 검정등을 통해 고려

# 단계4 : 분류모델 생성 : formula를 이용하여 분류모델 생성 
air_ctree <- ctree(formula, data=airquality) 
# conditional inference tree #통계적검정
air_ctree

# 단계5  : 분류분석 결과
plot(air_ctree)
# statistic <= 설정된 변수중 유의한 형태 스플릿 : 통계치
# criterion : 1-p value값 : 1에 가까울수록 유용함. 
# *** p-value 작을수록 유용한 것.


# 경로를 따라 내려온 분류조건 subset 작성/확인 
result <- subset(airquality, Ozone <= 37 & Wind > 15.5)
dim(result)
result #그래프에는 7개로 나오는데, 여기선 5개의 record 값만있음.
# 이유는?
result2 <- subset(airquality, Ozone > 37 & Ozone <= 65)
dim(result2)
result3 <- subset(airquality, Ozone > 37 & Ozone > 65)
dim(result3)
result4 <- subset(airquality, Ozone > 37)
dim(result4)
result5 <- subset(airquality, Ozone <= 37)
dim(result5)
# 전체 데이터가 약 150개여야하는데, subset 에 있는 데이터는 총 120개정도밖에 안된다.
# 이유는?
sum(is.na(airquality$Ozone))
# 오존을 att 로 가진 data가 약 30개정도 없기때문.
# 즉, 결측치를 데이터전처리 하지않고 바로 분석했기때문.
# None 이 그래프상(의사결정나무상)에서는 <= 로 갔음.
summary(result$Temp)
result$Temp
