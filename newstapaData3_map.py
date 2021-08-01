import folium
import pandas as pd

# 빈 지도 만들기. 중심좌표설정, 얼마나 확대할지 설정
map1 = folium.Map(location=[37.24006283541407, 127.08179064006481], zoom_start= 8 )
# 주피터 노트북 혹은 코랩으로 개발하면 바로 보이지만 여기서는 따로 객체 저장해줘여함.

# 구글 지도의 마커 우클릭으로 위경도값 가져오기 : 
# 경희대학교 (국제) 37.24006283541407, 127.08179064006481

# 마커 찍기
folium.Marker(
    location = [37.24006283541407, 127.08179064006481],
    popup = "경희대학교(국제)", #왜 콤마 넣어줘야뜸..??
    ).add_to(map1)

map1.save('C:/downloads/coding_study/crolling/map1.html')

# 수도권에 있는 국회의원 소유 토지 데이터 지도에 뿌려보기
# 주소를 알면, 구글 스프레드 시트 함수를 이용해 한번에 위-경도를 변경할 수 있음.
map2 = folium.Map(location=[37.24006283541407, 127.08179064006481], zoom_start= 8 )
url = "https://docs.google.com/spreadsheets/d/e/2PACX-1vSumQFVKNthDL_0w_on_m_tNwcg-zIVNHpoQ5DL1t0mBqSN7sz2UU6VThopV5jw_qrLQfklLhVwB0zY/pub?gid=1252880174&single=true&output=csv"

data = pd.read_csv(url)
#print(data.head())
#print(data.columns)

# 행 선택 후 열 선택
Lat0 = data.iloc[0]['Latitude'] #data.frame 에서 n번째 행 선택, 그 행에서 해당 컬럼 선택

for i in range(len(data.index)): #len(data) 해도됨
    folium.Marker(
        location = [data.iloc[i]['Latitude'], data.iloc[i]['Longitude']],
        popup = data.iloc[i]['이름'],
    ).add_to(map2)

map2.save('C:/downloads/coding_study/crolling/map2.html')

print("END")

# 추후 Folium Library 찾아보기





































