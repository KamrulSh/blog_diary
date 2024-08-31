class ArticlesController < ApplicationController

    def show
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 10)
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
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
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to article_path
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            flash[:notice] = "Article updated successfully."
            redirect_to @article
        else
            render 'edit'
        end
    end

    private

    def article_params
        params.require(:article).permit(:title, :description, :user_id)
    end

end