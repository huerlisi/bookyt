class BookingImportObserver < ActiveRecord::Observer
  def after_save(importer)
    Rails.logger.info "Starting at #{start_time = Time.now} to import #{importer.csv_file_name} from #{importer.csv.url}."
    end_time = Time.now - start_time
    Rails.logger.info "Import ended in #{end_time}"
  end
end
