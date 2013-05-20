require 'rack/test'
require './app'
require 'git'

describe 'app' do
  include Rack::Test::Methods

  before :each do
    system <<EOF
mkdir -p ./spec/git/app
cd ./spec/git/app
git init src
git clone src dst
cd src
echo test > a
git add a
git commit -m 'test'
EOF
  end
  after :each do
    system <<EOF
rm -rf ./spec/git/app/*
EOF
  end

  def app
    Sinatra::Application
  end

  describe 'post /:repo_name' do
    it 'sync with remote repository' do
      post '/test-app'

      File.should be_exist './spec/git/app/dst/a'
    end
  end
end
