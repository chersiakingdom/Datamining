#rpart 패키지를 통한 DecisionTree(hunts 알고리즘의 틀)
#반복적으로 partitioning. .
# 둘 중 어떤것을 사용할지는 상황에 따라 다름.(ctree / rpart)

## 2. rpart 패키지 적용 분류분석 recursive partitioning

## [실습1] rpart()함수 간단 실습 

# 단계1 : 패키지 설치 및 로딩 
install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)
install.packages('rattle')
library('rattle')

# 단계2 : 데이터 로딩
data(iris)
str(iris)
X11() # 별도 창 

# 단계3 : rpart() 함수 이용 분류분석
iris.df <- rpart(Species ~ ., data=iris)
#. 은 target att를 제외한 나머지 모두를 설명 att로 사용하겠다는 뜻.
iris.df  

# 단계4 : 분류분석 시각화
#rpart.plot(iris.df) # 트리 프레임만 보임....
plot(iris.df)
text(iris.df, use.n=T, cex=0.9) # 텍스트 추가
post(iris.df, file="")