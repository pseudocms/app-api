jest.dontMock("../pager")

_     = require("lodash")
Pager = require("../pager")

links = [
  { rel: "first", url: "/things" },
  { rel: "prev", url: "/things?page=1&per_page=20" },
  { rel: "next", url: "/things?page=3&per_page=20" },
  { rel: "last", url: "/things?page=4&per_page=20" }
]

makeXHR = (options = {}) ->
  options["links"] ||= links

  {
    responseJSON: options["records"] || ["Item 1", "Item 2", "Item 3"],
    getResponseHeader: (name) ->
      rels = options["links"].map (link) ->
        "<#{link.url}>; rel=\"#{link.rel}\""

      rels.join(", ")
  }

describe "Pager", ->

  describe "basic usage", ->
    beforeEach ->
      @xhr = makeXHR()
      @pager = Pager.paginate(@xhr)

    it "gets results from JSON response", ->
      expect(@pager.results).toBe(@xhr.responseJSON)

    it "sets firstPage and hasFirstPage values", ->
      expect(@pager.hasFirstPage).toBe(true)
      expect(@pager.firstPage).toBe(links[0].url)

    it "sets prevPage and hasPrevPage values", ->
      expect(@pager.hasPrevPage).toBe(true)
      expect(@pager.prevPage).toBe(links[1].url)

    it "sets nextPage and hasNextPage values", ->
      expect(@pager.hasNextPage).toBe(true)
      expect(@pager.nextPage).toBe(links[2].url)

    it "sets lastPage and hasLastPage values", ->
      expect(@pager.hasLastPage).toBe(true)
      expect(@pager.lastPage).toBe(links[3].url)

  describe "page not available", ->

    it "handles has and link value appropriately", ->
      xhr = makeXHR(links: _.rest(links))
      pager = Pager.paginate(xhr)
      expect(pager.hasFirstPage).toBe(false)
      expect(pager.firstPage).toBeUndefined()
