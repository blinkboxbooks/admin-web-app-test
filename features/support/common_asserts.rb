require 'capybara/dsl'
require 'capybara/rspec/matchers'
require 'capybara/selenium/node'
require 'date'

module AssertNavigation

  def assert_page(page_name)
    page = page_model(page_name)
    #unless page.displayed?
    #  raise RSpec::Expectations::ExpectationNotMetError, "Page verification failed\n   Expected page: '#{page_name}' with url_matcher #{page.url_matcher}\n   Current url: #{current_url}"
    #end
    page.wait_until_displayed
  rescue PageModelHelpers::TimeOutWaitingForPageToAppear => e
    raise RSpec::Expectations::ExpectationNotMetError, "Page verification failed\n   Expected page: '#{page_name}' with url_matcher #{page.url_matcher}\n   Current url: #{current_url}\nTimeOutWaitingForPageToAppear: #{e.message}"
  end

  alias :expect_page_displayed :assert_page

  def which_date_is (date, row)
    if date == 'start date'
      cell = row.columns[3].text
    else
      cell = row.columns[4].text
    end
    cell
  end

  def check_date(date, value)
    count=0
    campaigns_page.wait_for_table
    campaigns_page.table.rows.select do |row|
      if !(row.columns[0].text =~ /No data available in table/)
        cell= which_date_is(date, row)
        next unless !cell.empty?
        puts "#{count=count+1} #{cell}"
        expect(DateTime.parse  cell).to eval("be_in_the_#{value}")
      end
    end
  end

  def check_start_date_and_end_date( value1, value2)
    count=0
    campaigns_page.wait_for_table
    campaigns_page.table.rows.select do |row|
      if !(row.columns[0].text =~ /No data available in table/)
        start_date=row.columns[3].text
        expect(DateTime.parse  start_date).to eval("be_in_the_#{value1}")
        end_date=row.columns[4].text
        puts "#{count=count+1} #{start_date} #{end_date}"
        next unless !end_date.empty?
        expect(DateTime.parse  end_date).to eval("be_in_the_#{value2}")
      end
    end
  end

  def check_table_header_values
    campaigns_page.wait_for_table
    header_array=["ID", "Name", "Description","Start Date", "End Date", "Creation Date","Enabled"]
    campaigns_page.table.headers.each do |row|
      row.headerColumns.each { |column|
        # puts "#{column.text}"
        expect(header_array).to be_in_header(/#{column.text}/i)
      }
    end
  end

  def check_test
    campaigns_page.wait_for_table
    actual_headers = campaigns_page.table.headers[0].headerColumns.collect { |i| i.text }
    expect(["ID", "Name", "Description","Start Date", "End Date", "Creation Date","Enabled"]).to match_array(actual_headers)
  end

  def check_number_of_entries_all_filter
    campaigns_page.wait_for_table
    actual_number_of_entries=campaigns_page.number_of_entries_displayed
    expect(campaigns_page.table.rows.count).to eq(actual_number_of_entries)
  end

end
World(AssertNavigation)