class ApiConstraints
  MIME_FORMAT = 'vnd.pseudocms.v%s+json'

  def initialize(version, default: false)
    @version = version
    @default = default
  end

  def matches?(request)
    return true if @default
    request.headers['Accept'].include?(MIME_FORMAT % @version)
  end
end
