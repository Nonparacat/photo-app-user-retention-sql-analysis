# SQL Run Guide

本项目 SQL 以 SQLite 风格为主。

## 推荐工具

- DB Browser for SQLite
- DBeaver
- SQLiteStudio

## 基本流程

1. 新建数据库文件，例如 `photo_app_analysis.db`；
2. 导入三个 CSV：
   - `users.csv` 导入为 `users`
   - `events.csv` 导入为 `events`
   - `orders.csv` 导入为 `orders`
3. 运行 `sql/` 目录下的 SQL 文件。
