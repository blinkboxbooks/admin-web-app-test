module PageModels
  class TableRow < PageModels::AdminBlinkboxbooksSection

    elements :columns, 'td'

  end

  class HeaderColumn < PageModels::AdminBlinkboxbooksSection

    elements :headerColumns, 'th'

  end

  class Table < PageModels::AdminBlinkboxbooksSection

    sections :headers, HeaderColumn, 'thead tr'
    sections :rows, TableRow, 'tbody tr'

    def random_campaign
      rows.sample
    end

  end

  class Filter < PageModels::AdminBlinkboxbooksSection

    def title
      # button.text
      root_element.text
    end

    def selected?
      root_element[:class].include?('btn-info')
      #parent[:class].include?('btn-info')
    end

    def click
      puts "Click on #{title} button filter"
      # button.click
      root_element.click
    end
  end

  class DisplayEntriesDropdown < PageModels::AdminBlinkboxbooksSection
    elements :list, 'label option'

    def select_item(num)
      wait_until_list_visible
      item = list.find { |item| item.text == num }
      raise "Display \"#{num}\" of entries on page!" if item.nil?
      item.hover
      item.click
    end

  end

  class CampaignsPage < PageModels::AdminBlinkboxbooksPage
    set_url '#!/campaigns/'
    set_url_matcher /campaigns/

   sections :campaigns_filters, Filter, '#campaigns-filters label'
   section :table, Table, '#campaigns-table'
   section :display_entries_dropdown, DisplayEntriesDropdown, '#campaigns-table_length'
   element :number_of_entries_element, '#campaigns-table_info'

    def number_of_entries_displayed
      wait_for_number_of_entries_element
      number=number_of_entries_element.text.scan(/\d+/)[2].to_i
      number
    end

    def selected_filter
      campaigns_filters.find { |filter| filter.selected? }
    end

    def filter(filter_name)
      wait_for_campaigns_filters
      campaigns_filters.find do |filter|
        filter.title.downcase == filter_name.downcase
      end

    end
    def select_random_campaign
      sample=table.random_campaign
      raise 'There are no campaigns available in table' if sample.nil?
      sample.columns[0].click
    end

    def filter_based_on(filter_name)
      campaign_filter = filter(filter_name)
      unless campaign_filter.nil?
        campaign_filter.click
      else
        raise "Not recognised filter button: #{filter_name}"
      end
    end

    def display_entries(num)
      display_entries_dropdown.select_item(num)
    end

    def check_enabled_status(status)
      wait_for_table
      table.rows.select do |row|
        if table_is_empty? row.columns[0]
          raise "Campaign with ID #{row.columns[0].text} has not #{status} status" if row.columns[6].text.downcase != status
        end
      end
    end

    def table_is_empty? cell
      ! (cell.text =~ /No data available in table/)
    end

end
  register_model_caller_method(CampaignsPage)
end