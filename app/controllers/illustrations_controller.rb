class IllustrationsController < ApplicationController
  private

  def illustration_params
    params.require(:illustration).permit(:name, :description, :position)
  end
end
