module PageModels
    class MainMenuTab < PageModels::AdminBlinkboxbooksSection
      element :link, 'a'

      def title
        link.text
      end

      def selected?
        root_element[:class].include?('active')
      end

    end

  class MainMenu < PageModels::AdminBlinkboxbooksSection
    sections :tabs, MainMenuTab, 'li'

    def selected?
      !!tabs.find { |tab| tab.selected? }
    end

    def select(tab_name)
      wait_until {all_there?}
      wait_until {tabs[0].selected?}
      tab = tabs.find {|tab| tab.title.downcase == tab_name.downcase}
      if tab.nil?
        fail "#{tab_name} is not found."
      else
        tab.link.click
      end
    end

  end
  class Header < PageModels::AdminBlinkboxbooksSection
    element :page_title, 'h1 a'
    element :welcome_message, '.user span'
    element :login, '.user button'
    element :log_out_button, '[data-test="logout-button"]'
            # '.user span button'
    section :menu, MainMenu, 'navmenu ul'

    def user_role_displayed
      # welcome_message.text.scan(/.+\((\w+)\)/)[0][0]
      wait_for_welcome_message
      welcome_message.text.match(/.+\((\w+)\)/)[1]
    end

    def logged_in?
      !user_role_displayed.nil?
    end

  end

  class AdminBlinkboxbooksPage < SitePrism::Page
    include WebUtilities
    include WaitSteps
    set_url '/'
    set_url_matcher /#{Capybara.app_host}\/?(?:#!\/)?$/

    section :header, Header, '#header'

    def navigation_timeout
      Capybara.default_wait_time
    end

    def wait_until_displayed(timeout = navigation_timeout)
      r0 = Time.now
      SitePrism::Waiter.wait_until_true(timeout) { displayed? }
    rescue SitePrism::TimeoutException
      raise PageModelHelpers::TimeOutWaitingForPageToAppear.new, 'Timed out waiting for page to be displayed'
    ensure
      puts "Load time of #{self.class.name.demodulize}: #{Time.now - r0} sec"
    end
  end
def current_page
    @_current_page ||= AdminBlinkboxbooksPage.new
  end
end