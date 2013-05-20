require 'sinatra'

require 'githook/config'
require 'githook/command'
require 'githook/repo'

require 'yaml'

configure :development, :test do
  set :repos, './spec/repos-example.rb'
end
configure :production do
  set :repos, './repos.rb'
end

if File.exists?('./repos.rb')
  Githook::Config.module_eval(File.read(settings.repos))
end

get '/' do
  Githook::Config.repos.map do |repo|
    repo.name
  end
end

Githook::Config.repos.each do |repo|
  post "/#{repo.name}" do
    Githook::Command.new(repo).sync
  end
end
