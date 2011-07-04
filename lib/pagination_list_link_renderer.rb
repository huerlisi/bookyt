class PaginationListLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer

  def html_container(html)
    @search_key = :search
    @params = @template.params[@search_key] || {}

    html = [per_page_link(25), per_page_link(50), per_page_link(200)].join('') + "<span>|</span>" + html
    html += "</div><div style='clear: both; padding-top: 0.5em;'>" + alphabetic_pagination
    html = "<div style='clear: both'>" + html + "</div>"
    tag(:div, html, container_attributes)
  end

  def alphabetic_pagination
    paginated_scope = @template.instance_variable_get(:@paginated_scope)
    return "" unless paginated_scope

    characters = paginated_scope.character_list
    page_links = characters.map{|character| alphabetic_page_link(character)}
    all_links = Array.new
    all_links << alphabetic_page_link(I18n.t('katalog.show_all'), :link_keyword => '')
    all_links.concat(page_links)

    all_links.join('')
  end

  def alphabetic_page_link(character, options = {})
    if character == @params[:by_character]
      link = "<em>%s</em>" % character.upcase
    else
      link = "<a class='per_page' href='%s'>%s</a>" % [alphabetic_page_href((options[:link_keyword] ? options[:link_keyword] : character)), character.upcase]
    end

    link
  end

  def alphabetic_page_href(character)
    # Add character to query
    search_params = @params.merge(:by_character => character)
    params = @template.params.merge(@search_key => search_params)
    # Drop page index
    params.delete(:page)

    @template.url_for(params)
  end

  def per_page_link(count)
    if count == @template.params[:per_page].to_i
      link = "<em>%s</em>"  % count
    else
      link = "<a class='per_page' href='%s'>%s</a>" % [per_page_href(count), count]
    end

    link
  end

  def per_page_href(count)
    params = @template.params.merge({:per_page => count})
    # Drop page index
    params.delete(:page)

    @template.url_for(params)
  end
end
