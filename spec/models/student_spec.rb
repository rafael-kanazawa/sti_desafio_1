require 'rails_helper'

RSpec.describe Student, type: :model do
  it 'is valid with corret information' do
    student = create(:student, :active)
    expect(student).to be_valid
  end
  it "is invalid without nome" do
    student = build(:student, nome: nil)
    expect(student.valid?).to eq(false)
    expect(student.errors[:nome]).to include("can't be blank")
  end
  it "is invalid without matricula" do
    student = build(:student, matricula: nil)
    expect(student.valid?).to eq(false)
    expect(student.errors[:matricula]).to include("can't be blank")
  end
  it "is invalid without telefone" do
    student = build(:student, telefone: nil)
    expect(student.valid?).to eq(false)
    expect(student.errors[:telefone]).to include("can't be blank")
  end
  it "is invalid without email" do
    student = build(:student, email: nil)
    expect(student.valid?).to eq(false)
    expect(student.errors[:email]).to include("can't be blank")
  end
  it "is invalid without status" do
    student = build(:student)
    expect(student.valid?).to eq(false)
    expect(student.errors[:status]).to include("can't be blank")
  end
  xit 'is invalid if matricula is less than 6 digits' do 
  end
  xit 'is valid if matricula is 6 digits long' do 
  end
  xit 'is invalid if telefone is less than 9 digits' do 
  end
  xit 'is valid if telefone is 9 digits long' do 
  end
  xit 'is valid if email is like email@gmail.com' do 
  end
  xit 'is invalid if email is not like email@gmail.com' do 
  end
end