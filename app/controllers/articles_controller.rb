class ArticlesController < ApplicationController

    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
        #@article = Article.find(params[:id])
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def new
        @article = Article.new
    end

    def edit
        #@article = Article.find(params[:id])
    end

    def create
        #render plain: params[:article]
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            #redirect_to article_path(@article)
            flash[:notice] = "Article was successfully created!"
            redirect_to @article
        else
            render 'new'
        end
    end

    def update
        #@article = Article.find(params[:id])
        if @article.update(article_params)
            flash[:notice] = "Article was successfully edited."
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        #@article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)   
    end

    def require_same_user
        unless current_user == @article.user
            flash[:notice] = "You cannot edit other users' articles."
            redirect_to @article
        end
    end

end