require 'githook/repo'
require 'githook/config'

describe Githook::Config do
  require 'githook/config'
  before :all do
    Githook::Config.instance_eval do
      repo 'repo' do
        path 'path'
        remote 'origin'
        branch 'master'
      end
    end
  end

  it 'should set parameter to GithubHook' do
    Githook::Config.should respond_to :repos

    c = Githook::Config.repos.first
    c.should respond_to :name
    c.should respond_to :path
    c.should respond_to :remote
    c.should respond_to :branch
    c.should respond_to :refspec

    c.refspec.should eq 'origin/master'
  end
end
