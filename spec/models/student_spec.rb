require 'rails_helper'

RSpec.describe Student, type: :model do
  it 'is valid with corret information' do
    student = build(:student)
    expect(student).to be_valid
  end
  
  it 'is invalid without nome' do
    student = build(:student, nome: nil)
    expect(student.valid?).to eq(false)
    expect(student.errors[:nome]).to include("can't be blank")
  end

  it 'is invalid without matricula' do
    student = build(:student, matricula: nil)
    expect(student.valid?).to eq(false)
    expect(student.errors[:matricula]).to include("can't be blank")
  end

  it 'is invalid without telefone' do
    student = build(:student, telefone: nil)
    expect(student.valid?).to eq(false)
    expect(student.errors[:telefone]).to include("can't be blank")
  end

  it 'is invalid without email' do
    student = build(:student, email: nil)
    expect(student.valid?).to eq(false)
    expect(student.errors[:email]).to include("can't be blank")
  end

  it 'is invalid without status' do
    student = build(:student, status: nil)
    expect(student.valid?).to eq(false)
    expect(student.errors[:status]).to include("can't be blank")
  end

  it 'is invalid if matricula is less than 6 digits' do 
    student = build(:student, matricula: '111')
    expect(student.valid?).to eq(false)
    expect(student.errors[:matricula]).to include('is the wrong length (should be 6 characters)')
  end

  it 'is valid if matricula is 6 digits long' do 
    student = build(:student)
    expect(student).to be_valid
    expect(student.matricula.length).to be(6)
    expect(student.matricula).to match(/\A\d{6}\Z/)
  end

  it 'is invalid if matricula contains non digits' do 
    student = build(:student, matricula: '11a-+@')
    expect(student.valid?).to eq(false)
    expect(student.errors[:matricula]).to include('only allows decimal numbers')
  end
  
  it 'is invalid if telefone is less than 9 digits' do 
    student = build(:student, telefone: '111')
    expect(student.valid?).to eq(false)
    expect(student.errors[:telefone]).to include('is the wrong length (should be 9 characters)')
  end

  it 'is valid if telefone is 9 digits long' do 
    student = build(:student)
    expect(student).to be_valid
    expect(student.telefone.length).to be(9)
    expect(student.telefone).to match(/\A\d{9}\Z/)
  end

  it 'is invalid if telefone contains non digits' do 
    student = build(:student, telefone: '11a-+@000')
    expect(student.valid?).to eq(false)
    expect(student.errors[:telefone]).to include('only allows decimal numbers')
  end

  it 'is valid if email is like email@gmail.com' do 
    student = build(:student)
    expect(student).to be_valid
    expect(student.email).to match(/\A[\w\-.]+?@(gmail|hotmail|yahoo|outlook)\.\w+?\Z/)
  end

  it 'is invalid if email is not like email@gmail.com' do 
    student = build(:student, email: 'exemplo#errado')
    expect(student.valid?).to be(false)
    expect(student.errors[:email]).to include('Must be like example@email.com')
  end
end