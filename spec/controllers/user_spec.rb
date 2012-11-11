require 'spec_helper'
# include Devise::TestHelpers

describe 'User Access', :type => :request do
  describe CoursesController do
    before do
      @user = create(:user)
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
        expect {
          post :create, :course => attributes_for(:course_draft)
        }.to change(Course, :count).from(0).to(1)
        response.should redirect_to( course_path(Course.last) )
      end

      it "should create pending course" do
        expect {
          post :create, :course => attributes_for(:course_pending)
        }.to change(Course, :count).from(0).to(1)
        response.should redirect_to( course_path(Course.last) )
      end

      it "should not create publish course" do
        expect {
          post :create, :course => attributes_for(:course)
        }.not_to change(Course, :count)
        response.should redirect_to(root_path)
        flash[:alert].should == "You are not authorized to access this page."
      end
    end

    describe 'PUT course' do
      describe 'draft -> pending' do
        before do
          @course = create(:course_draft, created_by: @user.id)
        end

        it 'should can change status from "draft" to "pending"' do
          put :update,  id: @course, course: { publish_status: "pending" }
          response.should redirect_to(course_path(@course))
          @course.reload.publish_status.should == "pending"
        end
      end

      describe 'pending !-> draft' do
        before do
          @course = create(:course_pending, created_by: @user.id)
        end

        it 'should not change status from "pending" to "draft"' do
          put :update,  id: @course, course: { publish_status: "draft" }
          response.should redirect_to(root_path)
          flash[:alert].should == "You are not authorized to access this page."
          @course.reload.publish_status.should_not == "draft"
          @course.reload.publish_status.should == "pending"
        end
      end

      describe 'draft !-> publish' do
        before do
          @course = create(:course_draft, created_by: @user.id)
        end

        it 'should not change status from "draft" to "publish"' do
          put :update,  id: @course, course: { publish_status: "publish" }
          response.should redirect_to(root_path)
          flash[:alert].should == "You are not authorized to access this page."
          @course.reload.publish_status.should_not == "publish"
          @course.reload.publish_status.should == "draft"
        end
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