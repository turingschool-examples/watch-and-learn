namespace :conversion do
desc:"Update Nil Positions"
task :videos => :environment do
  Video.where(position: nil).update(position: 0)
end
end
