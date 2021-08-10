import pandas as pd
waset_data = pd.read_csv("https://data.newstapa.org/datasets/%EA%B0%80%EC%A7%9C%ED%95%99%ED%9A%8C-WASET-%ED%95%9C%EA%B5%AD-%EA%B4%80%EB%A0%A8-%EB%8D%B0%EC%9D%B4%ED%84%B0/files/waset-20180727.csv", sep=',')
waset_data.shape
print(waset_data.columns)
waset_data.head(10)
import numpy as np
pd.pivot_table(waset_data, index = ['Institution'], columns = None)
import matplotlib.pyplot as plt
from matplotlib import rcParams
rcParams['font.family'] = 'NanumBarunGothic'
fig, ax = plt.subplots(1, 1, figsize = (6, 10))
waset_data['Institution'].value_counts().head(40).plot.barh(ax=ax, zorder=3, fc='#444444')
ax.invert_yaxis()
ax.grid(zorder=1)
plt.show()

