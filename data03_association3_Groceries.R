
# [실습] Groceries 데이터 셋으로 연관분석하기

# 단계 1 :  Groceries 데이터 셋 가져오기
library(arules)
data("Groceries")  # 식료품점 데이터 로딩
str(Groceries) # Formal class 'transactions' [package "arules"] with 4 slots
Groceries

# 단계 2 : data.frame으로 형 변환
Groceries.df<- as(Groceries, "data.frame") #보기편하게 변환
head(Groceries.df)

# 단계 3 : 지지도 0.001, 신뢰도 0.8 적용 규칙 발견 물건이 너무 많아서 지지도 낮춤.
rules <- apriori(Groceries, parameter=list(supp=0.001, conf=0.8))
inspect(rules) 

# 단계 4 : 규칙을 구성하는 왼쪽(LHS) -> 오른쪽(RHS)의 item 빈도수 보기 
library(arulesViz)
plot(rules, method="grouped")
# other vegetables 와 whole milk 가 RHS에 많이 나오고있음.
# 위스키, 와인 -> 맥주를 많이 사는구나 알수있음.


# [실습] 최대 길이 3이하 규칙 생성
rules <- apriori(Groceries, parameter=list(supp=0.001, conf=0.80, maxlen=3))
# writing ... [29 rule(s)] done [0.00s].
inspect(rules) # 29개 규칙

# [실습] confidence(신뢰도) 기준 내림차순으로 규칙 정렬
rules <- sort(rules, decreasing=T, by="confidence")
inspect(rules) 

# [실습] 발견된 규칙 시각화
library(arulesViz) # rules값 대상 그래프를 그리는 패키지
plot(rules, method="graph", control=list(type="items"))