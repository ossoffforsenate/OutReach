def random_user_id
  characters = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9)
  str = ""
  8.times { str += characters.sample }
  str
end

vote_statuses = [
  'Needs to Vote',
  'Ballot Mailed',
  'Early Voted',
  'Ballot Received',
  'Not Marked',
]
vote_plans = [
  'By Mail',
  'Already Voted',
  'Early In-Person',
  'On Election Day',
  nil,
  nil,
  nil,
  nil,
  nil,
  nil,
  nil,
]

support_scores = [
  'Strong Jon',
  'Strong Perdue',
  'Lean Jon',
  'Lean Perdue',
  'Undecided',
  'Not Voting',
  nil,
  nil,
  nil,
  nil,
  nil,
  nil,
  nil,
]

begin
  User.create!(
    id: random_user_id,
    first_name: "Testing",
    last_name: "User",
    email_address: Faker::Internet.email,
    phone_number: "1234567890",
    rmm_email: Faker::Internet.email,
    role: rand(0..4)
  )
rescue
  puts "ignoring"
end

50.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create!(
    id: random_user_id,
    first_name: first_name,
    last_name: last_name,
    email_address: Faker::Internet.email,
    phone_number: PhoneNumberUtils.normalize(Faker::PhoneNumber.phone_number)[0..9],
    rmm_email: Faker::Internet.email,
    role: rand(0..4)
  )
end

User.all.each do |user|
  loop do
    begin
      Voter.create!(
        reach_id: user.id,
        sos_id: rand(10000..100000),

        last_name: user.last_name,
        first_name: user.first_name,
        middle_name: Faker::Name.middle_name,
        age: rand(18..100),
        gender: Faker::Gender.type,

        primary_phone_number: user.phone_number,
        voting_street_address: Faker::Address.street_address,
        voting_city: Faker::Address.city,
        voting_zip: Faker::Address.zip_code,
        voting_state: "PA",

        support_score: support_scores.sample,
      )
      break
    rescue ActiveRecord::RecordNotUnique
      puts "re-creating due to unique constrant violation..."
    end
  end
end

1000.times do
  loop do
    begin
      Voter.create!(
        reach_id: random_user_id,
        sos_id: rand(10000..100000),

        last_name: Faker::Name.last_name,
        first_name: Faker::Name.first_name,
        middle_name: Faker::Name.middle_name,
        age: rand(18..100),
        gender: Faker::Gender.type,

        primary_phone_number: PhoneNumberUtils.normalize(Faker::PhoneNumber.phone_number)[0..9],
        voting_street_address: Faker::Address.street_address,
        voting_city: Faker::Address.city,
        voting_zip: Faker::Address.zip_code,
        voting_state: "PA",

        support_score: support_scores.sample,
      )
      break
    rescue ActiveRecord::RecordNotUnique
      puts "re-creating due to unique constrant violation..."
    end
  end
end

User.all.each do |user|
  voter = Voter.find_by(primary_phone_number: user.phone_number)
  begin
    Relationship.create!(
      user_id: user.id,
      voter_reach_id: voter.reach_id,
      relationship: "Me",
    )
  rescue
    puts "re-creating due to unique constrant violation..."
  end
  num = user.phone_number == "1234567890" ? 10 : rand(0..9)
  num.times do
    begin
      Relationship.create!(
        user_id: user.id,
        voter_reach_id: Voter.all.sample.reach_id,
        relationship: "Friend",
      )
    rescue ActiveRecord::RecordNotUnique
      puts "re-creating due to unique constrant violation..."
    end
  end
end
