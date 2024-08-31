class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 10)
    end

    def new
        @article = Article.new
    end

    def edit
    end

    def create
        # render plain: params[:article]
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:notice] = "Article created successfully."
            redirect_to @article
        else
            render "new"
        end
    end

    def destroy
        @article.destroy
        redirect_to article_path
    end

    def update
        if @article.update(article_params)
            flash[:notice] = "Article updated successfully."
            redirect_to @article
        else
            render 'edit'
        end
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description, :user_id)
    end

    def require_same_user
        if @article.user != current_user
            flash[:alert] = "You don't have permission to edit or delete this article"
            redirect_to @article
        end
    end

end