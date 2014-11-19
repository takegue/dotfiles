# !/usr/bin/env Python
# -*- coding:utf-8 -*-

import csv
import numpy as np
import matplotlib.pyplot as plt

from matplotlib.font_manager import FontProperties

src = '<`1:TARGET`>'
dst = '<`2:TARGET`>'

def draw_heatmap(data, row_labels, column_labels):
    # 描画する
    fig, ax = plt.subplots()
    heatmap = ax.pcolor(data, cmap=plt.cm.Blues)

    ax.set_xticks(np.arange(data.shape[0]) + 0.5, minor=False)
    ax.set_yticks(np.arange(data.shape[1]) + 0.5, minor=False)

    ax.invert_yaxis()
    ax.xaxis.tick_top()

    ax.set_xticklabels(row_labels, minor=False)
    ax.set_yticklabels(column_labels, minor=False)
    plt.show()
    plt.savefig(dst)

    return heatmap

def main():
    with open(src) as fin:
        label_x = fin.readline().split(',')
        label_y = []

        reader = csv.reader(fin)
        data = [ [ int(r)  if r else 0 for r in rows] for rows in reader ]
        data = np.array(data)

        label_x = [ int(x) for x in label_x[1:]]
        label_y = data[:,0]
        data = np.sqrt(np.sqrt(data[:,1:]))
        draw_heatmap(data, label_x, label_y)


if __name__ == '__main__':
    main()
 
