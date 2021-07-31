import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

data = pd.read_csv("./newstapa_ex2.csv")
# 컬럼명에 괄호가 있으면 ERROR 발생.
print(data.head())
data.columns = data.columns.str.replace('\(원\)', '')
#print(data.columns)

data_bar = data.groupby('소속정당').sum()['기부금액'].reset_index() #컬럼명 이용할땐 대괄호
print(data_bar)

y_pos = np.arange(len(data_bar))
print(y_pos)

#bart : 수평막대 그리기/ bar : 수직 막대 그리기
#plt.barh(y_pos, data_bar['기부금액'])# x축, y축
#plt.yticks(y_pos, data_bar['소속정당']) #y축 눈금 그리기
# 한글폰트 깨지고 막대 순서도 뒤죽박죽
#plt.savefig('test1.png')
#plt.show()

# 영어로 컬럼명 바꿔주기
data_bar['소속정당'] = data_bar['소속정당'].replace(['국민의힘'], 'people_power_party')
data_bar['소속정당'] = data_bar['소속정당'].replace(['국민의당'], 'people_party')
data_bar['소속정당'] = data_bar['소속정당'].replace(['더불어민주당'], 'the_minjoo')
data_bar['소속정당'] = data_bar['소속정당'].replace(['정의당'], 'justice_party')
data_bar['소속정당'] = data_bar['소속정당'].replace(['미래통합당'], 'united_future_party')
data_bar['소속정당'] = data_bar['소속정당'].replace(['열린민주당'], 'open_democracy_party')
data_bar['소속정당'] = data_bar['소속정당'].replace(['시대전환'], 'transition_korea')
data_bar['소속정당'] = data_bar['소속정당'].replace(['기본소득당'], 'basic_income_party')
data_bar['소속정당'] = data_bar['소속정당'].replace(['무소속'], 'independent')

data_bar = data_bar.sort_values(by=['기부금액'], ascending = True) #False 가 내림차순

#rects = plt.barh(y_pos, data_bar['기부금액'])
#plt.yticks(y_pos, data_bar['소속정당'])
#plt.savefig('test2.png')
#plt.show()


#그래프의 스타일 추가.
#템플릿 https://matplotlib.org/3.1.1/gallery/style_sheets/style_sheets_reference.html

plt.style.use('seaborn')

plt.barh(y_pos, data_bar['기부금액'])
plt.yticks(y_pos, data_bar['소속정당'])
plt.savefig('test3.png')
plt.show()


