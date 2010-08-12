require 'test_helper'

class BookingTemplateTest < ActiveSupport::TestCase
  test "to_s handles templates with few information" do
    template = BookingTemplate.new
    assert_equal "?: ? an ? CHF ?, ? (?)", template.to_s
    
    template.title = "Test"
    assert_equal "?: ? an ? CHF ?, Test (?)", template.to_s

    template.value_date = '2010-03-02'
    assert_equal "02.03.2010: ? an ? CHF ?, Test (?)", template.to_s

    template.credit_account = accounts(:ubs)
    assert_equal "02.03.2010: UBS (1002) an ? CHF ?, Test (?)", template.to_s

    template.debit_account = accounts(:postfinance)
    assert_equal "02.03.2010: UBS (1002) an Postfinance (1001) CHF ?, Test (?)", template.to_s

    template.comments = "Comment"
    assert_equal "02.03.2010: UBS (1002) an Postfinance (1001) CHF ?, Test (Comment)", template.to_s

    template.amount = "77.3"
    assert_equal "02.03.2010: UBS (1002) an Postfinance (1001) CHF 77.30, Test (Comment)", template.to_s
  end
end
