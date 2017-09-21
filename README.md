# iOS-image



## Core Image

Core Image教程推荐：



+ [Core Image 你需要了解的那些事~](https://colin1994.github.io/2016/10/21/Core-Image-OverView/)
+ [OC版本-Beginning Core Image in iOS 6](https://www.raywenderlich.com/22167/beginning-core-image-in-ios-6))或[Swift版本-Core Image Tutorial: Getting Started](https://www.raywenderlich.com/76285/beginning-core-image-swift)
+ [Core Image 介绍](https://objccn.io/issue-21-6/)



Core Image 的 API 主要就是三类：



+ CIImage 保存图像数据的类，可以通过UIImage，图像文件或者像素数据来创建，包括未处理的像素数据
+ CIFilter 表示应用的滤镜，这个框架中对图片属性进行细节处理的类。它对所有的像素进行操作，用一些键-值设置来决定具体操作的程度
+ CIContext 表示上下文，如 Core Graphics 以及 Core Data 中的上下文用于处理绘制渲染以及处理托管对象一样，Core Image 的上下文也是实现对图像处理的具体对象。可以从其中取得图片的信息





