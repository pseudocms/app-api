module Paginator
  extend ActiveSupport::Concern

  PAGINATOR_DEFAULTS = {
    page: 1,
    per_page: Kaminari.config.default_per_page
  }

  def paginate(resource, base_uri = '')
    page_params = paginator_params
    page = [page_params[:page], 1].max
    per_page = [page_params[:per_page], max_per_page].min

    collection = resource.page(page).per(per_page)
    set_link_header(base_uri, collection, per_page)
    collection
  end

  def max_per_page
    Kaminari.config.max_per_page
  end

  def query_for_page(page, per_page)
    "?page=#{page}&per_page=#{per_page}"
  end

  private

  def paginator_params
    supplied_params = params.permit(:page, :per_page)
    page_params = PAGINATOR_DEFAULTS.merge(supplied_params).symbolize_keys
    Hash[page_params.map { |key, value| [key, Integer(value)] }]
  end

  def set_link_header(base_uri, collection, per_page)
    links = paginator_page_links(collection).map do |rel, page_num|
      "<#{base_uri}#{query_for_page(page_num, per_page)}>; rel=\"#{rel}\""
    end

    response.headers['Link'] = links.join(', ')
  end

  def paginator_page_links(collection)
    {}.tap do |pages|
      unless collection.first_page?
        pages[:first] = 1
        pages[:prev] = collection.current_page - 1
      end

      unless collection.last_page?
        pages[:last] = collection.total_pages
        pages[:next] = collection.current_page + 1
      end
    end
  end
end
