class Admins::AdminsController < ApplicationController
  before_action :set_user, only: [:edit, :show, :update, :destroy, :new_employee_rating,:human_resources,:human_resources_test,:human_resources_test1, :edit_team_rating, :ytd_dynamic, :avg_dynamic]

  include ApplicationHelper



  # GET /users
  # GET /users.json
  def index
    @admins = Admin.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @admins = Admin.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    #TODO this needs to be deleted/handled with UI or different function
    if @user.password.nil?
      generated_password = Devise.friendly_token.first(8)
      @user.password = generated_password
      @user.password_confirmation = @user.password
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        if request.xhr?
          format.html { redirect_to :back }
          format.json { render :new_employee_rating, status: :ok }
        else
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        end
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      id = (params[:id]) || current_user.id
      @user = User.find(id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      # params.fetch(:user, {})
      params.require(:user).permit(:id, :first_name, :last_name, :title, :is_current, :start_date, :email, :is_officer, :is_admin, :next_performance_review, :password, :password_confirmation,:user_headshot, :id, :review_item_id, :review_items_by_role_id, :is_active,:rated_by_user_id, :notes_allowed, :rate_period, :rating, :is_team, :pros, :cons, :notes, :user_reviews, :form_role_id, user_reviews_attributes: [:id, :review_item_id, :rated_by_user_id, :notes_allowed, :rate_period, :rating, :is_team, :pros, :cons, :notes, :checked, :multiplier, review_notes_attributes: [:user_review_id, :general_notes, :pros, :cons] ],)
    end



end
