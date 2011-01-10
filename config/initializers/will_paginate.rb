# coding: utf-8
require 'pagination_list_link_renderer'

WillPaginate::ViewHelpers.pagination_options[:previous_label] = 'Vorherige Seite'
WillPaginate::ViewHelpers.pagination_options[:next_label] = 'Nächste Seite'
WillPaginate::ViewHelpers.pagination_options[:class] = 'digg_pagination'
WillPaginate::ViewHelpers.pagination_options[:renderer] = 'PaginationListLinkRenderer'
WillPaginate::ViewHelpers.pagination_options[:show_always] = true
