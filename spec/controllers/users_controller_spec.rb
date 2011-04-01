require 'spec_helper'

describe UsersController do
  # mock user for use in tests. I don't really understand this and
  # I need to follow up.
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  # render_views is neccessary to look at the resulting html.
  # (i.e. response.should have_selector ...
  render_views

  describe "GET 'new'" do

    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end

    it "should have an email field" do
      get :new
      response.should have_selector("input[name='user[email]'][type='text']")
    end
    
    it "should have a password field" do
      get :new
      response.should 
        have_selector("input[name='user[password]'][type='password']")
    end

    it "should have a password confirmation field" do
      get :new
      response.should have_selector("input[name='user[password_confirmation]'][type='password']")
    end
  end # describe "GET 'new'"

  describe "GET 'index'" do
    
    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(new_user_session_path)
        #flash[:error].should =~ /sign in/i
      end
    end # describe "for non-signed-in users"

    describe "for signed-in users" do
      
      before(:each) do
        # Needed to get authlogic tests to pass
#        activate_authlogic
        # set up the user session for loged in user
        @user = Factory(:user)
        sign_in @user
        second = Factory(:user, :email => "another@example.com")
        third = Factory(:user, :email => "another@example.net")
        # put all three test users into @user as an array
        @users = [@user, second, third]
        # add 30 more users with FactoryGirl.
        30.times do
          # Factory.next(:email) is defined in spec/factories.rb
          @users << Factory(:user, :email => Factory.next(:email))
        end
      end # before(:each)

      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All users")
      end

      it "should have an element for each user" do
        get :index
        @users[0..10].each do |user|
          response.should have_selector("li", :content => user.email)
          response.should_not have_selector("a", :content => "delete" )
        end
      end

      it "should paginate users" do
        get :index
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/users?page=2",
                                      :content => "2")
        response.should have_selector("a", :href => "/users?page=2",
                                      :content => "Next")
      end
    end # describe "for signed-in users"
  end # describe "GET 'index'"

  describe "GET 'show'" do

    before (:each) do
      @user = Factory(:user)
      sign_in @user
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should have the right title" #do
#      get :show, :id => @user
#      response.should have_selector("title", :content => @user.username)
#    end

    it "should include the user's name" #do
#      get :show, :id => @user
#      response.should have_selector("h1", :content => @user.username)
#    end

    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end

    it "should show a link to take the Hartman Value Profile" do
      get :show, :id => @user
      response.should have_selector("a", :content => "Hartman Value Profile")
    end
  end
  
  describe "POST 'create'" do

    describe "failure" do
      
      before(:each) do
        @attr = {:username => "", :email => "", :password => "", 
          :password_confirmation => "" }
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
      
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Sign up")
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :email => "user@example.com", :password => "foobar", 
          :password_confirmation => "foobar" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should sign the user in" #do
#        post :create, :user => @attr
        # @user_session = UserSession.find
        # @user_session.user.should_not == nil
#        @user = User.where(:email => @attr['email']).first
#        @user.user_signed_in?.should == true
# TODO: make sure that the user that was just created is the signed in user
#        controller.should be_signed_in
#      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end

      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to highr/i
      end
    end # describe "success"
  end # describe "POST 'create'"

  describe "GET 'edit'" do
    
    before(:each) do
      @user = Factory.create(:user)
      sign_in @user
    end

    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @user
      response.should have_selector("title", :content => "Edit user")
    end

    it "should have a link to change the Gravatar" do
      get :edit, :id => @user
      gravatar_url = "http://gravatar.com/emails"
      response.should have_selector("a", :href => gravatar_url,
                                    :content => "change")
    end
  end # describe "GET 'edit'"

  describe "PUT 'update'"do

    before(:each) do
      @user = Factory.create(:user)
      # @request.env['devise.mapping'] = :user
      # @user.confirm!
      sign_in @user
    end

    describe "failure" do

      before(:each) do
        @attr = { :email => "", :username => "", :password => "",
          :password_confirmation => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end
      
      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector("title", :content => "Edit user")
      end
    end # describe "failure"

    describe "success" do
      
      before(:each) do
        @attr = { :email => "user@example.org",
          :password => "barbaz", :password_confirmation => "barbaz" }
      end

      it "should change the user's attributes" do

        put :update, :id => @user, :user => @attr
        @user.reload
        @user.email.should == @attr[:email]
      end

      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/
      end
    end # describe "success" 
  end # describe "PUT" 'update'"

  describe "authentication of edit/update pages" do
    
    before(:each) do
      @user = Factory(:user)
    end

    describe "for non-signed-in users" do
      
      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(new_user_session_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(new_user_session_path)
      end
    end # describe "for non-signed-in user"

    describe "for signed-in users" do
      
      before(:each) do
#        activate_authlogic
#        user_session = UserSession.create 
#            Factory(:user, :email => "user@example.net")
#        wrong_user = user_session.user
      end

      it "should require matching users for 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(new_user_session_path)
      end

      it "should require matching users for 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(new_user_session_path)
      end
    end # describe "for signed-in users"
  end # describe "authentication of edit/update pages"

  describe "DELETE 'destroy'" do
    
    before(:each) do
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should deny access"  do
        delete :destroy, :id => @user
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
#        activate_authlogic
#        UserSession.create @user
        delete :destroy, :id => @user
        response.should redirect_to(new_user_session_path)
      end
    end

#    describe "as an admin user" do
      
#      before(:each) do
#        activate_authlogic
#        admin = Factory(:user, :email => "admin@example.com", :admin => true)
#        UserSession.create admin
#      end

#      it "should destroy the user" do
#        lambda do
#          delete :destroy, :id => @user
#        end.should change(User, :count).by(-1)
#      end

#      it "should redirect to the users page" do
#        delete :destroy, :id => @user
#        response.should redirect_to(users_path)
#      end

#      it "should show the delete tag on the users page" do
#        get :index
#        response.should have_selector("a", :content => "delete")
#      end
#    end
  end # describe "DELETE 'destroy'"
end # describe UsersController
