class Api::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_resource, only: [ :show, :update, :destroy ]

  def index
    render json: resource_class.all.where(index_filter_query)
  end

  def show
    render json: @resource
  end

  def create
    resource = resource_class.new(resource_params)
    if resource.save
      render json: resource, status: :created
    else
      render json: { errors: resource.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @resource.update(resource_params)
      render json: @resource
    else
      render json: { errors: @resource.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @resource.destroy
    head :no_content
  end

  private

  def set_resource
    @resource = resource_class.find(params[:id])
  end

  def resource_class
    @resource_class ||= controller_name.classify.constantize
  end

  def resource_params
    send("#{controller_name.singularize}_params")
  end
end
