namespace :heroku do
  desc "compile assets and deploy to heroku"
  task :deploy do
    Rake::Task['assets:clean'].invoke
    Rake::Task['assets:precompile'].invoke
    message = "[Deploy] to heroku on: #{Time.now}"
    sh "git add #{Rails.root}"
    sh %Q[git commit -v -m "#{message}"]
    sh "git push -f heroku master"
    sh "git reset HEAD~1 --hard"
  end
end
