module Paginator
  extend ActiveSupport::Concern

  PAGINATOR_DEFAULTS = {
    page: 1,
    per_page: WillPaginate.per_page
  }

  def paginate(resource)
    page_params = paginator_params
    page_params[:page] = [page_params[:page], 1].max
    page_params[:per_page] = [page_params[:per_page], max_per_page].min
    resource.paginate(page_params)
  end

  def max_per_page
    100
  end

  private

  def paginator_params
    PAGINATOR_DEFAULTS.merge(params.permit(:page, :per_page)).symbolize_keys
  end
end
