module PagerHelper
  def month_title(date_or_range)
    if date_or_range.respond_to?(:first)
      date = date_or_range.first
    else
      date = date_or_range
    end

    month_name = t('date.month_names')[date.month]
    l(date.to_date, :format => "#{month_name} %Y")
  end

  def current_month_period(param_key)
    param = params[param_key]
    if param
      return Date.parse(param[:from])..Date.parse(param[:to])
    else
      return Date.today.beginning_of_month..Date.today.end_of_month
    end
  end

  def month_pages(param_key)
    links = (0..11).collect do |i|
      period = Time.now.months_ago(i).all_month
      
      content_tag(:li) do
        if period == current_month_period(param_key)
          label = 'active'
        else
          label = 'disabled'
        end

        link_to boot_label(month_title(period), label), url_for(params.merge({param_key => {:from => period.first.to_date.to_s(:db), :to => period.last.to_date.to_s(:db)}}))
      end
    end

    links.join.html_safe
  end
end
