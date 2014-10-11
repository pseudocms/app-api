require "execjs"

module Reactor
  class Compiler
    JSX_FILE    = Rails.root.join("node_modules/react/dist/JSXTransformer.js")
    COFFEE_FILE = Rails.root.join("vendor/assets/javascripts/coffee-script.js")
    JSX_PRAGMA  = %r{/\*\* @jsx React\.DOM \*/}

    attr_reader :source

    def initialize(source, coffee: false, jsx: false)
      @source = source
      @options = { coffee: coffee, jsx: jsx }
    end

    def compile
      @compile ||= begin
        code = source.dup
        code = coffee_compile(code) if coffee?
        code = jsx_compile(code) if jsx?
        code
      end
    end

    def coffee?
      !!@options[:coffee]
    end

    def jsx?
      !!@options[:jsx]
    end

    private

    def coffee_compile(code)
      self.class.context.call("CoffeeScript.compile", code, bare: true)
    end

    def jsx_compile(code)
      result = self.class.context.call("JSXTransformer.transform", jsxify(code))
      result["code"].sub(JSX_PRAGMA, "").gsub(/\n/, " ").gsub(/\s+/, " ").strip
    end

    def jsxify(code)
      return code if JSX_PRAGMA =~ code
      "/** @jsx React.DOM */\n#{code}"
    end

    def self.context
      @context ||= begin
        script = <<-SCRIPT
        #{File.read(COFFEE_FILE)}
        #{File.read(JSX_FILE)}
        SCRIPT
        ExecJS.compile(script)
       end
    end
  end
end
