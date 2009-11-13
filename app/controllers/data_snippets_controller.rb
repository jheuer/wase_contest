class DataSnippetsController < ApplicationController
  protect_from_forgery :except => [:create, :update]
  
  # GET /data_snippets
  # GET /data_snippets.xml
  def index
    @data_snippets = DataSnippet.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @data_snippets }
    end
  end

  # GET /data_snippets/1
  # GET /data_snippets/1.xml
  def show
    @data_snippet = DataSnippet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @data_snippet }
      format.json { render :json => @data_snippet.attributes.to_json }
    end
  end

  # GET /data_snippets/new
  # GET /data_snippets/new.xml
  def new
    @data_snippet = DataSnippet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @data_snippet }
    end
  end

  # GET /data_snippets/1/edit
  def edit
    @data_snippet = DataSnippet.find(params[:id])
  end

  # POST /data_snippets
  # POST /data_snippets.xml
  def create
    @data_snippet = DataSnippet.new(params[:data_snippet])

    respond_to do |format|
      if @data_snippet.save
        flash[:notice] = 'DataSnippet was successfully created.'
        format.html { redirect_to(@data_snippet) }
        format.xml  { render :xml => @data_snippet, :status => :created, :location => @data_snippet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @data_snippet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /data_snippets/1
  # PUT /data_snippets/1.xml
  def update
    @data_snippet = DataSnippet.find(params[:id])

    respond_to do |format|
      if @data_snippet.update_attributes(params[:data_snippet])
        flash[:notice] = 'DataSnippet was successfully updated.'
        format.html { redirect_to(@data_snippet) }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @data_snippet.errors, :status => :unprocessable_entity }
        format.json  { render :json => @data_snippet.errors, :status => :unprocessable_entity }
      end
    end
  end

#  # DELETE /data_snippets/1
#  # DELETE /data_snippets/1.xml
#  def destroy
#    @data_snippet = DataSnippet.find(params[:id])
#    @data_snippet.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(data_snippets_url) }
#      format.xml  { head :ok }
#    end
#  end
end
