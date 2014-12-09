After do |scenario|
  if open_windows.count > 0
    log_out_current_session if logged_in_session?
  end
end