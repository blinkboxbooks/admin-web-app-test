module StepActions
  def select_campaigns_all_entries
    current_page.wait_until_header_visible(10)
    current_page.header.menu.select('Campaigns')
    expect_page_displayed('Campaigns')
    campaigns_page.display_entries('All')
  end
end
World(StepActions)