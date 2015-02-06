After do |scenario|
  if open_windows.count > 0
    sign_in.load unless current_page.header.has_welcome_message?
    #log_out_current_session if logged_in_session?
  end
end