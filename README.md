# Brick-filter-processing

processing2.2.1


将人像转化为像素/积木块的滤镜
###应用情景
将证件照大小的人像照转化为灰度像素图（5色），可调整像素/积木数量。像素/积木数量越少，图像越粗糙。生成
生成像素图/积木图纸后，会计算不同颜色积木的总数。


原图


![img](https://github.com/SuperMegaPlantet/Brick-filter-processing/blob/readme-edit/data/pic.png)


输出图像


![output](https://github.com/SuperMegaPlantet/Brick-filter-processing/blob/readme-edit/data/170307_140501_78.png)


调整积木数量
![resize](https://github.com/SuperMegaPlantet/Brick-filter-processing/blob/readme-edit/data/resize.jpg)

###算法


1.重设原图大小
将原图缩小至X倍 （例如：0.8倍）
缩小后得到的尺寸乘积，将是积木块总数。

2.遍历原图每个像素的颜色
先求得当前像素的RGB值，之后按公式转化为灰度值。


    gray=red*0.222+green*0.707+blue*0.071
    
  RGB转换为灰度的权重值可以自由更改。
  

 
3.将灰度转化为预设好的5种颜色，并画出相应的像素块/积木块
灰度图含有5个颜色，代表5种积木，像素灰度如下：


    brick01:255  
    brick02:175
    brick03:125
    brick04:75
    brick05:25
    
    
将灰度转换为5种颜色的规则：



   原图灰度|转换后灰度  
----------|----------
 [0，50]  |25
（50，100]|75
（100，150]|125
（150，200]|175
（200，255]|255


###可调整的参数
- resize: 控制原图的缩放比例，以及积木块总数
- scale: 输出图的像素块/积木块尺寸设置 nxn ，n的单位为像素
- redWeight/greenWeight/blueWeight: 灰度转化的RGB权重


 
 调整RGB权重后，5个积木块的数量将会改变
 
 ![weight](https://github.com/SuperMegaPlantet/Brick-filter-processing/blob/readme-edit/data/RGBweight.jpg)
 
###打印的数据

```
size:53 x 77   积木总数/像素图大小
brick01#:534   brick01总数
brick02#:1934  brick02总数
brick03#:449   brick03总数     
brick04#:442   brick04总数     
brick05#:722   brick05总数
```
