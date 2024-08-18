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
        @article = Article.new(params.require(:article).permit(:title, :description, :user_id))
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
        if @article.update(params.require(:article).permit(:title, :description, :user_id))
            flash[:notice] = "Article updated successfully."
            redirect_to @article
        else
            render 'edit'
        end
    end

    

end