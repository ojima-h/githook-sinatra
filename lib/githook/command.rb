require 'git'
require 'logger'

module Githook
  class Command
    def initialize(repo)
      @repo = repo
      @git = Git.open repo.path, log: Logger.new("log/git-#{repo.name}.log")
    end

    def sync
      @git.remote(@repo.remote).fetch
      @git.reset_hard @repo.refspec
    end
  end
end
