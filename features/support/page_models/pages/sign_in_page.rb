module PageModels
  class SignInPage < PageModels::AdminBlinkboxbooksPage
    set_url '/#!/login'
    set_url_matcher /login/

    element :email, 'input[name="email"]'
    element :password, 'input[name="password"]'
    element :remember_me, 'input[name="remember"]'
    element :sign_in_button, 'button[class~=btn]', :text => /Sign in/i

    def submit(email, password, remember_me = false)
      wait_until {all_there?}
      self.email.set email
      self.password.set password
      self.remember_me.set remember_me
      self.sign_in_button.click
    end

    def fill_in_password(password)
      self.password.set password
    end

    def click_sign_in_button
      wait_for_sign_in_button
      sign_in_button.click
    end

  end
  register_model_caller_method(SignInPage)
end