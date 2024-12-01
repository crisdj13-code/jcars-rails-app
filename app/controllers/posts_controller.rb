class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :check_admin, only: [:new, :create, :destroy]

  # GET /posts or /posts.json
  def index
    @posts = Post.includes(:car)

    #Post filtering, remember to take out string interpolation from the queries 
    if params[:title].present?
      filter = params[:title]
      @posts = @posts.where("title LIKE ?", "%#{filter}%")
    end

    # Car filtering
    if params[:make].present?
      filter = params[:make]
      @posts = @posts.joins(:car).where("cars.make LIKE ?", "%#{filter}%")
    end

    if params[:price].present?
      filter = params[:price]
      @posts = @posts.joins(:car).where('cars.price <= ?', filter)
    end

    if params[:vin].present?
      filter= params[:vin]
      @posts = @posts.joins(:car).where(cars: { vin: filter })
    end

    #if params[:description].present?
      #@posts = @posts.joins(:car).where("cars.description LIKE ?", "%#{params[:description]}%")
   # end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.build_car # Initialize a car object for the form
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        Rails.logger.debug "Post created successfully: #{@post.inspect}"
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }

      else
        Rails.logger.debug "Post creation failed: #{@post.errors.full_messages}"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }

      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
    def check_admin
      redirect_to root_path, alert: "You are not authorized to perform this action." unless current_user.admin?
    end
    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(
        :title,
        :content,
        images: [],
        car_attributes: [
          :make,
          :price,
          :vin,
          :description,
          :year,
          :date_arrived,
          :date_sold
        ]
      )
    end
end
