module PageModels

  class TextfieldDetails < PageModels::AdminBlinkboxbooksSection
    element :textfield, 'input'
    element :label, 'label'
    element :error_message, 'p'
  end

  class DateDetails < PageModels::AdminBlinkboxbooksSection
    element :textfield, 'input[name^=campaign]'
    element :label, '[for^=campaign]'
    element :error_message, '.error-bubble'
    element :datetimepicker, '.dropdown-menu datetimepicker'
    #element :table_pop_up, '.datetimepicker table'
    element :ongoing_checkbox, '#campaign-ongoing'

    def ongoing_is_enable?
      ongoing_checkbox.checked?
    end

  end

  class CreditTextSection < PageModels::AdminBlinkboxbooksSection
    element :textfield, 'input'
    element :label, 'label'
    element :error_empty_field, '[data-test="error-credit-required"]'
    element :error_min_number, '[data-test="error-credit-min"]'
    element :error_credit_digit, '[data-test="error-credit-number"]'
  end

  class CheckBoxEnabled < PageModels::AdminBlinkboxbooksSection
    element :checkbox, '.checkbox input'
    element :label, 'label'
    elements :error_messages, '.input-group-btn p'
    element :textfield, '.input-group-btn input'

    def unlimited_is_enable?
      checkbox.checked?
    end

  end
  class ConfirmationPopup < PageModels::AdminBlinkboxbooksSection
    element :confirmation_name,  '[data-test="campaign-name"]'
    element :confirmation_description,'[data-test="campaign-description"]'
    element :confirmation_start_date, '[data-test="campaign-start-date"]'
    element :confirmation_end_date, '[data-test="campaign-end-date"]'
    element :confirmation_credit, '[data-test="campaign-credit"]'
    element :confirmation_redemption_limit, '[data-test="campaign-redemption-limit"]'
    element :yes_button, '.ngdialog-button ngdialog-button-primary'
    element :no_button, '.ngdialog-button ngdialog-button-secondary'

    def list_of_elements
      #[confirmation_name.text,confirmation_description.text,confirmation_start_date.text,confirmation]
    end
  end

  class CreateCampaignPage < PageModels::AdminBlinkboxbooksPage
    set_url '/#!/campaign/new'
    set_url_matcher /campaign\/new/

    section :campaign_name, TextfieldDetails, '[data-test="campaign-name-group"]'
    section :campaign_description,TextfieldDetails, '[data-test="campaign-description-group"]'
    section :campaign_start_date, DateDetails, '[data-test="campaign-start-group"]'
    section :campaign_end_date, DateDetails, '[data-test="campaign-end-group"]'
    section :campaign_credit, CreditTextSection, '[data-test="campaign-credit-group"]'
    section :redemption_limit, CheckBoxEnabled, '[data-test="campaign-redemption-group"]'
    element :submit_button, '#campaign-submit'
    section :confirmation_popup,ConfirmationPopup, '.ngdialog-content'

    def fill_in_campaign_details(name, description)
      campaign_name.textfield.set name
      campaign_description.textfield.set description
    end

    def set_start_date_for_campaign(start_date)
      campaign_start_date.textfield.set start_date
    end

    def set_end_date_for_campaign(end_date='')
      campaign_end_date.textfield.set end_date if !campaign_start_date.ongoing_is_enable?
    end

    def is_start_date_popup_visible
      campaign_start_date.textfield.click
      expect(campaign_start_date.datetimepicker).to be_visible
      #execute_script("$('#campaign-start-timepicker').datepicker('setDate', '01/01/2015')")
    end

    def fill_in_credit(voucher_credit)
      campaign_credit.textfield.set voucher_credit
    end

    def set_redemption_limit(limit='')
     redemption_limit.textfield.set limit if !redemption_limit.unlimited_is_enabled?
    end

    def submit_form
     submit_button.click
    end

    def has_error_with_dates?
      campaign_start_date.has_error_message? ||campaign_end_date.has_error_message?
    end

    def has_empty_field_errors?
      campaign_name.has_error_message? || campaign_description.has_error_message? || campagign_credit.has_error_empty_field?
    end

    def has_error_with_credit?
      campaign_credit.has_error_min_number? || campaign_credit.has_error_credit_digit?
    end

  end
  register_model_caller_method(CreateCampaignPage)
end