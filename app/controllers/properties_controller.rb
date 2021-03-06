class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :set_property_group, only: [:new, :edit]
  before_action :validate_is_group, only: [:new, :edit]

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.where( user_id: current_user.id ).order( :group_id )
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save
        format.html { redirect_to properties_path, notice: '登録しました。' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to properties_path, notice: '更新しました。' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: '削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])

      # user_idが一致しているかチェック
      if is_invalid_user? ( @property.user_id )
        redirect_to root_path
      end
    end

    def set_property_group
      @property_group = PropertyGroup.where( user_id: current_user.id )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:user_id, :group_id, :name, :stock)
    end

    def validate_is_group
      # 費目未登録の場合
      redirect_to new_property_group_path, notice: "費目の登録を行ってください。" if @property_group.empty?
    end
end
