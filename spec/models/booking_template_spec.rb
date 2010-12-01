require 'spec_helper'

describe BookingTemplate do
  context "when new" do
    subject { BookingTemplate.new }
    
    specify { should be_valid }
    its(:to_s) { should == "? an ? CHF ?, ? (?)" }
    context "to_s(:short)" do
      it "should == \"? / ? CHF ?\"" do
        subject.to_s(:short).should == "? / ? CHF ?"
      end
    end
  end

  context "with title" do
    subject { BookingTemplate.new(:title => "Test")}
    
    its(:to_s) { should =~ /Test/ }
    context "to_s(:short)" do
      it "should == \"? / ? CHF ?\"" do
        subject.to_s(:short).should == "? / ? CHF ?"
      end
    end
  end

  context "with blank title" do
    subject { BookingTemplate.new(:title => "")}
    
    its(:to_s) { should == "? an ? CHF ?, ? (?)" }
    context "to_s(:short)" do
      it "should == \"? / ? CHF ?\"" do
        subject.to_s(:short).should == "? / ? CHF ?"
      end
    end
  end

  context "with accounts" do
    let(:credit_account) {
      mock_model(Account).tap{|a|
        a.stub!(:to_s).and_return("Credit Account (1000)")
        a.stub!(:to_s).with(:short).and_return("1000")
      }
    }
    let(:debit_account) {
      mock_model(Account).tap{|a|
        a.stub!(:to_s).and_return("Debit Account (2000)")
        a.stub!(:to_s).with(:short).and_return("2000")
      }
    }
    subject { BookingTemplate.new(:credit_account => credit_account, :debit_account => debit_account)}
    
    its(:to_s) { should == "Credit Account (1000) an Debit Account (2000) CHF ?, ? (?)" }
    context "to_s(:short)" do
      it "should == \"1000 / 2000 CHF ?\"" do
        subject.to_s(:short).should == "1000 / 2000 CHF ?"
      end
    end
  end

  describe "#build_booking" do
    context "on :cash record" do
      let(:cash) { Factory.build(:cash) }
      subject { booking } # Expects let(:booking) calls in nested contexts
    
      context "when called with no parameters" do
        let(:booking) { cash.build_booking }

        context "returns booking which" do
          specify { should be_a(Booking) }
          specify { should be_new_record }
          specify { should_not be_valid }
        end
      end
      
      context "when called with amount 10.0" do
        let(:booking) { cash.build_booking(:amount => 10.0) }

        context "returns booking which" do
          specify { should be_a(Booking) }
          specify { should be_new_record }
          specify { should_not be_valid }
          context "and whose" do
            its(:amount) { should == 10.0 }
          end
        end
      end

      context "when called with value_date 2001-02-03 as string" do
        let(:booking) { cash.build_booking(:value_date => "2001-02-03") }

        context "returns booking which" do
          specify { should be_a(Booking) }
          specify { should be_new_record }
          specify { should_not be_valid }
          context "and whose" do
            its(:value_date) { should == Date.parse("2001-02-03") }
          end
        end
      end

      context "when called with value_date 2001-02-03 as date" do
        let(:booking) { cash.build_booking(:value_date => Date.parse("2001-02-03")) }

        context "returns booking which" do
          specify { should be_a(Booking) }
          specify { should be_new_record }
          specify { should_not be_valid }
          context "and whose" do
            its(:value_date) { should == Date.parse("2001-02-03") }
          end
        end
      end

      context "when called with value_date 2001-02-03 and amount 10.0" do
        let(:booking) { cash.build_booking(:value_date => "2001-02-03", :amount => 10.0) }

        context "returns booking which" do
          specify { should be_a(Booking) }
          specify { should be_new_record }
          specify { should be_valid }
          context "and whose" do
            its(:value_date) { should == Date.parse("2001-02-03") }
            its(:amount) { should == 10.0 }
          end
        end
      end
    end
  end
=begin
  test "create_booking returns persisted record when valid" do
    assert booking_templates(:full).create_booking.persisted?
  end
  
  test "create_booking returns new record when invalid" do
    assert booking_templates(:partial).create_booking.new_record?
  end
  
  test "create_booking accepts hash" do
    assert_instance_of Booking, booking_templates(:partial).create_booking({:amount => 77})
  end

  test "create_booking accepts parameters" do
    assert_instance_of Booking, booking_templates(:partial).create_booking(:amount => 77)
  end

  test "class build_booking returns nil if no template with this code" do
    assert_nil BookingTemplate.create_booking("unreal", {:amount => 77})
  end

  test "class build_booking does lookup by code and build" do
    assert_instance_of Booking, BookingTemplate.create_booking("partial", {:amount => 77})
  end
=end

end
