repo 'test-command' do
  path './spec/git/command/dst/'
  remote 'origin'
  branch 'master'
end
repo 'test-app' do
  path './spec/git/app/dst/'
  remote 'origin'
  branch 'master'
end
