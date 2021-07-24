require 'faker'

%w[Novice Intermediate Pro].each do |role|
  ExperienceLevel.create! do |e|
    e.experience_level = role
  end
end

Waiver.create! do |w|
  w.active = true
  w.version = '1.0'
  w.changelog = 'Initial Waiver!'
  w.content = "### Acknowledgements

  - You acknowledge and accept that climbing/bouldering is a dangerous recreational activity with obvious risks. You are participating at your own risk.
  - One Up Bouldering provides a safe environment to all participants and utilises state of the art equipment to ensure the safety of all its members. However, as bouldering is inherently a dangerous recreational activity, it is a requirement that all participants sign the waiver below.
  - Participants under the age of 18 must have their parent or legal guardian fill out and sign the waiver below.
  - Bouldering may involve incidental and significant risks which may cause physical or psychological injuries and in extreme circumstances, death.
  - This waiver excludes any liability for the personal injury which might be incurred by One Up Bouldering, its employees, agents and representatives arising out of your voluntary participation in the activities offered at One Up Bouldering.
  - By completing this form, you will accept the terms and conditions and will be agreeing to exclude and limit One Up Bouldering’s liability.
  - You are not obligated to sign or waive the liability under this form, however, should you not agree to this waiver, One Up Bouldering may refuse to provide you with its services and access to the premises.

  ### Waiver

  - I have been advised of the risks and dangers of bouldering and wish to participate at my own risk of injury.
  - I understand that bouldering and the use of the equipment at One Up Bouldering could result in physical and psychological injuries and in extreme circumstances, death.
  - I do not suffer from any medical condition or any other condition that may affect my ability to participate in bouldering safely. I assume the risk of injury to my health and safety.
  - I agree not to participate in activities whilst under the influence of drugs of alcohol.
  - I understand and accept the responsibility to review and comply with the rules and regulations, including any changes to these, at One Up Bouldering.
  - I am aware that this waiver is ongoing and will continue to apply to all future occasions I participate with One Up Bouldering.
  - I am at least 18 years of age and have legal capacity to sign this form or I am a parent or legal guardian responsible for the participant who is under the age of 18 years old.
  - I hereby indemnify and release One Up Bouldering, its directors, its employees, agents and representatives involved in my participation of the recreational activities offered from any legal costs, demand, action or claim for compensation whether for personal injury or damage to property arising from my participation of the activities."
  w.declaration = 'I have read and understood this form and the terms contained herein and have been provided with clarification on any concerns that I may have in relation to this.'
end

##################################

if Rails.env.development?
  20.times do
    user = User.create({ email: Faker::Internet.unique.email,
                         password: 'password',
                         password_confirmation: 'password' })
    profile = UserProfile.new({ date_of_birth: Faker::Date.between(from: 50.years.ago, to: Date.today),
                                first_name: Faker::Name.unique.name.split.first,
                                last_name: Faker::Name.unique.name.split.last,
                                phone_number: Faker::Number.leading_zero_number(digits: 12),
                                experience_level_id: rand(1..3) })
    address = UserAddress.new({ city: Faker::Address.city,
                                country: 'Australia',
                                postcode: Faker::Number.between(from: 2000, to: 2500),
                                state: 'NSW',
                                street_address: Faker::Address.street_address })
    profile.user = user
    address.user = user
    profile.save!
    address.save!
  end

  User.create!({ email: 'admin@test.com',
                 password: 'password',
                 password_confirmation: 'password',
                 role: 'admin' })
  User.create!({ email: 'user@test.com',
                 password: 'password',
                 password_confirmation: 'password' })
end
