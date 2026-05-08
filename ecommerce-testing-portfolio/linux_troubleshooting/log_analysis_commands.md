# 测试环境 Linux 日志排障常用命令记录

在测试环境（QA Env）遇到前端报 `HTTP 500` 或接口超时（Timeout）时，通过以下命令快速定位后端报错堆栈：

1. **实时监控服务日志 (查看是否有请求打进来)**
   ```bash
   tail -f /app/logs/ecommerce-order-service.log
