class Admins::AdminsController < ApplicationController
  before_action :set_admin, only: [:edit, :show, :update, :destroy]

  include ApplicationHelper

  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
    @admins = Admin.all
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

    #TODO this needs to be deleted/handled with UI or different function
    if @admin.password.nil?
      generated_password = Devise.friendly_token.first(8)
      @admin.password = generated_password
      @admin.password_confirmation = @admin.password
    end

    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, notice: 'admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        if request.xhr?
          format.html { redirect_to :back }
          format.json { render :new_employee_rating, status: :ok }
        else
          format.html { redirect_to @admin, notice: 'admin was successfully updated.' }
          format.json { render :show, status: :ok, location: @admin }
        end
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      id = (params[:id]) || current_admin.id
      @admin = Admin.find(id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      # params.fetch(:admin, {})
      params.require(:admin).permit(:id, :first_name, :last_name, :email, :password, :password_confirmation)
    end
end
