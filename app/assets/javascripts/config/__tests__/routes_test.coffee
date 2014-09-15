jest.dontMock("../routes")

describe "Routes", ->
  Routes = null

  beforeEach ->
    Routes = require("../routes")
    Routes.setBaseUrl("//example.com/")

  describe "path and url generation", ->
    beforeEach ->
      Routes.initRoutes
        "oauth_tokens": "/oauth/token"
        "admin_root": "/admin"

    it "makes a path function for each supplied route", ->
      expect(Routes.oauthTokensPath()).toBe("/oauth/token")
      expect(Routes.adminRootPath()).toBe("/admin")

    it "makes a url function for each supplied route", ->
      expect(Routes.oauthTokensUrl()).toBe("//example.com/oauth/token")
      expect(Routes.adminRootUrl()).toBe("//example.com/admin")

  describe "token replacement with object", ->
    beforeEach ->
      Routes.initRoutes
        "user": "/users/:id"
        "user_roles": "/users/:id/roles"
        "user_role": "/users/:id/roles/:role_id"

    it "replaces tokens with values from object", ->
      user =
        id: 1
        role_id: 2

      expect(Routes.userPath(user)).toBe("/users/1")
      expect(Routes.userRolesPath(user)).toBe("/users/1/roles")
      expect(Routes.userRoleUrl(user)).toBe("//example.com/users/1/roles/2")

  describe "token replacement with arguments", ->
    beforeEach ->
      Routes.initRoutes
        "root": "/"
        "user": "/users/:id"
        "user_role": "/users/:id/roles/:role_id"

    it "replaces tokens with ordered arguments", ->
      expect(Routes.userPath(1)).toBe("/users/1")
      expect(Routes.userRoleUrl(1, "admin")).toBe("//example.com/users/1/roles/admin")

    it "ignores extra arguments", ->
      expect(Routes.userPath(1, "this", 2, "be", "ignored")).toBe("/users/1")

    it "returns the unmodified route when no tokens are found", ->
      expect(Routes.rootPath(1, 2)).toBe("/")
