class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :show, :new, :create, :edit, :update ]
  before_action :verify_profile, only: [ :edit ]

  def index
    @users = User.all.where(company: current_user.company)
    @profiles = Profile.all.where(user: @users)
  end

  def show
    @profile = Profile.find(params[:id])
    @products = Product.where(profile: @profile)
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
      render :new, layout: false
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

  def search
    @profile = Profile.find(params[:id])
    @product_subcategories = ProductSubcategory.where('name LIKE ?', "%#{params[:q]}%")
    @products = Product.where(profile: @profile).where('name LIKE ?', "%#{params[:q]}%")
                .or(Product.where(profile: @profile, product_subcategory: @product_subcategories))
                .or(Product.where(profile: @profile).where('description LIKE ?', "%#{params[:q]}%"))
    render :show
  end

  private

  def profile_params
    params.require(:profile)
          .permit(:full_name, :chosen_name, :birthday, :work_address, :position, :sector, :department_id, :user_id)
  end

  def verify_profile
    unless current_user.profile == Profile.find(params[:id])
      redirect_to root_path, notice: 'Somente pode editar seu próprio perfil!'
    end
  end
end