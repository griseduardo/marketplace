class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :show, :new, :create, :edit, :update ]

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

  def edit
    @profile = Profile.find(params[:id])
    @department = Department.all
  end
  
  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to edit_profile_path(@profile), notice: 'Atualizado com sucesso!'
    else
      @department = Department.all
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile)
          .permit(:full_name, :chosen_name, :birthday, :work_address, :position, :sector, :department_id, :user_id)
  end
end