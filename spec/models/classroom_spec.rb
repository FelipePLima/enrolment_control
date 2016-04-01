require 'rails_helper'

RSpec.describe Classroom, type: :model do
  it { should validate_presence_of(:student_id) }
  it { should validate_presence_of(:course_id) }
  it { should validate_presence_of(:entry_at) }

  it { should belong_to(:student) }
  it { should belong_to(:course) }

  describe "validates student_in_course" do
    let!(:classroom) { FactoryGirl.create(:classroom, student_id: 5, course_id: 5) }
    let(:classroom_two) {FactoryGirl.build(:classroom, student_id: 5, course_id: 5)}

    it{ expect(classroom_two).to_not be_valid}
  end
end
