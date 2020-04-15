namespace :db do
  desc "Populate database"
  task populate: :environment do
    full_reset

    dummy :users, 5 do
      user = User.new
      user.first_name = FFaker::Name.first_name
      user.last_name = FFaker::Name.last_name
      user.save!
    end


    dummy :post, 5 do
      post = Post.new
      post.title = FFaker::Lorem.phrase
      post.content = FFaker::Lorem.paragraph
      post.user_id = rand(1..5)
      post.save!
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
