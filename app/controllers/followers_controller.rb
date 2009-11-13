class FollowersController < ApplicationController
  # GET /followers
  # GET /followers.xml
  def index
    @followers = Follower.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @followers }
    end
  end

  # GET /followers/1
  # GET /followers/1.xml
  def show
    @follower = Follower.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @follower }
    end
  end

  # GET /followers/new
  # GET /followers/new.xml
  def new
    @follower = Follower.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @follower }
    end
  end

  # GET /followers/1/edit
  def edit
    @follower = Follower.find(params[:id])
  end

  # POST /followers
  # POST /followers.xml
  def create
    @follower = Follower.new(params[:follower])

    respond_to do |format|
      if @follower.save
        flash[:notice] = 'Follower was successfully created.'
        format.html { redirect_to(@follower) }
        format.xml  { render :xml => @follower, :status => :created, :location => @follower }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @follower.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /followers/1
  # PUT /followers/1.xml
  def update
    @follower = Follower.find(params[:id])

    respond_to do |format|
      if @follower.update_attributes(params[:follower])
        flash[:notice] = 'Follower was successfully updated.'
        format.html { redirect_to(@follower) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @follower.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /followers/1
  # DELETE /followers/1.xml
  def destroy
    @follower = Follower.find(params[:id])
    @follower.destroy

    respond_to do |format|
      format.html { redirect_to(followers_url) }
      format.xml  { head :ok }
    end
  end
end
