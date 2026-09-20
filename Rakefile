require "rake/testtask"
require "bundler/gem_tasks"

desc "Default: run unit tests."
task :default => :test

Rake::TestTask.new do |t|
  t.libs << "lib" << "test"
  t.pattern = "test/**/*_test.rb"
end

namespace :data do
  desc "Refresh the ISO 639 snapshot from the Library of Congress"
  task :update do
    require "net/http"

    url = URI("https://www.loc.gov/standards/iso639-2/ISO-639-2_utf-8.txt")
    response = Net::HTTP.get_response(url)
    abort "Download failed: HTTP #{response.code}" unless response.is_a?(Net::HTTPOK)

    data = response.body.force_encoding("UTF-8")
    data = data.sub(/\A\uFEFF/, "").gsub(/\r\n?/, "\n").chomp + "\n"
    path = File.expand_path("lib/iso639/ISO-639-2_utf-8.txt", __dir__)
    File.binwrite(path, data)
    puts "Updated #{path}"
  end
end
