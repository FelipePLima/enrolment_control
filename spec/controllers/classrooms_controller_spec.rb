require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  before { controller.stub(:authenticate_user!).and_return true }

  def valid_attributes
    { student_id: "1", course_id: "1", entry_at: "2016-04-01 10:20:00"}
  end

  describe 'GET #index' do
    let!(:classroom) { FactoryGirl.create(:classroom) }

    before do
      get 'index'
    end

    it { expect(response).to be_success }
    it { expect(assigns(:classrooms)).to eq([classroom]) }
  end

  describe 'GET #show' do
    let!(:classroom) { FactoryGirl.create(:classroom) }

    it "assigns the requested classroom as @classroom" do
      get :show, :id => classroom.id
      expect(assigns(:classroom)).to eq(classroom)
    end
  end

  describe 'GET #edit' do
    let!(:classroom) { FactoryGirl.create(:classroom) }

    before do
      get 'edit', :id => classroom.to_param
    end

    it { expect(response).to be_success }
    it { expect(assigns(:classroom)).to be_instance_of Classroom }
    it { render_template 'edit' }
  end

  describe 'GET #new' do
    before do
      get 'new'
    end

    it { expect(response).to be_success }
    it { expect(assigns(:classroom)).to be_instance_of Classroom }
    it { render_template 'new' }
  end

  describe 'POST #create' do
     context "with valid params" do
      before { post :create, classroom: valid_attributes }

      it { expect(assigns(:classroom)).to be_a(Classroom) }
      it { expect(assigns(:classroom)).to be_persisted }
      it { expect(response).to redirect_to(classrooms_path) }
    end

    context "with invalid params" do
      def do_action(param)
        post(:create, classroom: param)
      end

      before do
        do_action({student_id: "", course_id: "", entry_at: ""})
      end

      it { should render_template(:new) }
    end
  end

  describe 'POST #update' do
    let!(:classroom) { FactoryGirl.create(:classroom) }
    context "with valid params" do
      before do
        put 'update', :id => classroom.to_param, :classroom => { :student_id => 3 }
      end

      it { expect(assigns(:classroom)).to eq(classroom) }
      it { redirect_to(classrooms_path) }
      it { classroom.reload.student_id.should == 3 }
    end

    context "with invalid params" do
      before do
        put 'update', :id => classroom.to_param, :classroom => { :student_id => "" }
      end

      it { expect(assigns(:classroom)).to eq(classroom) }
      it { render_template 'edit' }
    end
  end

  describe 'DELETE #destroy' do
    let!(:classroom) { FactoryGirl.create(:classroom) }

    context "should find and redirect" do
      before do
        delete :destroy, id: classroom.to_param
      end

      it { expect(assigns(:classroom)).to eq(classroom) }
      it { redirect_to(classrooms_path) }
    end

    context "context" do
      it "should destroy a classroom" do
        expect {
          delete :destroy, id: classroom.to_param
        }.to change(Classroom, :count).by(-1)
      end
    end
  end
end
