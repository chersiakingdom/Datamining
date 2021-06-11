# k-means "군집" 분석

install.packages("corrgram")
install.packages("mclust") #군집분석시 필요
install.packages("ggplot2")

library(corrgram)
library(mclust)
library(ggplot2)

# unlink("C:/Users/USER/Documents/R/win-library/4.0", recursive = TRUE)
# install.packages("corrgram", dependencies = TRUE, INSTALL_opts = "--no-lock")
# https://github.com/lumiamitie/TIL/blob/master/rstudy/package_lock.md


# chap16_1_ClusteringAnalysis

######################################
## Chapter16_1. ClusteringAnalysis
######################################

## 1. 유클리드안 거리
# 유클리드 거리(Euclidean distance)는 두 점 사이의 거리를 계산하는 
# 방법으로 이 거리를 이용하여 유클리드 공간을 정의한다.

# [실습] 유클리디안 거리 계산법

# 단계 1 : matrix 객체 생성
x <- matrix(1:9, nrow=3, by=T) #by = T 안쓰면 컬럼으로 123 내려감.
# T 쓰면 row 순서대로 1 2 3 됨 .!!
x

# 단계 2 : 유클리드안 거리 생성
dist <- dist(x, method="euclidean") # 행렬 지정, method 생략가능
dist


# (3) 유클리드 거리 계산식의 R코드 : 직접 하나씩 구해보기

# 1행과 2행 변량의 유클리드 거리 구하기
sqrt(sum((x[1,] - x[2, ])^2)) # 5.196152 # 1번째행 모든 칼럼 - 2번째행 모든 칼럼 (data obj)
# sqrt = 제곱근 구하라.
# 1행과 3행 변량의 유클리드 거리 구하기
sqrt(sum((x[1,] - x[3, ])^2)) # 10.3923
sqrt(sum((x[2,] - x[3, ])^2)) # 10.3923


## 4. K-means 군집분석 

# 단계 1 : 군집분석에 사용할 변수 추출 
library(ggplot2)
data(diamonds)
dim(diamonds)
t <- sample(1 : nrow(diamonds),1000) # 1000개 셈플링, t에는 1, 3, 5 등 랜덤 숫자index 지정됨
t
test <- diamonds[t, ] # 1000개 표본 추출
dim(test) # [1] 1000 10

head(test) # 검정 데이터
mydia <- test[c("price","carat", "depth", "table")] # 4개 칼럼만 선정
head(mydia)
dim(mydia)


# 단계 2 :  K-means 군집분석
result2 <- kmeans(mydia, 3) #dataset, K(갯수) 지정
names(result2) # cluster 칼럼 확인 (kmeans 시행으로 인해 9 개의 칼럼 생성됨)
result2$cluster # 각 레코드 어느 클러스터에 속함? k=3 중 한개에 소속.
result2$centers # 각 군집 중앙값
result2$totss # 제곱합의 총합 (SSE 각 결정 / 3개 총합) <- cluster 품질 결정
result2$withinss # 군집 내 군집과 개체간 거리의 제곱합 벡터.
result2$tot.withinss # 군집 내 군집과 개체간 거리의 제곱합의 총합, 즉, sum(withinss) (Total within-cluster sum of squares, i.e. sum(withinss))
result2$betweenss # 군집과 군집 간 중심의 거리 제곱합 between-cluster sum of squares
result2$size   # 각 군집의 개체의 개수       
result2$iter  #반복 회수       


# 원형데이터에 군집수 추가
mydia$cluster <- result2$cluster #cluster 정보 mydia 추가, 그거는 result2의cluster 컬럼 넣어라
head(mydia) # cluster 칼럼 확인 

# 단계 3 :  변수 간의 상관계수 보기 
cor(mydia[,-5], method="pearson") # 사용할 dataset, 방법 #5번째 칼럼은 빼겠다.(cluster)
# carat 과 price는 높은 양의 상관관계를 가진다.
plot(mydia[,-5]) #시각화

# 상관계수 색상 시각화 
install.packages('mclust')
library(mclust)
library(corrgram) # 상관성 시각화 
corrgram(mydia[,-5]) # 색상 적용 - 동일 색상으로 그룹화 표시 #파란색 진할수록 양상관, 빨간색 진할수록 음상관
corrgram(mydia[,-5], upper.panel=panel.conf) # 수치(상관계수) 추가(위쪽) #아래 숫자는 신뢰구간


# 단계 4 : 군집시각화
plot(mydia$carat, mydia$price, col=mydia$cluster)#x축 = 캐럿, y축 = price, cluster 구분에 따라 색상 비교

# 중심점 표시 추가 
points(result2$centers[,c("carat", "price")], col=c(2,1,3),pch=8, cex=5)
