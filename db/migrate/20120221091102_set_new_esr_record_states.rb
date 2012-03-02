class SetNewEsrRecordStates < ActiveRecord::Migration
  def up
    bad_records = EsrRecord.find(:all, :conditions => {:state => 'bad'})
    bad_records.map{|e|
      e.update_state
      e.save
    }
    EsrRecord.update_all("state = 'paid'", "state = 'valid'")

    EsrRecord.missing.all.each{|er| er.remarks = ""; er.send(:assign_invoice); er.save}
  end
end
