class ArticlesController < ApplicationController
	def index
		@article = Article.all
	end

	def new
		@article = Article.new
	end

	def create
		# render plain: params[:article].inspect 
		@article = Article.new(article_params)
		# article_params is a method defined below that is being passed in here
		if @article.save
			flash[:notice] = "Article was successfully created"
			redirect_to article_path(@article)
		else
			render 'new'
		end
		# @article.save
		# redirect_to article_path(@article)
	end

	def show
		@article = Article.find(params[:id])
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:notice] = "Article was successfully updated!"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	private

	def article_params
		params.require(:article).permit(:title, :description)
		# :article is top level key, permit the following values
	end

end