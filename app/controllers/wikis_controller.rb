class WikisController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    if policy(Wiki.find(params[:id])).show?
      @wiki = Wiki.find(params[:id])
    else
      flash[:alert] = "You are not authorized to do that!"
      if !current_user
        redirect_to new_user_session_path
      else
        redirect_to wikis_path
      end
    end
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)

    if @wiki.save
      if @wiki.private?
        flash[:notice] = "Private Wiki successfully created!"
      else
        flash[:notice] = "Wiki successfully created!"
      end
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error processing your Wiki. Please try again."
      render :new
    end
  end

  def edit
    if policy(Wiki.find(params[:id])).edit?
      @wiki = Wiki.find(params[:id])
    else
      flash[:alert] = "You are not authorized to do that!"
      if !current_user
        redirect_to new_user_session_path
      else
        redirect_to wikis_path
      end
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki updated successfully!"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error processing your Wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" Wiki destroyed successfully!"
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error processing your Wiki. Please try again."
      render :show
    end
  end



  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
