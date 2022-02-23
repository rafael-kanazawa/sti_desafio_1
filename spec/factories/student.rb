FactoryBot.define do
  factory :student do
    nome {Faker::Name.name_with_middle}
    email {Faker::Internet.free_email}
    telefone {Faker::PhoneNumber.cell_phone}
    matricula {Faker::Number.number(digits: 6)}

    trait :active do 
      status {:Ativo}
    end

    trait :inactive do 
      status {:Inativo}
    end

    trait :with_uffmail do
      uffmail {'uffmail@id.uff.br'}
    end
  end
end