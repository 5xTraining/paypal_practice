namespace :products do
  desc "Generate dummy product"
  task :prepare => :environment do
    20.times do |i|
      product = FactoryBot.create(:product)
      puts "create product: #{i + 1} - #{product.title}"
    end
    puts "done!"
  end
end
