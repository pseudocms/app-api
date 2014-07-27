module V1
  class SitesController < ApplicationController
    allow(:index) { blessed_app? || current_user }
    allow(:create) { blessed_app? || current_user }

    # GET /sites
    def index
      sites = if blessed_app?
                Site.all
              else
                current_user.sites
              end

      respond_with(paginate(sites, sites_url))
    end

    # GET /sites/:id
    def show
      site = Site.find(params[:id])
      return head(:forbidden) unless blessed_app? || site.users.include?(current_user)

      respond_with(site)
    end

    # POST /sites
    def create
      user = current_user
      user = User.find(owner_params[:owner_id]) if blessed_app?

      site = user.owned_sites.create(create_params)
      respond_with(site, location: site)
    end

    private

    def create_params
      params.require(:site).permit(:name, :description)
    end

    def owner_params
      params.require(:site).permit(:owner_id)
    end

    def site_not_found
      head(:not_found)
    end
  end
end
