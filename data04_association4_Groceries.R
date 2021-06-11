
# [실습] 특정 상품[item] 서브 셋 작성과 시각화

# 단계 1 : 오른쪽 item이 전지분유(whole milk)인 규칙만 서브셋으로 작성
wmilk <- subset(rules, rhs %in% 'whole milk') # lhs : 왼쪽 item
wmilk # set of 18 rules 
inspect(wmilk)
plot(wmilk, method="graph") #  연관 네트워크 그래프

# 단계 2 : 오른쪽 item이 other vegetables인 규칙만 서브셋으로 작성
oveg <- subset(rules, rhs %in% 'other vegetables') # lhs : 왼쪽 item
oveg # set of 10 rules 
inspect(oveg)
plot(oveg, method="graph") #  연관 네트워크 그래프

# 단계 3 :  오른쪽 item이 vegetables 단어가 포함된 규칙만 서브 셋으로 작성
veg <- subset(rules, rhs %pin% 'vegetables') # 글자가 아니라 단어 .!!
veg 
inspect(oveg)

# 단계 4 : 왼쪽 item이 butter or yogurt인 규칙만 서브 셋으로 작성
butter_yog <- subset(rules, lhs %in% c('butter', 'yogurt'))
butter_yog #4개 rules
inspect(butter_yog)
plot(butter_yog, method="graph")
