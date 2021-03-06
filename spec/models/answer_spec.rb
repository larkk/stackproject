require 'rails_helper'

RSpec.describe Answer, type: :model do

 it { should validate_presence_of :text }
 it { should validate_length_of(:text).is_at_least(10).is_at_most(1000)}
 it { should belong_to :question }
 it { should belong_to(:user) }
end
