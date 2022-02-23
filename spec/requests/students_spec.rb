require 'rails_helper'

RSpec.describe "/students", type: :request do
 
  let(:valid_attributes) { attributes_for(:student) }

  let(:invalid_attributes) {{ nome: nil, telefone: nil, email: nil, matricula: nil }}

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Student" do
        expect {
          post students_url, params: { student: valid_attributes }, as: :json
        }.to change(Student, :count).by(1)
      end

      it "renders a JSON response with the new student" do
        post students_url, params: { student: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(JSON.parse(response.body)['student'].fetch('id')).to be_kind_of(Integer)
      end

      it "renders a JSON response with the uffmail options" do
        post students_url, params: { student: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(JSON.parse(response.body).fetch('uffmail_options')).to be_kind_of(Array)
      end

    end

    context "with invalid parameters" do
      it "does not create a new Student" do
        expect {
          post students_url, params: { student: invalid_attributes }, as: :json
        }.to change(Student, :count).by(0)
      end

      it "renders a JSON response with errors for the new student" do
        post students_url,
             params: { student: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { attributes_for(:student) }

      it "updates the requested student" do
        student = Student.create! valid_attributes
        patch student_url(student), params: { student: new_attributes }, as: :json
        student.reload
        expect(student.nome).to eq(new_attributes[:nome])
      end

      it "renders a JSON response with the student" do
        student = Student.create! valid_attributes
        patch student_url(student),
          params: { student: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the student" do
        student = Student.create! valid_attributes
        patch student_url(student),
          params: { student: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe 'POST /create_with_csv' do
    context 'with '
  end

end