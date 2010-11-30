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

end
