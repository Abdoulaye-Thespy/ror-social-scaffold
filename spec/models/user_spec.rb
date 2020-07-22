require 'rails_helper'

RSpec.describe User, type: :model do

 subject {
    described_class.new(name: "Anything",
    	                password: "Anything",
                        email: "Anything@gmail.com",
                        created_at: DateTime.now,
                        updated_at: DateTime.now + 1.week,
                        id: 1)
  }
  it 'is valid with valid attributes'do
    expect(subject).to be_valid
  end
  it 'is not valid without a title'  do
  	subject.name = nil
    expect(subject).not_to be_valid
  end

 describe 'associations' do
it { should have_many(:posts) }
it { should have_many(:friendships) }
it { should have_many(:comments).dependent(:destroy) }
end
end
