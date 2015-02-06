module PageModels

  class CampaignDetailsSection < PageModels::AdminBlinkboxbooksSection

    element :campaign_ID, '[data-test="campaign-id"]'
    element :campaign_name_element, '[data-test="campaign-name"]'
    element :campaign_description_element, '[data-test="campaign-description"]'
    element :campaign_type_element, '[data-test="campaign-type"]'
    element :campaign_start_date, '[data-test="campaign-start-date"]'
    element :campaign_end_date, '[data-test="campaign-end-date"]'
    element :campaign_status, '[data-test="campaign-enabled"]'
    element :voucher_credit, '[data-test="campaign-credit"]'
    element :campaign_vouchers, '[data-test="campaign-num-vouchers"]'
    element :vouchers_redeemed, '[data-test="campaign-num-redeemed"]'
    element :redemption_limit, '[data-test="campaign-redemption-limit"]'
    element :creation_date, '[data-test="campaign-creation-date"]'
    element :creation_by, '[data-test="campaign-created-by"]'

    def mandatory_fields_empty?
      campaign_name_element.text.empty? || campaign_description_element.text.empty?  || campaign_start_date.text.empty? || campaign_status.text.empty? || voucher_credit.text.empty?
    end

    def list_of_elements
      #[name, description,"Credit Campaign", credit_amount,limit,'Yes',start_date, end_date]
      [campaign_name_element,campaign_description_element, campaign_type, voucher_credit, redemption_limit, campaign_status, campaing_start_date, campaign_end_date]
    end
  end

  class CampaignDetailsPage < PageModels::AdminBlinkboxbooksPage
    set_url '/#!/campaign/{id}'
    set_url_matcher /campaign\/[0-9]+/

    section :campaign_details_list, CampaignDetailsSection, '.dl-horizontal'

    def list_is_empty
      wait_for_campaign_details_list
      campaign_details_list.mandatory_fields_empty?
    end

    def list_is_full
      wait_for_campaign_details_list
      !campaign_details_list.mandatory_fields_empty?
    end

  end
  register_model_caller_method(CampaignDetailsPage)
end