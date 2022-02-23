FactoryBot.define do
  factory :student do
    nome {Faker::Name.name_with_middle}
    email {Faker::Internet.free_email}
    telefone {"9" + Faker::Number.number(digits: 8).to_s}
    matricula {Faker::Number.number(digits: 6)}
    status {"Ativo"}

    trait :inactive do 
      status {:Inativo}
    end

    trait :with_uffmail do
      uffmail {'uffmail@id.uff.br'}
    end
  end
end