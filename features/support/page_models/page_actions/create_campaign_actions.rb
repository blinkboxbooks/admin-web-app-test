module PageModels
  module CreateCampaignActions
    # Pick a date from datepicker.
    # It removes readonly attribute to fill in an input field with date.
    #
    # @param name [String, Symbol] name or part of name of input field
    # @param date [String, Date, Time, DateTime]
    # @param format [String] date format
    #
    # @return [void]
    def pick_date(name, date, format = '%m/%d/%y')
      if date.class.in?([Time, DateTime, Date])
        date = date.strftime(format)
      end
      wrapped_name = "[#{name}]"
      id = @context.find(:xpath, "//input[contains(@name, '#{wrapped_name}')]")[:id]
      page.execute_script("$('##{id}').removeAttr('readonly')")
      fill_in name, :with => date
    end


  end
end
World(PageModels::CreateCampaignActions)