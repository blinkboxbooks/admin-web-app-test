Given(/^I am logged in as a (api|CSM|csr|ops|me|ctm|mkt) user$/i) do |role|
  sign_in(role)
end