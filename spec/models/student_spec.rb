require 'rails_helper'

RSpec.describe Student, type: :model do

  context 'when creating new student' do 
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

    it 'is invalid with matricula less than 6 digits' do 
      student = build(:student, matricula: '111')
      expect(student.valid?).to eq(false)
      expect(student.errors[:matricula]).to include('is the wrong length (should be 6 characters)')
    end

    it 'is valid with matricula 6 digits long' do 
      student = build(:student)
      expect(student).to be_valid
      expect(student.matricula.length).to be(6)
      expect(student.matricula).to match(/\A\d{6}\Z/)
    end

    it 'is invalid with matricula containing non digits' do 
      student = build(:student, matricula: '11a-+@')
      expect(student.valid?).to eq(false)
      expect(student.errors[:matricula]).to include('only allows decimal numbers')
    end
    
    it 'is invalid with telefone less than 9 digits' do 
      student = build(:student, telefone: '111')
      expect(student.valid?).to eq(false)
      expect(student.errors[:telefone]).to include('is the wrong length (should be 9 characters)')
    end

    it 'is valid with 9 digits long telefone' do 
      student = build(:student)
      expect(student).to be_valid
      expect(student.telefone.length).to be(9)
      expect(student.telefone).to match(/\A\d{9}\Z/)
    end

    it 'is invalid with telefone containing non digits' do 
      student = build(:student, telefone: '11a-+@000')
      expect(student.valid?).to eq(false)
      expect(student.errors[:telefone]).to include('only allows decimal numbers')
    end

    it 'is valid with email like email@gmail.com' do 
      student = build(:student)
      expect(student).to be_valid
      expect(student.email).to match(/\A[\w\-.]+?@(gmail|hotmail|yahoo|outlook)\.\w+?\Z/)
    end

    it 'is invalid with email not like email@gmail.com' do 
      student = build(:student, email: 'exemplo#errado')
      expect(student.valid?).to be(false)
      expect(student.errors[:email]).to include('Must be like example@email.com')
    end
  end

  context 'when student already has uffmail' do
    it 'should return true for .has_uffmail?' do
      student = build(:student, :with_uffmail)
      expect(student.has_uffmail?).to be(true)
    end

    it 'should not give uffmail options' do
      student = build(:student, :with_uffmail)
      expect(student.uffmail_options).to be_nil
      expect(student.errors[:uffmail_options]).to include('student already has a uffmail')
    end
  end

  context 'when student is inactive' do
    it 'should not give uffmail options' do
      student = build(:student, :inactive)
      expect(student.uffmail_options).to be_nil
      expect(student.errors[:uffmail_options]).to include('student must be active active')
    end

    it 'should return false for .active?' do
      student = build(:student, :inactive)
      expect(student.active?).to be(false)
    end
  end

  context 'when student is active and has not a uffmail' do
    it 'should return true for .active?' do
      student = build(:student)
      expect(student.active?).to be(true)
    end

    it 'should return false for .has_uffmail?' do 
      student = build(:student)
      expect(student.has_uffmail?).to be(false)
    end

    it 'should return a non empty array for .uffmail_options' do
      student = build(:student)
      expect(student.uffmail_options).not_to be_empty
    end

    it 'should return uffmail_options like name@id.uff.br' do
      student = build(:student)
      expect(
        student.uffmail_options.map{|o| o.match(/\A[\w\-.]+?@id\.uff\.br\Z/)}
      ).not_to include(nil)
    end
  end

end