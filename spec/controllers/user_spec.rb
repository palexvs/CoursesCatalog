require 'spec_helper'
# include Devise::TestHelpers

describe 'User Access', :type => :request do
  describe CoursesController do
    before do
      @user = create(:user)
      puts @user.inspect
      sign_in :user, @user
    end

    describe 'Index' do
      it do
        get :index
        assert_template 'courses/index'
      end
    end

    describe 'POST course' do
      it "should create draft course" do
        post :create, :course => attributes_for(:course_draft)
        response.should render_template :show
        flash[:alert].should == "You need to sign in or sign up before continuing."      
      end
    end

    # describe 'DELETE course' do
    #   before do
    #     @user = create(:user)
    #     @course = create(:course, created_by: @user.id)
    #   end

    #   it "should redirect to login_path with alert msg 'You need to sign in...' " do
    #     delete course_path(@course)
    #     response.should redirect_to(new_user_session_path)
    #     flash[:alert].should == "You need to sign in or sign up before continuing."      
    #   end
    # end

    # describe 'PUT course - try change name' do
    #   before do
    #     @user = create(:user)
    #     @course = create(:course, created_by: @user.id)
    #   end

    #   it "should redirect to login_path with alert msg 'You need to sign in...' " do
    #     put course_path(@course), :course => {:name => "New name"}
    #     response.should redirect_to(new_user_session_path)
    #     flash[:alert].should == "You need to sign in or sign up before continuing."      
    #   end
    # end      

    # describe 'GET pending course' do
    #   before do
    #     @user = create(:user)
    #     @course = create(:course_pending, created_by: @user.id)
    #   end

    #   it "should redirect to root_path with alert msg 'You are not authorized...' " do
    #     @course.created_by.should ==  @user.id
    #     @course.publish_status.should ==  "pending"

    #     get course_path(@course)
    #     response.should redirect_to(root_path)
    #     flash[:alert].should == "You are not authorized to access this page."
    #   end

    # end

    # describe 'GET draft course' do
    #   before do
    #     @user = create(:user)
    #     @course = create(:course_draft, created_by: @user.id)
    #   end

    #   it "should redirect to root_path with alert msg 'You are not authorized...' " do
    #     @course.created_by.should ==  @user.id
    #     @course.publish_status.should ==  "draft"

    #     get course_path(@course)
    #     response.should redirect_to(root_path)
    #     flash[:alert].should == "You are not authorized to access this page."
    #   end

    # end
  end
end