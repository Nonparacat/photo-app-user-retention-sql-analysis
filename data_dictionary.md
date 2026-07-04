# Data Dictionary｜数据字典

本项目所有数据均为模拟生成，用于 SQL / Excel 用户行为分析练习和求职作品集展示。

## 1. users.csv

| 字段 | 类型 | 说明 |
|---|---:|---|
| user_id | string | 用户唯一 ID |
| register_date | date | 注册日期 |
| channel | string | 注册渠道：organic、douyin_ads、xiaohongshu、app_store、wechat |
| device | string | 设备类型：iOS、Android |
| city | string | 用户所在城市 |
| gender | string | 性别 |
| age_group | string | 年龄段 |

## 2. events.csv

| 字段 | 类型 | 说明 |
|---|---:|---|
| event_id | string | 事件唯一 ID |
| user_id | string | 用户 ID |
| event_time | datetime | 事件发生时间 |
| event_date | date | 事件发生日期 |
| event_name | string | 事件名称 |

事件类型：

| 事件 | 说明 |
|---|---|
| app_open | 打开 App |
| photo_upload | 上传照片 |
| filter_use | 使用滤镜 |
| photo_export | 导出图片 |
| photo_share | 分享图片 |
| subscription_click | 点击订阅入口 |

## 3. orders.csv

| 字段 | 类型 | 说明 |
|---|---:|---|
| order_id | string | 订单唯一 ID |
| user_id | string | 用户 ID |
| order_time | datetime | 下单时间 |
| order_date | date | 下单日期 |
| product_type | string | 商品类型 |
| amount | float | 订单金额 |
| payment_status | string | 支付状态 |

## 4. 核心指标口径

```text
DAU = 当日打开 App 的去重用户数
新增用户数 = 当日注册用户数
次日留存率 = 注册后第 1 天仍打开 App 的用户数 / 注册用户数
7日留存率 = 注册后第 7 天仍打开 App 的用户数 / 注册用户数
付费转化率 = 付费用户数 / 注册用户数
ARPPU = 总收入 / 付费用户数
复购率 = 订单数大于等于 2 的付费用户数 / 付费用户数
```
