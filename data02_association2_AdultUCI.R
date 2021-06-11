
## 3. 연관규칙 시각화

# [실습] Adult 데이터 셋 가져오기
data(Adult) # arules에서 제공되는 내장 데이터셋
#uci repository 에 dataset 많이 있음.
# 연봉 5만불 이상인 사람과 이하인 사람의 특징을 알아보기위한 데이터
str(Adult) # Formal class 'transactions' , 48842(행)
Adult

# [실습] 트랜잭션 관련 정보보기
attributes(Adult)# 트랜잭션의 변수와 범주 보기
data(AdultUCI)
str(AdultUCI) # 'data.frame':	48842 obs. of  2 variables:
names(AdultUCI)

# [실습]  Adult 데이터 셋의 요약 통계량 보기 

# 단계 1 : data.frame 형식으로 보기
adult <- as(Adult, 'data.frame')
# transaction 데이터로 바꿔주기. 설명att / 타겟att 2열,
str(adult)  
head(adult)

# 단계 2 : 요약 통계량
summary(Adult)


# [실습] 신뢰도 80%, 지지도 10% 적용된 연관규칙 발견   
ar<- apriori(Adult, parameter = list(supp=0.1, conf=0.8))

# [실습] 다양한 신뢰도와 지지도 적용  예 

# 단계 1 : 지지도를 20%로 높인 경우 1,306개 규칙 발견
ar1<- apriori(Adult, parameter = list(supp=0.2)) 

# 단계 2 : 지지도 20%, 신뢰도 95% 높인 경우 348개 규칙 발견
ar2<- apriori(Adult, parameter = list(supp=0.2, conf=0.95)) # 신뢰도 높임

# 단계 3 : 지지도 30%, 신뢰도 95% 높인 경우 124개 규칙 발견
ar3<- apriori(Adult, parameter = list(supp=0.3, conf=0.95)) # 신뢰도 높임

# 단계 4 :  지지도 35%, 신뢰도 95% 높인 경우 67 규칙 발견
ar4<- apriori(Adult, parameter = list(supp=0.35, conf=0.95)) # 신뢰도 높임

# 단계 5 :  지지도 40%(에 적용가능), 신뢰도 95% 높인 경우 36 규칙 발견
ar5<- apriori(Adult, parameter = list(supp=0.4, conf=0.95)) # 신뢰도 높임


# [실습] 규칙 결과보기

# 단계 1 : (순서만)상위 6개 규칙 보기
inspect(head(ar5)) 

# 단계 2 :  confidence(신뢰도) 기준 내림차순 정렬 상위 6개 출력
inspect(head(sort(ar5, decreasing=T, by="confidence")))

# 단계 3 :  lift(향상도) 기준 내림차순 정렬 상위 6개 출력
inspect(head(sort(ar5, by="lift"))) 
