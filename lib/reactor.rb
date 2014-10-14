require "execjs"
require "connection_pool"

class Reactor
  JSX_FILE    = Rails.root.join("node_modules/react/dist/JSXTransformer.js")
  JSX_PRAGMA  = %r{/\*\* @jsx React\.DOM \*/}

  def self.compile(code)
    pool.with do |compiler|
      compiler.compile(code)
    end
  end

  def compile(code)
    result = self.class.context.call("JSXTransformer.transform", jsxify(code))
    massage(result["code"])
  end

  private

  def jsxify(code)
    return code if JSX_PRAGMA =~ code
    "/** @jsx React.DOM */\n#{code}"
  end

  def massage(code)
    code.gsub(/\n/, " ")
        .gsub(/\s+/, " ")
        .sub(JSX_PRAGMA, "")
        .strip
  end

  def self.pool
    @pool ||= ConnectionPool.new(size: 10, timeout: 20) { new }
  end

  def self.context
    @context ||= ExecJS.compile(File.read(JSX_FILE))
  end
end
