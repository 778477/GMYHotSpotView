![shoot](https://raw.githubusercontent.com/778477/GMYHotSpotView/master/shoot.png)

[![Build Status](https://travis-ci.org/778477/GMYHotSpotView.svg)](https://travis-ci.org/778477/GMYHotSpotView) ![MIT](https://img.shields.io/packagist/l/doctrine/orm.svg) ![iOS7](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)


2015年7月26日 

## HotSpotView 热点视图

* 支持Layout自定义控制hotspot的位置，以到达想要的布局效果

### NormalLayout 普通布局效果
* 按照model顺序排列，基本布局。如果对数据顺序要求严格的话，建议使用这种布局。

### BetterLayout 美观布局效果
* 打乱model顺序排序，类似内存对齐效果。 如果对数据顺序不在意的话，希望UI排列美观，建议使用这种布局。


![pic](https://github.com/778477/GMYHotSpotView/blob/master/src/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-07-26%20%E4%B8%8B%E5%8D%8810.17.48.png)

* 同样的GMYHotSpotView控件，上面使用的是normalLayout，下面使用的是BetterLayout。能对比发现 BetterLayout在布局方面比NormalLayout更为紧凑一些。数据差异(文案长度)越大，效果越明显。

### 支持删除Tag 重新布局

![normal](https://raw.githubusercontent.com/778477/GMYHotSpotView/66c54ba5d8b9ee427bfa13dc9ff6cf590a6c3253/normal.gif)
![better](https://raw.githubusercontent.com/778477/GMYHotSpotView/66c54ba5d8b9ee427bfa13dc9ff6cf590a6c3253/better.gif)

### TODO List

- [X] 支持长按触发修改状态 点击可删除

 ~~- [ ] 支持长按触发修改状态 拖动修改顺序~~ 
