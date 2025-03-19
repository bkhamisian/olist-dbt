select *
from {{ metrics.calculate(
    metric('customers_with_orders'),
    grain='day'
) }}