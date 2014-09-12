jest.dontMock("../formats")

describe "Formats", ->
  Formats = null

  beforeEach ->
    Formats = require("../formats")

  describe "Email pattern", ->
    it "matches valid email addresses", ->
      validEmails = [
        "john.smith@gmail.com",
        "john.smith+junk-folder@myspot.net",
        "mr.miyagi@is.a.punk.org"
      ]

      expect(Formats.EMAIL_PATTERN.test(email)).toBe(true) for email in validEmails

    it "doesn't match invalid email addresses", ->
      invalidEmails = [
        null,
        undefined,
        "",
        "something",
        "david\"s@email.com",
        "symbols(are@not.allowed"
      ]

      expect(Formats.EMAIL_PATTERN.test(email)).toBe(false) for email in invalidEmails
