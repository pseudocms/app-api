module V1
  class SitesController < ApplicationController
    allow(:index)   { blessed_or_user? }
    allow(:show)    { blessed_or_user? }
    allow(:create)  { blessed_or_user? }
    allow(:update)  { blessed_or_user? }
    allow(:destroy) { blessed_or_user? }

    before_action :blessed_or_associated?, only: [:show, :update]
    before_action :blessed_or_owner?, only: [:destroy]

    # GET /sites
    def index
      sites = blessed_app? ? Site.all : current_user.sites
      respond_with(paginate(sites, sites_url))
    end

    # GET /sites/:id
    def show
      respond_with(site)
    end

    # POST /sites
    def create
      user = current_user
      user = User.find(owner_params[:owner_id]) if blessed_app?

      new_site = user.owned_sites.create(site_params)
      respond_with(new_site, location: new_site)
    end

    # PATCH /sites/:id
    def update
      site.update_attributes(site_params)
      respond_with(site)
    end

    # DELETE /sites/:id
    def destroy
      site.destroy
      head(:no_content)
    end

    private

    def site
      @site ||= Site.find(params[:id])
    end

    def site_params
      params.require(:site).permit(:name, :description)
    end

    def owner_params
      params.require(:site).permit(:owner_id)
    end

    def blessed_or_user?
      blessed_app? || current_user
    end

    def blessed_or_owner?
      head(:forbidden) unless blessed_app? || site.user_id == current_user.id
    end

    def blessed_or_associated?
      head(:forbidden) unless blessed_app? || site.users.include?(current_user)
    end
  end
end
