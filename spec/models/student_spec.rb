require 'rails_helper'

RSpec.describe Student, type: :model do
  it 'is valid with corret information' do
    student = create(:student)
    expect(student).to be_valid
  end
  it "is invalid without nome" do
  end
  it "is invalid without matricula" do
  end
  it "is invalid without telefone" do
  end
  it "is invalid without email" do
  end
  it "is invalid without status" do
  end
  it 'is invalid if matricula is less than 6 digits' do 
  end
  it 'is valid if matricula is 6 digits long' do 
  end
  it 'is invalid if telefone is less than 9 digits' do 
  end
  it 'is valid if telefone is 9 digits long' do 
  end
  it 'is valid if email is like email@gmail.com' do 
  end
  it 'is invalid if email is not like email@gmail.com' do 
  end
end