# Причины
# @example
#   #<Reason id: 2, text: "Страной правят геи", popularity: 12313, created_at: "2014-02-15 11:03:31", updated_at: "2014-02-17 07:32:35">
class Reason < ActiveRecord::Base
  include Paginated
  scope :random_one, -> {order("RANDOM()").select(:text).first}
  scope :random_three, -> {order("RANDOM()").limit(3)}
  scope :popular, -> {order(:popularity, :updated_at).reverse_order}

  scope :find_downcase, -> (downcase_text) {where('lower(text) like ?', "%#{downcase_text}%")}

  validates :text, :uniqueness => {:case_sensitive => false, :message => "такая причина уже есть"}
  validates_length_of :text, :minimum => 2, :maximum => 81, :message => "должен быть длиной от 2 до 81 символа"


  # Либо сохраняет новую причину, либо увеличивает статистику популярности у существующей
  # @note Вызывается при нажатии по соц кнопке
  # @example
  #   Reason.first.try_to_save
  #
  # @see StatsController#update_reason
  def try_to_save
    downcase_text = self.text.mb_chars.downcase.to_s
    reason = Reason.find_downcase(downcase_text)
    reason.present? ? reason.first.increase_popularity : self.save
  end


  # Увеличивает статистику популярности у причины
  # @note Вызывается при нажатии по соц кнопке
  # @example
  #   Reason.increase_popularity
  #
  # @see Reason#try_to_save
  def increase_popularity
    self.update(popularity: self.popularity + 1)
  end
end
