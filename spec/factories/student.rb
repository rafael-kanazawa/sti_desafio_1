FactoryBot.define do
  factory :student do
    Faker:Config.locale = 'br'
    name Faker::Name.name_with_middle
    email Faker::Internet.free_email(name: name)
    telefone Faker::PhoneNumber.cell_phone
    matricula Faker::Number.number(digits: 6)
    status :ativo

    trait :active do 
      status :ativo
    end

    trait :inactive do 
      status :inativo
    end

    trait :with_uffmail do
      uffmail 'uffmail@id.uff.br'
    end
  end
end