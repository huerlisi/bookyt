class ChargeRate < ActiveRecord::Base
  # String
  def to_s(format = :default)
    return "" if (title.blank? or rate_to_s.blank?)

    case format
      when :long
        from = duration_from.nil? ? "" : I18n::localize(duration_from)
        to   = duration_to.nil? ? "" : I18n::localize(duration_to)
        "%s: %s (%s - %s)" % [title, rate_to_s, from, to]
      else
        "%s (%s)" % [title, rate_to_s]
    end
  end

  def rate_to_s
    if relative?
      "%s%%" % rate.to_s
    else
      "%s" % rate.to_s
    end
  end

  # Sorting
  default_scope order('duration_from DESC')

  # Validity
  scope :valid_at, lambda {|value| where("duration_from <= :date AND (duration_to IS NULL OR duration_to > :date)", :date => value) }
  scope :valid, lambda { valid_at(Date.today) }
  scope :latest, group(:code, :person_id)

  def self.current(code, date = nil)
    date ||= Date.today
    valid_at(date).find_by_code(code)
  end

  # Person
  belongs_to :person
  scope :by_person, lambda {|value| value ? where(:person_id => value) : scoped}
end
