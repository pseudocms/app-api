module V1
  class SitesController < ApplicationController
    allow(:index)  { blessed_or_user? }
    allow(:show)   { blessed_or_user? }
    allow(:create) { blessed_or_user? }
    allow(:update) { blessed_or_user? }

    # GET /sites
    def index
      sites = blessed_app? ? Site.all : current_user.sites
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

      site = user.owned_sites.create(site_params)
      respond_with(site, location: site)
    end

    # PATCH /sites/:id
    def update
      site = Site.find(params[:id])
      return head(:forbidden) unless blessed_app? || site.users.include?(current_user)

      site.update_attributes(site_params)
      respond_with(site)
    end

    private

    def site_params
      params.require(:site).permit(:name, :description)
    end

    def owner_params
      params.require(:site).permit(:owner_id)
    end

    def site_not_found
      head(:not_found)
    end

    def blessed_or_user?
      blessed_app? || current_user
    end
  end
end
