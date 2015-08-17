# encoding: utf-8

require 'spec_helper'

describe BookingTemplateHelper do
  describe "#amount_relations_as_collection" do
    it "returns the amount relations" do
      expect(helper.amount_relations_as_collection).to eq({"Ursprünglicher Betrag" => "reference_amount",
                                                      "Aktueller Saldo" => "reference_balance",
                                                      "Differenz Betrag" => "reference_amount_minus_balance"})
    end
  end

  describe "#amount_to_s(booking_template)" do
    it "returns the amount as string when amount_relates_to is present" do
      expect(helper.amount_to_s(FactoryGirl.build(:invoice_booking_template))).to eq("100.00%")
    end

    it "returns the amount as string when amount_relates_to is not present" do
      expect(helper.amount_to_s(FactoryGirl.build(:invoice_without_amount_relates_to))).to eq("1.00")
    end
  end
end
