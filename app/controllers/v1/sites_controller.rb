module V1
  class SitesController < ApplicationController
    allow(:index)   { blessed_or_user? }
    allow(:show)    { blessed_or_user? }
    allow(:create)  { blessed_or_user? }
    allow(:update)  { blessed_or_user? }
    allow(:destroy) { blessed_or_user? }

    before_action :ensure_blessed_or_associated?, only: [:show, :update]
    before_action :ensure_blessed_or_owner?, only: [:destroy]
    before_action :ensure_owner_exists, only: [:create], if: :blessed_app?

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
      params.permit(:name, :description)
    end

    def owner_params
      params.permit(:owner_id)
    end

    def blessed_or_user?
      blessed_app? || current_user
    end

    def ensure_blessed_or_owner?
      render_denied unless blessed_app? || site.user_id == current_user.id
    end

    def ensure_blessed_or_associated?
      render_denied unless blessed_app? || site.users.include?(current_user)
    end

    def ensure_owner_exists
      User.find(owner_params[:owner_id])
    rescue ActiveRecord::RecordNotFound
      render_error("Owner not found", status: :not_found)
    end
  end
end
