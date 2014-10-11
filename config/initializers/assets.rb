class DirectiveProcessor < Sprockets::DirectiveProcessor
  def process_stub_directory_directive(path = ".")
    dirname = File.expand_path(path, Rails.root.join("app/assets/javascripts"))
    Dir["#{dirname}/*.*"].each do |filepath|
      context.stub_asset(filepath)
    end
  end
end

Rails.application.assets.unregister_processor("application/javascript", Sprockets::DirectiveProcessor)
Rails.application.assets.register_processor("application/javascript", DirectiveProcessor)
Rails.application.config.assets.precompile += %w(components.js)
