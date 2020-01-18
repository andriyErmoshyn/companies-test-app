guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^app/models/(.+)\.rb$}) { |m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/api/v1/(.+)_controller\.rb$}) { |m| "spec/requests/api/v1/#{m[1]}_spec.rb" }
end
