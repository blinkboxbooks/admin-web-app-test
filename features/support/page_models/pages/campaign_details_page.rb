module PageModels
  class CampaignDetailsPage < PageModels::AdminBlinkboxbooksPage
    set_url '/#!/campaign/{id}'
    set_url_matcher /campaign\/[0-9]+/

  end
  register_model_caller_method(CampaignDetailsPage)
end