
## [실습4] 고속도록 주행 거리에 미치는 영향변수 보기 

#단계1: 패키지 설치 및 로딩
install.packages("ggplot2")
library(ggplot2) 
data(mpg) # ggplot2 패키지 제공
mpg
dim(mpg)


#단계2: 학습데이터와 검정데이터 생성
t <- sample(1:nrow(mpg), 120) 
train <- mpg[t, ] 
test <- mpg[-t, ]   
dim(test)

#단계3: formula 작성과 분류모델 생성
test$drv<- factor(test$drv)
train$drv <- factor(train$drv)
# test$drv --> f, 4 로 되어있음.
# nominal 형태에서 범주형 변수로...
test$hwy #연속형 데이터
formula <- hwy ~ displ + cyl + drv
# Target: hwy : 1갤런당 얼마나 가는지. 즉, 연비
hwy_ctree <- ctree(formula, data=train) 
plot(hwy_ctree, type = "simple") 
plot(hwy_ctree)
