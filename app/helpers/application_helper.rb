module ApplicationHelper
  include Pagy::Frontend
  def full_title page_title
    base_title = t ".base_title"
    page_title.empty? ? base_title : [page_title, base_title].join(" | ")
  end

  def check_image? obj, file_img
    obj.attached? ? obj : file_img
  end
end
