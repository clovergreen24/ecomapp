class HomeController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @orders = Order.where(fulfilled: false).order(created_at: :desc).take(5)
    @month_stats={
      sales: Order.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).count,
      revenue: Order.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).sum(:total),
      avg_sale: Order.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).average(:total),
      avg_items: OrderProduct.joins(:order).where(orders: {created_at: Time.now.beginning_of_month..Time.now.end_of_month}).average(:quantity)
    }
    @orders_by_day = Order.where('created_at > ? ', Time.now - 7.days).order(:created_at)
    @orders_by_day = @orders_by_day.group_by { |order| order.created_at.to_date }
    @revenue_by_day= @orders_by_day.map { |day,orders| [day.strftime("%A"), orders.sum(&:total)] }
    if @revenue_by_day.length < 7
      days_of_week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
      data_hash= @revenue_by_day.to_h
      current_day = Date.today.strftime("%A")
      current_day_index = days_of_week.index(current_day)
      next_day_index = current_day_index + 1 % 7
      ordered_days = days_of_week[current_day_index..-1] + days_of_week[0..next_day_index]
      complete_data = ordered_days.map { |day| [day, data_hash.fetch(day,0)] }
      @revenue_by_day = complete_data
    end
  end
end