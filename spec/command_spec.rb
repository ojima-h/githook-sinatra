require 'githook/repo'
require 'githook/command'

describe Githook::Command do
  describe '#sync' do
    before :each do
      system <<EOF
mkdir -p ./spec/git/command
cd ./spec/git/command
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
rm -rf ./spec/git/command/*
EOF
    end

    it 'sync with remote git repository' do
      repo = Githook::Repo.new(name: 'name',
                               path: './spec/git/command/dst/',
                               remote: 'origin',
                               branch: 'master')
      command = Githook::Command.new(repo)

      command.sync.should be_true
      File.should be_exist './spec/git/command/dst/a'
    end
  end
end
