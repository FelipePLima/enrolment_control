require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  before { controller.stub(:authenticate_user!).and_return true }

  def valid_attributes
    { name: "Mátematica", description: "Curso de Mátematica", status: "1"}
  end

  describe 'GET #index' do
    let!(:course) { FactoryGirl.create(:course) }

    before do
      get 'index'
    end

    it { expect(response).to be_success }
    it { expect(assigns(:courses)).to eq([course]) }
  end

  describe 'GET #show' do
    let!(:course) { FactoryGirl.create(:course) }

    it "assigns the requested course as @course" do
      get :show, :id => course.id
      expect(assigns(:course)).to eq(course)
    end
  end

  describe 'GET #edit' do
    let!(:course) { FactoryGirl.create(:course) }

    before do
      get 'edit', :id => course.to_param
    end

    it { expect(response).to be_success }
    it { expect(assigns(:course)).to be_instance_of Course }
    it { render_template 'edit' }
  end

  describe 'GET #new' do
    before do
      get 'new'
    end

    it { expect(response).to be_success }
    it { expect(assigns(:course)).to be_instance_of Course }
    it { render_template 'new' }
  end

  describe 'POST #create' do
     context "with valid params" do
      before { post :create, course: valid_attributes }

      it { expect(assigns(:course)).to be_a(Course) }
      it { expect(assigns(:course)).to be_persisted }
      it { expect(response).to redirect_to(courses_path) }
    end

    context "with invalid params" do
      def do_action(param)
        post(:create, course: param)
      end

      before do
        do_action({name: "", register_number: "", status: ""})
      end

      it { should render_template(:new) }
    end
  end

  describe 'POST #update' do
    let!(:course) { FactoryGirl.create(:course) }
    context "with valid params" do
      before do
        put 'update', :id => course.to_param, :course => { :name => "Inglês" }
      end

      it { expect(assigns(:course)).to eq(course) }
      it { redirect_to(courses_path) }
      it { course.reload.name.should == "Inglês" }
    end

    context "with invalid params" do
      before do
        put 'update', :id => course.to_param, :course => { :name => "" }
      end

      it { expect(assigns(:course)).to eq(course) }
      it { render_template 'edit' }
    end
  end

  describe 'DELETE #destroy' do
    let!(:course) { FactoryGirl.create(:course) }

    context "should find and redirect" do
      before do
        delete :destroy, id: course.to_param
      end

      it { expect(assigns(:course)).to eq(course) }
      it { redirect_to(courses_path) }
    end

    context "context" do
      it "should destroy a course" do
        expect {
          delete :destroy, id: course.to_param
        }.to change(Course, :count).by(-1)
      end
    end
  end
end
