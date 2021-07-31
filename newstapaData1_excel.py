import pandas

dataframe = pandas.read_excel("./newstapa_ex.xlsx")
#판다스 데이터프레임 = 스프레드시트 한장

dataframe.head() #5개 보여줌

#홀짝 나눠서 저장
dataframe1 = dataframe.loc[::2] #콜론 뒤 숫자 간격 의미.
# 맨 첫행부터 끝행까지 2 간격
# loc = 데이터 선택 명령어
print(dataframe1.head()) #홀수행만 저장. 생년월일만 있음

dataframe2 = dataframe.loc[1::2] #2행부터 2줄간격 데이터 선택
print(dataframe2.head()) #짝수행만 저장. 대부분 데이터 여기에 

dataframe1 = dataframe1.reset_index() #행번호 초기화 명령어
dataframe1 = dataframe1.rename({'생년월일/주소':'생년월일'}, axis = 1) #열이름 바꾸기

dataframe2 = dataframe2.reset_index() #행번호 초기화 명령어
dataframe2 = dataframe2.rename({'생년월일/주소':'주소'}, axis = 1) #열이름 바꾸기

dataframe3 = pandas.concat([dataframe1, dataframe2], axis = 1)
# 데이터 프레임 합치기. 열 기준으로..

print(dataframe3.head())