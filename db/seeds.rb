User.create(name: 'tanaka', email: 'rari4423@gmail.com', password: 'tanaka', password_confirmation: 'tanaka', created_at: "2019-07-11 02:33:34", updated_at: "2019-07-11 02:33:34",admin:"ture")
Label.create!(name:"家事")
Label.create!(name:"仕事")


10.times do |n|
  User.create!(
    name: "user#{n+1}",
    email: "user#{n+1}@example.com",
    password: "password" )
  end

10.times do |n|
  Task.create!(
    user_id: 1,
    name: "task#{n+1}",
    content: "task#{n+1}")
  end

  10.times do |n|
    Label.create!(
      name: "label#{n+1}")
    end
  