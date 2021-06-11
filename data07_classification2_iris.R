
## [실습2] 학습데이터와 검정데이터 샘플링으로 분류분석하기 

#단계1 : 학습데이터와 검증데이터 샘플링
set.seed(1234) # 메모리에 시드값 적용 - 난수 항상 동일값 생성 
idx <- sample(1:nrow(iris), nrow(iris) * 0.7) #70%
train <- iris[idx,] #data의 70%를 trainset에
test <- iris[-idx,] #나머지
dim(iris)
dim(test)
idx

# 단계2 : formula 생성 
#  -> 형식) 변수 <- 종속변수 ~ 독립변수
formula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width 
# 종류 예측하기

#단계3 : 학습데이터 이용 분류모델 생성(ctree()함수 이용)
iris_ctree <- ctree(formula, data=train) # 학습데이터로 분류모델(tree) 생성
iris_ctree # Petal.Length,Petal.Width 중요변수

#단계4 : 분류모델 플로팅
# plot() 이용 - 의사결정 트리로 결과 플로팅
plot(iris_ctree, type="simple") 
plot(iris_ctree) # 의사결정트리 해석

result <- subset(train, Petal.Length > 1.9 & Petal.Width <= 1.6 & Petal.Length > 4.6)
result$Species
# setosa 가 1번째 column 이구나.
# versicolor 가 2번째, verginica가 3번째.

length(result$Species) # 9
table(result$Species)#<<<<<<<<<이렇게하면 한눈에 보임.
#setosa versicolor  virginica 
#     0          5          4 

###############################
#단계5 : 분류모델 평가 (test set)

# (1) 모델 예측치 생성과 혼돈(confusion) 매트릭스 생성 
pred <- predict(iris_ctree, test) # 45
pred # Y변수의 변수값으로 예측,45개 

table(pred, test$Species)
#pred         setosa versicolor virginica
#setosa         12          0         0   <- missing : 0
#versicolor      0         17         2   <- missing : 0
#virginica       0          0        14   <- missing : 1

# (2) 분류정확도 
(12+17+14) / nrow(test) # 0.9777778
(12+17+14)/45 #0.95555

