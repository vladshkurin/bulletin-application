require 'rails_helper'

describe Message do
  it { should belong_to(:user) }
  it { should have_many(:comments) }
end
