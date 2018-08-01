### .gitmodules文件

#### 添加
git submodule add git@github.com:ReactiveX/RxSwift.git code/RxSwift

添加子模块，目录结构
[submodule "code/RxSwift"]
        path = code/RxSwift
        url = git@github.com:ReactiveX/RxSwift.git

####  意义
主仓库gitmodules提交的时候，不会提交code/RxSwift，可以为主仓库节省空间，把剩余空间分配到其他仓库


#### 克隆一个带子模块的项目
RxSwift目录存在了，但是是空的。你必须运行两个命令：git submodule init来初始化你的本地配置文件，git submodule update来从那个项目拉取所有数据并检出你上层项目里所列的合适的提交：

#### 详细解释
https://segmentfault.com/a/1190000003076028

#### 代码更新
去到RxSwift目录，进行相应的Git操作


### 第三方库存目录

另一种方法是，第三方库统一放到code目录下，下载源码放进去，各取所需
