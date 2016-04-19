require 'rails_helper'

describe Restaurant do
  it { should have_valid(:name).when('Sweetcheeks', 'Falafel King') }
  it { should_not have_valid(:name).when(nil, '') }
end
