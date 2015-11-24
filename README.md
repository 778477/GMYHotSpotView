[![Build Status](https://travis-ci.org/778477/GMYHotSpotView.png)](https://travis-ci.org/778477/GMYHotSpotView)

2015年7月26日 

## HotSpotView 热点视图

* 支持Layout自定义控制hotspot的位置，以到达想要的布局效果

### NormalLayout 普通布局效果
* 按照model顺序排列，基本布局。如果对数据顺序要求严格的话，建议使用这种布局。

### BetterLayout 美观布局效果
* 打乱model顺序排序，类似内存对齐效果。 如果对数据顺序不在意的话，希望UI排列美观，建议使用这种布局。


![pic](https://github.com/778477/GMYHotSpotView/blob/master/src/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202015-07-26%20%E4%B8%8B%E5%8D%8810.17.48.png)

* 同样的GMYHotSpotView控件，上面使用的是normalLayout，下面使用的是BetterLayout。能对比发现 BetterLayout在布局方面比NormalLayout更为紧凑一些。数据差异(文案长度)越大，效果越明显。


### TODO List
* 支持长按触发修改状态(可拖动，可删除）