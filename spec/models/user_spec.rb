require 'rails_helper'

RSpec.describe User, type: :model do

    #las validaciones tal cual que están en el model
    describe "Validations" do
        
        it "validate presence of required field" do
            should validate_presence_of(:email);
            should validate_presence_of(:name);
            should validate_presence_of(:auth_token);
            
        end
        
        #valida que exista una relacion en el modelo
        it "Validate relations" do
            should have_many(:post)
        end
    end
end
