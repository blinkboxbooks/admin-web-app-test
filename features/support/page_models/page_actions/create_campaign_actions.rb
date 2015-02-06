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

    def create_campaign_list_of_elements(name,description,credit_amount,redemption_limit,start_date,end_date)
      create_campaign_page.redemption_limit.unlimited_is_enable? ? limit='Unlimited': limit=redemption_limit
      create_campaign_page.campaign_start_date.ongoing_is_enable? ? end_date='Ongoing': end_date=end_date

      array=[name, description,"Credit Campaign", credit_amount,limit.to_s,'Yes',start_date, end_date]
      array
    end

  end
end
World(PageModels::CreateCampaignActions)