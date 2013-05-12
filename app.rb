require 'sinatra'
require 'logger'
require 'git'

git = Git.open '/home/kawasemi/public_html', log: Logger.new('log/git.log')

post '/kawasemi' do
  git.remote(:origin).fetch
  git.reset_hard 'origin/master'
end
