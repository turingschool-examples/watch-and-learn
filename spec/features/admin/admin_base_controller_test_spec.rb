require 'rails_helper'

describe Admin::Api::V1::BaseController, type: :controller do
  controller do
    def index

    end

  end
  
  it "raises error becuase user is not admin" do
    expect {get :index}.to raise_error(ActionController::RoutingError)
  end
end
