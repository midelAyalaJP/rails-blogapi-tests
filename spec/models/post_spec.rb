require 'rails_helper'

RSpec.describe Post, type: :model do
    
    #las validaciones tal cual que están en el model
    describe "Validations" do
        
        it "validate presence of required field" do
            should validate_presence_of(:title);
            should validate_presence_of(:content);
            #should validate_presence_of(:published);
            should allow_value(true, false).for(:published)
            should validate_presence_of(:user_id);
        end
    
    end
end
