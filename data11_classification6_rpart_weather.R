
## [실습2] 날씨 데이터를 이용하여 비 유무 예측 
#  weather.csv를 weather로 읽어서 RainTomorrow가 y변수, Date, RainTody를
#  제외한 나머지 변수가 x변수가 되도록 하여 decision tree를 작성

# 단계1 : 데이터 가져오기
# c:/Rwork/Part-IV/weather.csv 파일 선택
weather = read.csv("c:/downloads/Rwork/Part-IV/weather.csv", header=TRUE) 

# 단계2 : 데이터 특성 보기
str(weather) # data.frame':  366 obs. of  15 variables:
names(weather) # 15개 변수명
head(weather)

# 단계3 : 분류분석 - 의사결정트리 생성
weather.df <- rpart(RainTomorrow ~ ., 
                    data=weather[, c(-1,-14)], cp=0.01)
# 첫번째 att(날짜)와 14번째 att(RainToday)은 제외하고 사용
# cp(complexity) <- 과적합 지표.
# cp값을 작게 설정하면 tree가 커져서 과적합,
# cp값을 크게 설정하면 tree 가 작아져서 과소적합에 위험.
# cp값 설정 -- xerror 값이 적을수록 좋음. . 
weather.df
plotcp(weather.df) #Error 값이 낮을수록 좋음.
printcp(weather.df)

# 단계4 : 분류분석 시각화
X11()
plot(weather.df) # 트리 프레임 보임
text(weather.df, use.n=T, cex=0.7) # 텍스트 추가
post(weather.df, file="") # 타원제공 - rpart 패키지 제공 

rpart.plot(weather.df)

# xerror 가장 줄이는 cp 값 넣어서 재구성
weather.df_pruned <- rpart(RainTomorrow ~ ., 
                           data=weather[, c(-1,-14)], cp=0.037879)

plot(weather.df_pruned)
text(weather.df_pruned, use.n=T, cex=0.7)
post(weather.df_pruned, file = "")

## 단계5 : 예측치 생성과 코딩 변경
weather_pred <- predict(weather.df, weather)
# 첫번째클래스일확률 / 2번째 클래스일 확률 . . . 
weather_pred

# 확률에서.. y의 범주로 코딩 변환 : Yes(0.5이상), No(0.5 미만)
weather_pred2 <- ifelse(weather_pred[,2] >= 0.5, 'Yes', 'No' )

# 단계6 : 모델 평가(분류 정확도) 
table(weather_pred2, weather$RainTomorrow)
(278+53) / nrow(weather) # 0.9043716

# ** 실제로는 train과 test 나누는게 좋음.
# 그러나, att들의 모든 combination 들이 testset에선 다 포함되지 않을 수 있음.. 
# 데이터셋을 충분히 확보해야함.

## 단계5 : 예측치 생성과 코딩 변경 / pruned 한 모델에 대해서도 시행 
weather_pred <- predict(weather.df_pruned, weather)
weather_pred

# y의 범주로 코딩 변환 : Yes(0.5이상), No(0.5 미만)
weather_pred2 <- ifelse(weather_pred[,2] >= 0.5, 'Yes', 'No' )

# 단계6 : 모델 평가(분류 정확도) 
table(weather_pred2, weather$RainTomorrow)
(287+32) / nrow(weather) # 0.8715847
# 나중에 generation 으로 보면 더 높아질수 있음.
# 현재는 train과 test를 합쳐서 봤기때문에 더 낮을수밖에 없음...




