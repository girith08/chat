class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom, only: [:show, :edit, :update, :destroy]

  # GET /chatrooms
  # GET /chatrooms.json
  def index
    @chatrooms = Chatroom.public_channels
  end

  # GET /chatrooms/1
  # GET /chatrooms/1.json
  def show
    @messages = @chatroom.messages
    @chatroom_user = current_user.chatroom_users.find_by(chatroom_id: @chatroom.id) if current_user
  end

  # GET /chatrooms/new
  def new
    @chatroom = Chatroom.new
  end

  # GET /chatrooms/1/edit
  def edit; end

  # POST /chatrooms
  # POST /chatrooms.json
  def create
    if params[:chatroom][:visibility] == 'private'
      users = []
      users = params[:user_ids].map { |id| User.find(id) } if params[:user_ids]
      users << current_user
      name = params[:chatroom][:name]
      @chatroom = Chatroom.private_chat(users, name)
    else
      @chatroom = Chatroom.new(chatroom_params)
    end
    respond_to do |format|
      if @chatroom.save && current_user
        @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
        format.html { redirect_to @chatroom, notice: 'Chatroom was successfully created.' }
        format.json { render :show, status: :created, location: @chatroom }
      else
        format.html { render :new }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chatrooms/1
  # PATCH/PUT /chatrooms/1.json
  def update
    if params[:chatroom][:visibility] = 'private'
      users = []
      users = params[:user_ids].map { |id| User.find(id) } if params[:user_ids]
      name = params[:chatroom][:name]
      @chatroom.update(chatroom_params)
      @chatroom = Chatroom.private_chat(users, name)
    else
      @chatroom.update(chatroom_params)
    end
    respond_to do |format|
      if @chatroom.update(chatroom_params)
        format.html { redirect_to @chatroom, notice: 'Chatroom was successfully updated.' }
        format.json { render :show, status: :ok, location: @chatroom }
      else
        format.html { render :edit }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatrooms/1
  # DELETE /chatrooms/1.json
  def destroy
    @chatroom.destroy
    respond_to do |format|
      format.html { redirect_to chatrooms_url, notice: 'Chatroom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  def chatroom_params
    params.require(:chatroom).permit(:name, :visibility)
  end
end
