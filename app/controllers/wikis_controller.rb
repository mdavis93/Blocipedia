class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki successfully created!"
      redirect_to @wiki
    else
      puts "Error Saving Wiki\n\n#{@wiki.errors.full_messages}\n\n"
      flash[:alert] = "There was an error processing your Wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki updated successfully!"
      redirect_to @wiki
    else
      puts "Error Updating Wiki\n\n#{@wiki.errors.full_messages}\n\n"
      flash[:alert] = "There was an error processing your Wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" Wiki destroyed successfully!"
      redirect_to action: :index
    else
      puts "Error Updating Wiki\n\n#{@wiki.errors.full_messages}\n\n"
      flash[:alert] = "There was an error processing your Wiki. Please try again."
      render :show
    end
  end



  private
  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
end
