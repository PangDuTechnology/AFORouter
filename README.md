# AFORouter

应用内路由（JLRoutes）与 `AFORouterManager` 页面跳转封装。

## 通过 GitHub 安装（CocoaPods）

在工程的 `Podfile` 中加入（将 `0.0.14` 换成你要使用的 [tag](https://github.com/PangDuTechnology/AFORouter/tags)）：

```ruby
platform :ios, '13.0'

pod 'AFORouter', :git => 'https://github.com/PangDuTechnology/AFORouter.git', :tag => '0.0.14'
```

然后执行：

```bash
pod install
```

### 依赖说明

本库会通过 CocoaPods 拉取：

- `AFOFoundation`
- `AFOSchedulerCore`

请确保 `Podfile` 中已配置官方源（默认 `https://cdn.cocoapods.org/` 即可）。

### 子模块说明

默认会安装 `router`（JLRoutes）与 `manager`（`AFORouterManager` 等）。根目录的 `AFORouting.{h,m}` 始终参与编译，因此 `AFOSchedulerCore` 为必需依赖；若需排除 `manager`，可在 `Podfile` 中使用 `:subspecs`，但仍会保留根目录源文件与对 `AFOSchedulerCore` 的依赖。

## 发布新版本到 GitHub

1. 修改根目录 `AFORouter.podspec` 中的 `s.version`。
2. 提交代码后打**同名** tag 并推送：

```bash
git tag 0.0.14
git push origin 0.0.14
```

tag 必须与 podspec 版本一致，他人才能用 `:tag => '0.0.14'` 稳定安装。

## 校验 podspec（维护者）

```bash
pod spec lint AFORouter.podspec --allow-warnings
```
