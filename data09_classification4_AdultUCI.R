
## [실습5] AdultUCI 데이터 셋을 이용한 분류분석

# 단계1 : 패키지 설치 및 데이터 셋 구조 보기 
install.packages("arules")
library(arules)
data("AdultUCI")

str(AdultUCI) # 'data.frame':	48842 obs. of  15 variables:
names(AdultUCI)
head(AdultUCI)

# 단계2 : 데이터 샘플링 - 10,000개 관측치 선택 
set.seed(1234) # 메모리에 시드 값 적용
choice <- sample(1:nrow(AdultUCI), 10000)
choice
adult.df <-  AdultUCI[choice, ]  
str(adult.df) # ' # 'data.frame':	10000 obs. of  15 variables:

# 단계3 : 변수 추출 및 데이터 프레임 생성
# (1) 변수 추출
capital<- adult.df$`capital-gain` #변수명바꾸기
hours<- adult.df$`hours-per-week`
education <- adult.df$`education-num`
race <- adult.df$race
age <- adult.df$age
income <- adult.df$income

# (2) 데이터프레임 생성
adult_df <- data.frame(capital=capital, age=age, race=race, hours=hours, education=education, income=income)
str(adult_df) # 'data.frame':	10000 obs. of  6 variables:

# 단계4 : formula 생성 - 자본이득(capital)에 영향을 미치는 변수 
formula <-  capital ~ income + education + hours + race + age
# 자본 이득에 대해 . . 

# 단계5 :  분류모델 생성 및 예측
adult_ctree <- ctree(formula, data=adult_df)
adult_ctree # 가장 큰 영향을 미치는 변수 - income, education

# 단계6 : 분류모델 플로팅
plot(adult_ctree)

#party 패키지(ctree) * 비교적 bias를 줄일 수 있음.