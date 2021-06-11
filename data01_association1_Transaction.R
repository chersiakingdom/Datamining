# AssociationAnalysis "연관"분석

# [실습]  트랜잭션 객체를 대상으로 연관규칙 생성 

# 단계 1 : 연관분석을 위한 패키지 
install.packages("arules")
library(arules) #read.transactions()함수 제공

# 단계 2 : 트랜잭션(transaction) 객체 생성
setwd("c:/downloads/Rwork/Part-IV")
tran<- read.transactions("tran.txt", format="basket", sep=",")
tran

# dataset 종류
#basket 형태
#라면, 우유, 과일
#우유, 고기, 맥주 . .

#single 형태
#transID1 : item1
#transID2 : item2
#transID2 : item1

# 단계 3 : 트랜잭션 데이터 보기
inspect(tran)

# 단계 4 : 규칙(rule) 발견
rule<- apriori(tran, parameter = list(supp=0.3, conf=0.1)) # 16 rule
inspect(rule) # 규칙 보기
rule<- apriori(tran, parameter = list(supp=0.1, conf=0.1)) # 35 rule 
inspect(rule) # 규칙 보기


## 2. 트랜잭션 객체 생성 

# [실습]  single 트랜잭션 객체 생성 
stran <- read.transactions("demo_single",format="single",cols=c(1,2)) 
inspect(stran)

# [실습] 중복 트랜잭션 제거

# 단계 1 : 트랜잭션 데이터 가져오기
stran2<- read.transactions("single_format.csv", format="single", sep=",", 
                           cols=c(1,2), rm.duplicates=T) #중복제거

# 단계 2 : 트랜잭션과 상품 수 확인
stran2
inspect(stran2)

# 단계 3 : 요약 통계 제공 
summary(stran2) # 248개 트랜잭션에 대한 기술통계 제공
inspect(stran2) # 트랜잭션 확인 


# [실습] 규칙 발견(생성)

# 단계 1 : 규칙 생성하기 
astran2 <- apriori(stran2) # 디폴트값 : supp=0.1, conf=0.8
#astran2 <- apriori(stran2, parameter = list(supp=0.1, conf=0.8))
astran2 # set of 102 rules
attributes(astran2)

# 단계 2 : 발견된 규칙 보기 
inspect(astran2)

# 단계 3 : 상위 5개 향상도 내림차순으로 정렬하여 출력 
inspect(head(sort(astran2, by="lift")))


# [실습] basket 트랜잭션 객체 생성
btran <- read.transactions("c:/downloads/Rwork/Part-IV/demo_basket",format="basket",sep=",") 
inspect(btran) # 트랜잭션 데이터 보기

#정리
# 룰 generation 기준 -- support, confidence가 기준이 됨.
# 서포트값이 작을수록 룰 갯수가 많아진다.
# lift : 룰의 가치, confidence : 정확성, support : 우연성
# dataset의 형태는 single(transID, 아이템 하나씩) / basket(한줄열거) 로 불러들이는게 다르다.
