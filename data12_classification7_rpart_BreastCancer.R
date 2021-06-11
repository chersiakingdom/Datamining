## [실습2] rpart() 함수 실습 : 연속형 
#rpart : 과적합의 위험이 있다.

# 단계1. 패키지 설치 및 로딩
library(rpart)
library(rpart.plot)
library('rattle')

install.packages("mlbench")
library(mlbench)
# mlbance 란?
# A collection of artificial and real-world machine learning benchmark problems, including, 
# e.g., several data sets from the UCI repository.

data("BreastCancer")
or <- BreastCancer
bc <- BreastCancer[-1] #첫번째 칼럼(ID) 제외
str(bc)
bc <- cbind(lapply(bc[-10],function(x) as.numeric(as.character(x))), bc[10])
str(bc)
# 현 데이터 분석시에는 데이터형태가 numeric 으로 되어야하기때문에 변형 , , 

head(BreastCancer)

set.seed(567)
train <- sample(1:nrow(bc), 0.7*nrow(bc))  # stratified sampling <- 모든 combination
bc.train <- bc[train,]
bc.test <- bc[-train,]
table(bc.train$Class)
table(bc.test$Class)
# benign 양성, malignant 악성

bc.dtree <- rpart(formula= Class ~ ., data=bc.train, method="class", parms =list(split="information"))
# method= 'class' : categorical target에 대해 이진분류 한다는 의미
# rpart의 기본적인 params는 지니. 이 경우 entropy로 진행
rpart.plot(bc.dtree)

bc.dtree.pred <- predict(bc.dtree, newdata=bc.test, type ="prob")
# type = 'prob' 가 되면 값들이 target값에 대해 확률로 나타내짐.
head(bc.dtree.pred)

bc.dtree.pred <- predict(bc.dtree, newdata=bc.test, type ="class")
# type = 'class' 로 하면, 0.5 기준으로 target값이 나눠짐
head(bc.dtree.pred)

table(bc.test$Class, bc.dtree.pred, dnn=c("Actual", "Predicted"))
# 이게 디폴트
table(bc.dtree.pred, bc.test$Class, dnn=c("Predicted","Actual"))
# 이렇게도 볼 수 있음.

#정확도 측정
mean(bc.dtree.pred == bc.test$Class) # 0.9714286

bc.dtree$cptable
printcp(bc.dtree)
plotcp(bc.dtree) #점선 그어져있는것이 상한값. 
#xerror = risk
# 0.24138(xerror 최소) + 0.035610(xstd) =0.27699
# 0.24138-0.035610 = 0.20577
# 0.20577~0.27699 이 구간에 들어가는값(xerror) minimum 으로 고르기
#         CP nsplit rel error  xerror     xstd
#1 0.770115      0   1.00000 1.00000 0.060845
#2 0.034483      1   0.22989 0.30460 0.039507
#3 0.020115      3   0.16092 0.26437 0.037100
#4 0.010000      5   0.12069 0.24138 0.035610

#현재 3번과 4번이 minimum --- cp = 0.01 or 0.020115이 이상적.
# 둘중에서는 과소/과적합 피하는 지표 고려해 선택
# 보통은 이럴경우, 가장 적게 split 할수있게 선택. 즉 큰 cp값(3번) 선택 

bc.dtree_pruned <- rpart(formula= Class ~ ., data=bc.train, method="class", cp=0.020115, parms =list(split="information"))

bc.dtree_pruned2 <- prune(bc.dtree, cp=0.020115) #이렇게 할수도있음.
printcp(bc.dtree_pruned)

rpart.plot(bc.dtree_pruned)


bc.dtree.pred_prunded <- predict(bc.dtree_pruned, newdata=bc.test, type ="class")
mean(bc.dtree.pred_prunded == bc.test$Class) #0.9714286






