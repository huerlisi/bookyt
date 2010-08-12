require 'test_helper'

class BookingTemplateTest < ActiveSupport::TestCase
  setup do
    @template = BookingTemplate.new
  end
  
  test "to_s handles all empty template" do
    assert_equal "?: ? an ? CHF ?, ? (?)", @template.to_s
    assert_equal "?: ? / ? CHF ?", @template.to_s(:short)
  end
    
  test "to_s handles template with title" do
    @template.title = "Test"
    assert_equal "?: ? an ? CHF ?, Test (?)", @template.to_s
    assert_equal "?: ? / ? CHF ?", @template.to_s(:short)
  end
    
  test "to_s suppress blanks titles" do
    @template.title = " "
    assert_equal "?: ? an ? CHF ?, ? (?)", @template.to_s
    assert_equal "?: ? / ? CHF ?", @template.to_s(:short)
  end
  
  test "to_s handles template with value date" do
    @template.value_date = '2010-03-02'
    assert_equal "02.03.2010: ? an ? CHF ?, ? (?)", @template.to_s
    assert_equal "02.03.2010: ? / ? CHF ?", @template.to_s(:short)
  end
    
  test "to_s handles template with credit_account" do
    @template.credit_account = accounts(:ubs)
    assert_equal "?: UBS (1002) an ? CHF ?, ? (?)", @template.to_s
    assert_equal "?: 1002 / ? CHF ?", @template.to_s(:short)
  end
    
  test "to_s handles template with debit_account" do
    @template.debit_account = accounts(:postfinance)
    assert_equal "?: ? an Postfinance (1001) CHF ?, ? (?)", @template.to_s
    assert_equal "?: ? / 1001 CHF ?", @template.to_s(:short)
  end
    
  test "to_s handles template with comments" do
    @template.comments = "Comment"
    assert_equal "?: ? an ? CHF ?, ? (Comment)", @template.to_s
    assert_equal "?: ? / ? CHF ?", @template.to_s(:short)
  end
    
  test "to_s suppress blanks comments" do
    @template.comments = " "
    assert_equal "?: ? an ? CHF ?, ? (?)", @template.to_s
    assert_equal "?: ? / ? CHF ?", @template.to_s(:short)
  end
  
  test "to_s handles template with amount" do
    @template.amount = "77.3"
    assert_equal "?: ? an ? CHF 77.30, ? (?)", @template.to_s
    assert_equal "?: ? / ? CHF 77.30", @template.to_s(:short)
  end
end
