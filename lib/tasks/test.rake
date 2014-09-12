Rake::TestTask.new('test:lib') do |t|
  t.libs = ["lib", "test"]
  t.test_files = FileList['test/lib/**/*_test.rb']
end

namespace :test do
  desc "Run javascript tests"
  task :js do
    system("npm test")
  end
end

Rake::Task[:test].enhance { Rake::Task["test:js"].invoke }
Rake::Task[:test].enhance { Rake::Task['test:lib'].invoke }
