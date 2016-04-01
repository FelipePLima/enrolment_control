require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  before { controller.stub(:authenticate_user!).and_return true }

  def valid_attributes
    { name: "Felipe Lima", register_number: "874874", status: "1"}
  end

  describe 'GET #index' do
    let!(:student) { FactoryGirl.create(:student) }

    before do
      get 'index'
    end

    it { expect(response).to be_success }
    it { expect(assigns(:students)).to eq([student]) }
  end

  describe 'GET #show' do
    let!(:student) { FactoryGirl.create(:student) }

    it "assigns the requested student as @student" do
      get :show, :id => student.id
      expect(assigns(:student)).to eq(student)
    end
  end

  describe 'GET #edit' do
    let!(:student) { FactoryGirl.create(:student) }

    before do
      get 'edit', :id => student.to_param
    end

    it { expect(response).to be_success }
    it { expect(assigns(:student)).to be_instance_of Student }
    it { render_template 'edit' }
  end

  describe 'GET #new' do
    before do
      get 'new'
    end

    it { expect(response).to be_success }
    it { expect(assigns(:student)).to be_instance_of Student }
    it { render_template 'new' }
  end

  describe 'POST #create' do
     context "with valid params" do
      before { post :create, student: valid_attributes }

      it { expect(assigns(:student)).to be_a(Student) }
      it { expect(assigns(:student)).to be_persisted }
      it { expect(response).to redirect_to(students_path) }
    end

    context "with invalid params" do
      def do_action(param)
        post(:create, student: param)
      end

      before do
        do_action({name: "", register_number: "", status: ""})
      end

      it { should render_template(:new) }
    end
  end

  describe 'POST #update' do
    let!(:student) { FactoryGirl.create(:student) }
    context "with valid params" do
      before do
        put 'update', :id => student.to_param, :student => { :name => "Felipe Passini" }
      end

      it { expect(assigns(:student)).to eq(student) }
      it { redirect_to(students_path) }
      it { student.reload.name.should == "Felipe Passini" }
    end

    context "with invalid params" do
      before do
        put 'update', :id => student.to_param, :student => { :name => "" }
      end

      it { expect(assigns(:student)).to eq(student) }
      it { render_template 'edit' }
    end
  end

  describe 'DELETE #destroy' do
    let!(:student) { FactoryGirl.create(:student) }

    context "should find and redirect" do
      before do
        delete :destroy, id: student.to_param
      end

      it { expect(assigns(:student)).to eq(student) }
      it { redirect_to(students_path) }
    end

    context "context" do
      it "should destroy a Student" do
        expect {
          delete :destroy, id: student.to_param
        }.to change(Student, :count).by(-1)
      end
    end
  end
end
