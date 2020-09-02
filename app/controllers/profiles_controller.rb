class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :show, :new, :create ]

  def index
    @users = User.all.where(company: current_user.company)
    @profiles = Profile.all.where(user: @users)
  end

  def show
    @profile = Profile.find(params[:id])
  end
  
  def new
    @profile = Profile.new
    @department = Department.all
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      redirect_to @profile, notice: 'Cadastrado com sucesso!'
    else
      @department = Department.all
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile)
          .permit(:full_name, :chosen_name, :birthday, :work_address, :position, :sector, :department_id, :user_id)
  end
end