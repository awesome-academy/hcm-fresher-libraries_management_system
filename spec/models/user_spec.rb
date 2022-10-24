require "rails_helper"

RSpec.describe User, type: :model do
  subject { FactoryBot.build(:user) }

  describe "associations" do
    it { should have_many(:requests).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_one_attached(:avatar) }
  end

  describe "validations" do
    context "when field name" do
      subject { FactoryBot.build(:user) }
      it { should validate_presence_of(:name) }
      it { should validate_length_of(:name).is_at_most(50) }
    end

    context "when field email" do
      subject { FactoryBot.build(:user) }
      it { should validate_presence_of(:email) }
      it { should validate_length_of(:email).is_at_least(10).is_at_most(255) }
      it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
      it { should allow_value("hello@gmail.com","world_hi@yahoo.vn").for(:email) }
      it { should_not allow_value("hello2gmail.com","world_hi@yahoovn").for(:email) }
    end

    context "when field password" do
      subject { FactoryBot.build(:user) }
      it { should validate_presence_of(:password).allow_nil }
      it { should validate_length_of(:password).is_at_least(6) }
    end
  end

  it { should define_enum_for(:role).with_values(admin: 0, client: 1) }

  context "callbacks" do
    let(:user) { FactoryBot.build(:user) }
    it { expect(user).to callback(:downcase_email).before(:save) }
  end
end
