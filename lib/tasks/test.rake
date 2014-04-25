Rake::TestTask.new('test:lib') do |t|
  t.libs = ["lib", "test"]
  t.test_files = FileList['test/lib/**/*_test.rb']
end

Rake::Task[:test].enhance { Rake::Task['test:lib'].invoke }
