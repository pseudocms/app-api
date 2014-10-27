_ = require("lodash")

LINK_PATTERN = /<([^>]+)>; rel="([^"]+)"/

extractLinks = (linkHeader) ->
  links = {}
  _.forEach linkHeader.split(","), (link) ->
    match = link.match(LINK_PATTERN)
    links[match[2]] = match[1]

  links

Pager =
  paginate: (xhr) ->
    links = extractLinks(xhr.getResponseHeader("Link"))

    {
      results: xhr.responseJSON,

      firstPage: links["first"],
      prevPage: links["prev"],
      nextPage: links["next"],
      lastPage: links["last"],

      hasFirstPage: links["first"]?,
      hasPrevPage: links["prev"]?,
      hasNextPage: links["next"]?,
      hasLastPage: links["last"]?
    }

module.exports = Pager
