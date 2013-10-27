require "bundler/gem_tasks"

namespace :test do
  desc "Run all tests"
  task :all do
    Dir.glob('./test/**/test_oak*.rb').each { |file| require file }
  end
end
