module V1
  class SitesController < ApplicationController
    allow(:index) { blessed_app? || current_user }

    def index
      sites = if blessed_app?
                Site.all
              else
                current_user.sites
              end

      respond_with(paginate(sites, sites_url))
    end
  end
end
