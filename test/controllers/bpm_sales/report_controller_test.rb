require 'test_helper'

module BpmSales
  class ReportControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end

  end
end
