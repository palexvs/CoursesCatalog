require 'spec_helper'

describe 'Guest Access', :type => :request do
  describe CoursesController do
    describe 'Index' do
      it do
        get :index
        assert_template 'courses/index'
      end
    end

    describe 'POST course' do
      it "should not create course and redirect to login_path with alert msg" do
        expect {
          post :create, attributes_for(:course, created_by: 1)
        }.to_not change(Course,:count)
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == "You need to sign in or sign up before continuing."      
      end
    end

    describe 'DELETE course' do
      before do
        @user = create(:user)
        @course = create(:course, created_by: @user.id)
      end

      it "should not delete course and redirect to login_path with alert msg" do
        expect {
          delete :destroy, id: @course.id
        }.to_not change(Course,:count)
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == "You need to sign in or sign up before continuing."      
      end
    end

    describe 'PUT course - try change name' do
      before do
        @user = create(:user)
        @course = create(:course, created_by: @user.id)
      end

      it "should not update course and redirect to login_path with alert msg" do
        expect{
          put :update, id: @course, course: {:name => "New name"}
         }.to_not change(Course,:count)
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == "You need to sign in or sign up before continuing."      
      end
    end      

    describe 'GET pending course' do
      before do
        @user = create(:user)
        @course = create(:course_pending, created_by: @user.id)
      end

      it "should not show pending course and redirect to root_path with alert msg" do
        @course.created_by.should ==  @user.id
        @course.publish_status.should ==  "pending"

        get :show, id: @course.id
        response.should redirect_to(root_path)
        flash[:alert].should == "You are not authorized to access this page."
      end

    end

    describe 'GET draft course' do
      before do
        @user = create(:user)
        @course = create(:course_draft, created_by: @user.id)
      end

      it "should not show draft course and redirect to root_path with alert msg" do
        @course.created_by.should ==  @user.id
        @course.publish_status.should ==  "draft"

        get :show, id: @course.id
        response.should redirect_to(root_path)
        flash[:alert].should == "You are not authorized to access this page."
      end
    end

    describe 'GET public course' do
      before do
        @user = create(:user)
        @course = create(:course, created_by: @user.id)
      end

      it "should return course" do
        @course.created_by.should ==  @user.id
        @course.publish_status.should ==  "publish"

        get :show, id: @course.id
        response.should render_template :show
      end
    end

  end
end