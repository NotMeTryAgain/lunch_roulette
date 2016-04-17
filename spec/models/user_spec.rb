require 'rails_helper'

describe User do
  it { should have_valid(:username).when('Miles', 'naTalie8') }
  it { should_not have_valid(:username).when(nil, '') }

  it { should have_valid(:email).when('honeyBear@gmail.com', 'another@hotmail.com')}
  it { should_not have_valid(:email).when(nil, '', 'honeyPie', 'honey.com', 'dilbert@com')}

  it 'has a matching password confirmation for the password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'anotherpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end
