namespace :db do
  desc "Populate database"
  task populate: :environment do
    full_reset

    dummy :users, 15 do
      user = User.new
      user.first_name = FFaker::Name.first_name
      user.last_name = FFaker::Name.last_name
      user.save!
    end
  end

  def full_reset
    Rake::Task['db:reset'].invoke
    FileUtils.rm_rf(Dir["#{Rails.root}/public/files"])
  end

  def dummy title, number=1
    puts "Creating dummy #{title}..."
    number.times { yield }
    puts "...done"
  end
end
