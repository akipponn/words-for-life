require 'openssl'

class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  def play
    @message = Message.find_by_mid(params[:mid])
    
    respond_to do |format|
      if params[:edit] && @message.user_id == session[:user_id]
        format.html { render :template => 'messages/edit' }
      elsif params[:delete] && @message.user_id == session[:user_id]
        @message.destroy
        format.html { redirect_to :my_messages }
      else
        if @message
          format.html
          format.json { render json: @message }
        else
          format.html { redirect_to :root }
        end
      end
    end
  end

  def my_messages
    # list
    @current_user = current_user
    @message = Message.new
    if @current_user
      @messages = Message.where(:user_id => session[:user_id])
      respond_to do |format|
        format.html
      end
    else
      respond_to do |format|
        format.html { redirect_to :root}
      end
    end
    # raise @messages.to_yaml
    # ログインしていない人にはログインするようにうながす template のなかでいいのか。
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    # @message = Message.find(params[:id])
    # @message = Message.find_by_mid(params[:id])
    
    respond_to do |format|
      format.html { redirect_to :root}
#      format.html # show.html.erb
#      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

# GET /messages/1/edit
#  def edit
#    @message = Message.find(params[:id])
#    respond_to do |format|
#      if @message.user_id == session[:user_id]
#        format.html # new.html.erb
#        format.json { render json: @message }
#      else
#        format.html { redirect_to @message, notice: 'You can only edit messages you created.' }
#      #        format.json { render json: @message, status: :error, location: @message }
#      end
#    end
#  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])

    if session[:user_id]
      @message.user_id = session[:user_id]
    end

    @message.mid = random_string()

    respond_to do |format|
      if @message.save
        format.html { redirect_to :action => :play, :mid => @message.mid} #, notice: 'Message was successfully created.' }
#       format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find_by_mid(params[:mid])

    respond_to do |format|
      if @message.user_id == session[:user_id]
        if @message.update_attributes(params[:message])
          format.html { redirect_to :action => :play, :mid => @message.mid} #, notice: 'Message was successfully created.' }
#          format.html { redirect_to @message, notice: 'Message was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @message, notice: 'You can only edit messages you created.' }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  # def destroy
    # @message = Message.find(params[:id])
    # @message.destroy
# 
    # respond_to do |format|
      # if @message.user_id == session[:user_id]
        # format.html { redirect_to messages_url }
        # format.json { head :ok }
      # else
        # format.html { redirect_to @message, notice: 'You can only delete messages you created.' }
      # end
    # end
  # end
end
