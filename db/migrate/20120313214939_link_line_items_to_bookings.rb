
class LinkLineItemsToBookings < ActiveRecord::Migration
  def up
    # Monkey patch Invoice to adjust for new model
    class Invoice
      def calculate_amount ; end
      def update_amount ; end
      def calculate_due_amount ; end
      def update_due_amount ; end
    end

    # Cleanup
    say_with_time "Destroy stray line items" do
      LineItem.all.select{|li| li.invoice.nil?}.map(&:destroy)
    end

    # Assign bookings to line items
    say_with_time "Assigning Bookings to LineItems" do
      LineItem.all.map do |li|
        say "#{li.id}: #{li}"

        i = li.invoice
        bookings = i.bookings.where(:title => li.title, :amount => li.total_amount, :credit_account_id => li.credit_account_id, :debit_account_id => li.debit_account_id, :value_date => i.value_date)
        if bookings.empty?
          say "  no match"
        elsif bookings.count > 1
          say "  more than one match (booking ids: #{bookings.pluck(:id).join(', ')})"
        else
          b = bookings.first
          b.template = li
          if b.save(:validate => false)
            say "  assigned"
          else
            say "  could not save booking"
          end
        end
      end
    end

    # Reload Invoice model to get rid of monkey patching
    load "invoice.rb"
  end
end
