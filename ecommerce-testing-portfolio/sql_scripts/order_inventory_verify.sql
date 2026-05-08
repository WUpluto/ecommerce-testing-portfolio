/* 业务场景：在用户完成下单并支付后，测试人员需要进数据库核对
【订单状态】、【库存扣减】、【支付流水】的数据一致性。
*/

-- 1. 检查订单主表，确认订单状态是否已从 '待支付(10)' 更新为 '已支付/待发货(20)'
SELECT order_no, user_id, total_amount, pay_status 
FROM t_order 
WHERE order_no = 'ORD20260508123456';

-- 2. 检查库存表，验证对应 SKU 的可用库存是否正确扣减
-- (假设商品原库存为 100，购买了 2 件，此处 stock 应为 98)
SELECT sku_id, stock_available, stock_locked 
FROM t_inventory 
WHERE sku_id = 'SKU_99887766';

-- 3. 多表关联查询 (进阶)：一键核验用户、订单与流水的金额对账
SELECT 
    o.order_no,
    u.username,
    o.total_amount AS order_amount,
    p.pay_amount AS actual_pay,
    p.pay_time
FROM t_order o
JOIN t_user u ON o.user_id = u.id
JOIN t_pay_record p ON o.order_no = p.order_no
WHERE o.order_no = 'ORD20260508123456' 
AND p.status = 'SUCCESS';
