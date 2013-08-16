# encoding: UTF-8

begin
  Settings.defaults = {
    'payment_period' => 30.days,

    'modules.enabled'   => []
  }
rescue
  Settings = {
    'payment.period' => 30.days,
    'modules.enabled' => []
  }
end
