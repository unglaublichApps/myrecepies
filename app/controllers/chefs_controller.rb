class ChefsController < ApplicationController

  before_action :set_chef, only: [:show, :edit, :update, :delete]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      session[:chef_id] = @chef.id
      flash[:success] = "Welcome #{@chef.chefname} to my recipe App"
      redirect_to chef_path(@chef)
    else
      render 'new'
    end

  end

  def show
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end

  def edit
  end

  def update
    if @chef.update(chef_params)
      flash[:success] = "Your account was updated"
      redirect_to @chef
    else
      render 'edit'
    end
  end

  def destroy
    @chef.destroy
    flash[:danger] = "Chef and all his reicipes have been deleted!"
    redirect_to chefs_path
  end



  private
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
    end

    def set_chef
      @chef = Chef.find(params[:id])
    end

    def require_same_user
      if current_chef != @chef
        flash[:danger] = "You can only edit your own profile"
        redirect_to chefs_path
      end
    end

end
